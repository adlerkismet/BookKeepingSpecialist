//
//  DetailViewController.m
//  BookKeepingSpecialist
//
//  Created by adlerkismet on 2017/3/7.
//  Copyright © 2017年 adlerkismet. All rights reserved.
//

#import "DetailViewController.h"
#import <Realm/Realm.h>
#import "DetailTableViewCell.h"
#import "AddBillCollectionViewController.h"
//#import "DetailBill.h"
#import "RLMBill.h"
#import "Define.h"
#import "BillHeaderView.h"
#import "OverlayTransitioner.h"
#import "DatePickerViewController.h"
#import "DateTools.h"
#import "AddBillViewController.h"
#import <UIKit/UIKit.h>
@interface DetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *yearLabel;
@property (weak, nonatomic) IBOutlet UILabel *monthLabel;
@property (weak, nonatomic) IBOutlet UILabel *paymentValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *incomeValueLabel;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITableViewHeaderFooterView *headerView;

@property (strong,nonatomic) NSDate *selectedDate;

//@property (strong,nonatomic) RLMResults<RLMBill*> *dataArray;
@property (strong,nonatomic) NSMutableArray<RLMResults*> *dataArray;
@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    UINib *nib = [UINib nibWithNibName:@"HeaderView" bundle:nil];
    [self.tableView registerNib:nib forHeaderFooterViewReuseIdentifier:NSStringFromClass([BillHeaderView class])];
    self.tableView.tableFooterView = [[UIView alloc]init];
    self.selectedDate = [NSDate date];
    [self initData];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    UILabel *itemTitleView = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 22)];
    self.tabBarController.navigationItem.titleView = itemTitleView;
    self.tabBarController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addBill)];
    [self requestDatas];
    self.incomeValueLabel.text = [self stringFromPrefix:@"" value:[self valueFromExpensesType:ExpensesTypeIncome]];
    self.paymentValueLabel.text = [self stringFromPrefix:@"" value:-[self valueFromExpensesType:ExpensesTypePayment]];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setSelectedDate:(NSDate *)selectedDate{
    _selectedDate = selectedDate;
    //年▾
    self.yearLabel.text = [NSString stringWithFormat:@"%ld年",self.selectedDate.year];
    self.monthLabel.text = [NSString stringWithFormat:@"%ld月▾",self.selectedDate.month];
}

#pragma mark - UITableview Data Source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray[section].count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RLMBill *bill = _dataArray[indexPath.section][indexPath.row];
    DetailTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:NSStringFromClass([DetailTableViewCell class])];
    if (bill.strDescription) {
        cell.typeNameLabel.text = bill.strDescription;
    } else {
        cell.typeNameLabel.text = [bill typeDescription];
    }
    double i = 0;
    double ret = modf([bill.value doubleValue], &i);
    if (ret!=0) {
        cell.valueLabel.text = [NSString stringWithFormat:@"%.2f",[bill.value floatValue]];
    } else {
        cell.valueLabel.text = [NSString stringWithFormat:@"%ld",[bill.value integerValue]];
    }
//    cell.valueLabel.text = [NSString stringWithFormat:@"%.2f",[bill.value floatValue]];
    cell.typeImageView.image = [self typeImageFromBillType:bill.type.type];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    RLMBill *bill = _dataArray[indexPath.section][indexPath.row];
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm transactionWithBlock:^{
        [realm deleteObject:bill];
        [realm commitWriteTransaction];
    }];
    [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationTop];
    [self requestDatas];
    [tableView reloadData];
}


- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    BillHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass([BillHeaderView class])];
    //date Label
    NSDate *date = [_dataArray[section][0] valueForKey:@"date"];
    headerView.dateLabel.text = [NSString stringWithFormat:@"%ld月%ld号 %@",date.month,date.day,[self stringFromWeekday:date.weekday]];
    
    //value Label
    float payment = 0;
    float income = 0;
    for (NSUInteger i = 0; i < _dataArray[section].count; i ++) {
        if ([_dataArray[section][i][@"value"] floatValue] > 0) {
            income = income + [_dataArray[section][i][@"value"] floatValue];
        } else {
            payment = payment + [_dataArray[section][i][@"value"] floatValue];
        }
    }
    if (payment&&income) {
        headerView.valueLabel.text = [NSString stringWithFormat:@"%@ %@",[self stringFromPrefix:@"支出:" value:-payment],[self stringFromPrefix:@"收入:" value:income]];
    } else {
        if (payment) {
            headerView.valueLabel.text = [self stringFromPrefix:@"支出:" value:-payment];
        } else {
            headerView.valueLabel.text = [self stringFromPrefix:@"收入:" value:income];
        }
    }
    return headerView;
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 28;
}

#pragma mark - UITableView Delegate
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return   UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AddBillViewController *abvc = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([AddBillViewController class])];
    abvc.editingBill = _dataArray[indexPath.section][indexPath.row];
    [self.navigationController pushViewController:abvc animated:YES];
}
#pragma mark - IBAction
- (IBAction)tapAction:(id)sender {
    DatePickerViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([DatePickerViewController class])];
    OverlayTransitioningDelegate *viewTransitioningDelegate = [[OverlayTransitioningDelegate alloc]init];
    [controller setTransitioningDelegate:viewTransitioningDelegate];
    controller.currentSelectedDate = _selectedDate;
    controller.backDateBlock = ^(NSDate *backDate){
        self.selectedDate = backDate;
        [self requestDatas];
        self.incomeValueLabel.text = [self stringFromPrefix:@"" value:[self valueFromExpensesType:ExpensesTypeIncome]];
        self.paymentValueLabel.text = [self stringFromPrefix:@"" value:-[self valueFromExpensesType:ExpensesTypePayment]];
        [self.tableView reloadData];
    };
    [self presentViewController:controller animated:YES completion:NULL];
    NSLog(@"It's tap!");
}

- (void)addBill{
    AddBillCollectionViewController *abvc = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([AddBillCollectionViewController class])];
    [self.navigationController pushViewController:abvc animated:YES];
}

#pragma mark - Data
- (void)initData{
    RLMRealm *realm = [RLMRealm defaultRealm];
//    [realm transactionWithBlock:^{
//        [realm deleteObjects:[RLMBill allObjects]];
//        [realm deleteObjects:[RLMBillType allObjects]];
//        [realm commitWriteTransaction];
//    }];
    RLMResults *bills = [RLMBill allObjects];
    if (_dataArray == nil) {
        self.dataArray = [[NSMutableArray alloc]init];
    }
    if ([RLMBillType allObjects].count == 0) {
        //expanses is payment
        for (NSUInteger i = BillTypeBook; i <= BillTypeVegetable; i ++) {
            [realm transactionWithBlock:^{
                RLMBillType *billType = [[RLMBillType alloc]init];
                billType.id = [NSUUID UUID].UUIDString;
                billType.type = i;
                billType.expensesType = ExpensesTypePayment;
                billType.strDescription = [billType typeDescriptionFromType:i];
                [realm addOrUpdateObject:billType];
                [realm commitWriteTransaction];
            }];
        }
        //expanses is income
        for (NSUInteger i = BillTypeFinance; i <= BillTypeDefault; i ++) {
            [realm transactionWithBlock:^{
                RLMBillType *billType = [[RLMBillType alloc]init];
                billType.id = [NSUUID UUID].UUIDString;
                billType.type = i;
                NSLog(@"%ld",billType.type);
                billType.expensesType = ExpensesTypeIncome;
                billType.strDescription = [billType typeDescriptionFromType:i];
                [realm addOrUpdateObject:billType];
                [realm commitWriteTransaction];
            }];
        }
        //setting
        //        [realm transactionWithBlock:^{
        //            RLMBillType *incomeSetting = [[RLMBillType alloc]init];
        //            incomeSetting.id = [NSUUID UUID].UUIDString;
        //            incomeSetting.type = BillTypeSetting;
        //            incomeSetting.expensesType = ExpensesTypeIncome;
        //            incomeSetting.strDescription = @"设置";
        //
        //            RLMBillType *paymentSetting = [[RLMBillType alloc]init];
        //            paymentSetting.id = [NSUUID UUID].UUIDString;
        //            paymentSetting.type = BillTypeSetting;
        //            paymentSetting.expensesType = ExpensesTypePayment;
        //            paymentSetting.strDescription = @"设置";
        //
        //            [realm addOrUpdateObjectsFromArray:@[incomeSetting,paymentSetting]];
        //            [realm commitWriteTransaction];
        //        }];
    }
    if ([bills count] == 0) {
        [realm transactionWithBlock:^{
            NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
            [formatter setDateFormat:@"yyyy-M"];
            for (NSUInteger i = 1; i <= 12; i ++) {
                NSDate *month = [formatter dateFromString:[NSString stringWithFormat:@"2017-%ld",i]];
                for (NSInteger i = 0; i < arc4random()%100; i ++) {
                    RLMBill *bill = [[RLMBill alloc]init];
                    bill.id = [NSUUID UUID].UUIDString;
                    bill.type = [[RLMBillType objectsWhere:[NSString stringWithFormat:@"type = %ld",random()%(NSInteger)BillTypeNumMax]]firstObject];
//                    bill.type.type = random()%(NSInteger)BillTypeNumMax;
                    bill.date = [NSDate dateWithTimeInterval:(arc4random()%2592000) sinceDate:month];
//                    bill.strDescription = [self typeNameFromType:(BillType)bill.type];
                    bill.value = [NSNumber numberWithInteger:[bill currentValueFromValue:(double)(arc4random()%1000) expenseType:bill.type.expensesType]];
                    [realm addObject:bill];
                }
            }
            [realm commitWriteTransaction];
        }];
    }
}

- (void)requestDatas{
    NSMutableArray *result = [[NSMutableArray alloc]init];
    for (NSUInteger i = 1; i <= [self howManyDaysInThisYear:_selectedDate.year withMonth:_selectedDate.month]; i ++) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"yyyy-M"];
        NSString *strStartMDay = [[formatter stringFromDate:_selectedDate] stringByAppendingFormat:@"-%ld",i];
        NSString *strEndDay = [[formatter stringFromDate:_selectedDate] stringByAppendingFormat:@"-%ld",i+1];
        [formatter setDateFormat:@"yyyy-M-d"];
        NSDate *startDay = [formatter dateFromString:strStartMDay];
        NSDate *endDay = [formatter dateFromString:strEndDay];
        RLMResults *billResultsWithDay = [RLMBill objectsWhere:@"date >= %@ AND date < %@",startDay,endDay];
        if (billResultsWithDay.count != 0) {
            [result addObject:billResultsWithDay];
        }
    }
    self.dataArray = result;
}

#pragma mark - tools function
- (NSInteger)howManyDaysInThisYear:(NSInteger)year withMonth:(NSInteger)month{
    if((month == 1) || (month == 3) || (month == 5) || (month == 7) || (month == 8) || (month == 10) || (month == 12))
        return 31 ;
    
    if((month == 4) || (month == 6) || (month == 9) || (month == 11))
        return 30;
    
    if((year % 4 == 1) || (year % 4 == 2) || (year % 4 == 3))
    {
        return 28;
    }
    
    if(year % 400 == 0)
        return 29;
    
    if(year % 100 == 0)
        return 28;
    
    return 29;
}

- (UIImage*)typeImageFromBillType:(BillType)type{
    switch (type) {
        case BillTypeBook:
            return [UIImage imageNamed:@"book_selected.png"];
            break;
        case BillTypeCar:
            return [UIImage imageNamed:@"car_selected.png"];
            break;
        case BillTypeCashGift:
            return [UIImage imageNamed:@"cashGift_selected.png"];
            break;
        case BillTypeChild:
            return [UIImage imageNamed:@"child_selected.png"];
            break;
        case BillTypeClothes:
            return [UIImage imageNamed:@"clothes_selected.png"];
            break;
        case BillTypeCommunication:
            return [UIImage imageNamed:@"communication_selected.png"];
            break;
        case BillTypeDailyNecessities:
            return [UIImage imageNamed:@"dailyNecessities_selected.png"];
            break;
        case BillTypeDigital:
            return [UIImage imageNamed:@"digital_selected.png"];
            break;
        case BillTypeDonate:
            return [UIImage imageNamed:@"donate_selected.png"];
            break;
        case BillTypeElder:
            return [UIImage imageNamed:@"elder_selected.png"];
            break;
        case BillTypeEntertainment:
            return [UIImage imageNamed:@"entertainment_selected.png"];
            break;
        case BillTypeFruits:
            return [UIImage imageNamed:@"fruits_selected.png"];
            break;
        case BillTypeFurniture:
            return [UIImage imageNamed:@"furniture_selected.png"];
            break;
        case BillTypeGift:
            return [UIImage imageNamed:@"gift_selected.png"];
            break;
        case BillTypeHairDressing:
            return [UIImage imageNamed:@"hairdressing_selected.png"];
            break;
        case BillTypeHousing:
            return [UIImage imageNamed:@"housing_selected.png"];
            break;
        case BillTypeLiquor:
            return [UIImage imageNamed:@"liquor_selected.png"];
            break;
        case BillTypeLottery:
            return [UIImage imageNamed:@"lottery_selected.png"];
            break;
        case BillTypeMaintain:
            return [UIImage imageNamed:@"maintain_selected.png"];
            break;
        case BillTypeMedical:
            return [UIImage imageNamed:@"medical_selected.png"];
            break;
        case BillTypeOffice:
            return [UIImage imageNamed:@"office_selected.png"];
            break;
        case BillTypePet:
            return [UIImage imageNamed:@"pet_selected.png"];
            break;
        case BillTypeRestaurant:
            return [UIImage imageNamed:@"restaurant_selected.png"];
            break;
        case BillTypeShopping:
            return [UIImage imageNamed:@"shopping_selected.png"];
            break;
        case BillTypeSnacks:
            return [UIImage imageNamed:@"snacks_selected.png"];
            break;
        case BillTypeSocial:
            return [UIImage imageNamed:@"social_selected.png"];
            break;
        case BillTypeSports:
            return [UIImage imageNamed:@"sports_selected.png"];
            break;
        case BillTypeStudy:
            return [UIImage imageNamed:@"study_selected.png"];
            break;
        case BillTypeTransportation:
            return [UIImage imageNamed:@"transportation_selected.png"];
            break;
        case BillTypeTravel:
            return [UIImage imageNamed:@"travel_selected.png"];
            break;
        case BillTypeVegetable:
            return [UIImage imageNamed:@"vegetable_selected.png"];
            break;
        case BillTypeFinance:
            return [UIImage imageNamed:@"finance_selected.png"];
            break;
        case BillTypeMoney:
            return [UIImage imageNamed:@"money_selected.png"];
            break;
        case BillTypePartTimeJob:
            return [UIImage imageNamed:@"part-time_job_selected.png"];
            break;
        case BillTypeSalary:
            return [UIImage imageNamed:@"salary_selected.png"];
            break;
        case BillTypeDefault:
            return [UIImage imageNamed:@"favorite_selected.png"];
            break;
        case BillTypeSetting:
            return [UIImage imageNamed:@"setting_selected.png"];
            break;
        default:
            return nil;
            break;
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

- (NSString*)stringFromWeekday:(NSInteger)weekday{
    switch (weekday) {
        case 1:
            return @"星期日";
            break;
        case 2:
            return @"星期一";
            break;
        case 3:
            return @"星期二";
            break;
        case 4:
            return @"星期三";
            break;
        case 5:
            return @"星期四";
            break;
        case 6:
            return @"星期五";
            break;
        case 7:
            return @"星期六";
            break;
    }
    return nil;
}

- (NSString*)stringFromPrefix:(NSString*)prefix value:(double)value{
    double i = 0;
    double ret = modf(value, &i);
    if (ret > 0) {
        return [prefix stringByAppendingFormat:@"%.2f",value];
    } else {
        return [prefix stringByAppendingFormat:@"%ld",(long)value];
    }
}

- (double)valueFromExpensesType:(ExpensesType)type{
    double resultValue = 0;
    if (type == ExpensesTypeIncome) {
        NSDate *startDay = [NSDate dateWithYear:_selectedDate.year month:_selectedDate.month day:1];
        NSDate *endDay = [NSDate dateWithYear:_selectedDate.year month:(_selectedDate.month + 1) day:1];
        RLMResults *billResultsWithDay = [[RLMBill objectsWhere:@"date >= %@ AND date < %@ AND value > %@",startDay,endDay,@0]sortedResultsUsingKeyPath:@"date" ascending:NO];
        for (RLMBill *bill in billResultsWithDay) {
            resultValue += [bill.value doubleValue];
        }
    } else {
        NSDate *startDay = [NSDate dateWithYear:_selectedDate.year month:_selectedDate.month day:1];
        NSDate *endDay = [NSDate dateWithYear:_selectedDate.year month:(_selectedDate.month + 1) day:1];
        RLMResults *billResultsWithDay = [[RLMBill objectsWhere:@"date >= %@ AND date < %@  AND value < %@",startDay,endDay,@0]sortedResultsUsingKeyPath:@"date" ascending:NO];
        for (RLMBill *bill in billResultsWithDay) {
            resultValue += [bill.value doubleValue];
        }
    }
    return resultValue;
}

@end
