//
//  AddBillViewController.m
//  BookKeepingSpecialist
//
//  Created by adlerkismet on 2017/4/5.
//  Copyright © 2017年 adlerkismet. All rights reserved.
//

#import "AddBillViewController.h"
#import "RLMBill.h"
#import <Realm/Realm.h>
#import "JGProgressHUD.h"
#import "OverlayTransitioner.h"
#import "DatePickerViewController.h"
#import "DateTools.h"
@interface AddBillViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *typeNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *valueTextField;
@property (weak, nonatomic) IBOutlet UITextField *dateTextField;
@property (strong,nonatomic) UIDatePicker *datePicker;

@end

@implementation AddBillViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.typeNameTextField.delegate = self;
    self.valueTextField.delegate = self;
    self.dateTextField.delegate = self;
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGesture)];
    [self.view addGestureRecognizer:tapGesture];
    
    self.datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width ,200)];
    [self.datePicker drawViewHierarchyInRect:self.datePicker.bounds afterScreenUpdates:NO];
    self.datePicker.datePickerMode = UIDatePickerModeDate;
    self.dateTextField.inputView = (UIView*)_datePicker;
    if (_editingBill) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"yyyy-M-d"];
        self.dateTextField.placeholder = [formatter stringFromDate:_editingBill.date];
        
        self.valueTextField.placeholder = [NSString stringWithFormat:@"%.2f", [_editingBill.value doubleValue]];
        self.typeNameTextField.placeholder = [self typeNameFromType:_editingBill.type.type];
    } else {
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"yyyy-M-d"];
        self.dateTextField.placeholder = [formatter stringFromDate:[NSDate date]];
        
        self.valueTextField.placeholder = @"请输入数值";
        self.typeNameTextField.placeholder = [self typeNameFromType:_type.type];
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (_editingBill) {
        self.title = @"账单修改";
    } else {
        self.title = @"账单创建";
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
- (IBAction)confirmAction:(id)sender {
    if ([_valueTextField.text length] > 0 || [_valueTextField.placeholder doubleValue]) {
        RLMRealm *realm = [RLMRealm defaultRealm];
        [realm transactionWithBlock:^{
            RLMBill *bill = [[RLMBill alloc]init];
            if (_editingBill) {
                bill = _editingBill;
            }else{
                bill.id = [NSUUID UUID].UUIDString;
                bill.type = self.type;
            }
            
            if ([_typeNameTextField.text length] > 0) {
                bill.strDescription = _typeNameTextField.text;
            }
            if ([_dateTextField.text length] > 0) {
                bill.date = _datePicker.date;
            } else {
                NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
                [formatter setDateFormat:@"yyyy-M-d"];
                bill.date = [formatter dateFromString:_dateTextField.placeholder];
            }
            if ([_valueTextField.text length] > 0) {
                bill.value = @([bill currentValueFromValue:[_valueTextField.text doubleValue] expenseType:bill.type.expensesType]);
            } else {
                bill.value = @([_valueTextField.placeholder doubleValue]);
            }
            [realm addOrUpdateObject:bill];
            [realm commitWriteTransaction];
        }];
        
        [self.navigationController popToRootViewControllerAnimated:YES];
    } else {
        JGProgressHUD *HUD = [[JGProgressHUD alloc]initWithStyle:JGProgressHUDStyleDark];
        
        HUD.textLabel.text = @"请输入消费价格!";
        HUD.indicatorView = [[JGProgressHUDErrorIndicatorView alloc] init];
        
        HUD.square = YES;
        
        [HUD showInView:self.view];
        
        [HUD dismissAfterDelay:2.0];
    }
}


- (void)tapGesture{
    if ([self.dateTextField isFirstResponder]) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"yyyy-M-d"];
        self.dateTextField.text = [formatter stringFromDate:_datePicker.date];
        [self.dateTextField resignFirstResponder];
    }
    
    if ([self.valueTextField isFirstResponder]) {
        [self.valueTextField resignFirstResponder];
    }
    
    if ([self.typeNameTextField isFirstResponder]) {
        [self.typeNameTextField resignFirstResponder];
    }
}



- (NSString*)typeNameFromType:(BillType)type{
    switch (type) {
        case BillTypeBook:
            return @"书本";
            break;
        case BillTypeCar:
            return @"汽车";
            break;
        case BillTypeCashGift:
            return @"礼金";
            break;
        case BillTypeChild:
            return @"孩子";
            break;
        case BillTypeClothes:
            return @"衣服";
            break;
        case BillTypeCommunication:
            return @"通讯";
            break;
        case BillTypeDailyNecessities:
            return @"日用品";
            break;
        case BillTypeDigital:
            return @"电子产品";
            break;
        case BillTypeDonate:
            return @"捐赠";
            break;
        case BillTypeElder:
            return @"孝敬老人";
            break;
        case BillTypeEntertainment:
            return @"娱乐";
            break;
        case BillTypeFruits:
            return @"水果";
            break;
        case BillTypeFurniture:
            return @"家具";
            break;
        case BillTypeGift:
            return @"礼物";
            break;
        case BillTypeHairDressing:
            return @"美容美发";
            break;
        case BillTypeHousing:
            return @"房屋";
            break;
        case BillTypeLiquor:
            return @"烟酒";
            break;
        case BillTypeLottery:
            return @"彩票";
            break;
        case BillTypeMaintain:
            return @"维修";
            break;
        case BillTypeMedical:
            return @"医疗";
            break;
        case BillTypeOffice:
            return @"办公用品";
            break;
        case BillTypePet:
            return @"宠物";
            break;
        case BillTypeRestaurant:
            return @"餐饮";
            break;
        case BillTypeShopping:
            return @"购物";
            break;
        case BillTypeSnacks:
            return @"甜品";
            break;
        case BillTypeSocial:
            return @"社交";
            break;
        case BillTypeSports:
            return @"运动";
            break;
        case BillTypeStudy:
            return @"学习";
            break;
        case BillTypeTransportation:
            return @"交通";
            break;
        case BillTypeTravel:
            return @"旅行";
            break;
        case BillTypeVegetable:
            return @"蔬菜";
            break;
        case BillTypeFinance:
            return @"金融理财";
            break;
        case BillTypeMoney:
            return @"其他收入";
            break;
        case BillTypePartTimeJob:
            return @"兼职收入";
            break;
        case BillTypeSalary:
            return @"薪水";
            break;
        case BillTypeDefault:
            return @"默认";
            break;
        case BillTypeSetting:
            return @"设置";
            break;
            
        default:
            return nil;
            break;
    }

}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
