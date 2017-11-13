//
//  AddBillCollectionViewController.m
//  BookKeepingSpecialist
//
//  Created by adlerkismet on 2017/4/2.
//  Copyright © 2017年 adlerkismet. All rights reserved.
//

#import "AddBillCollectionViewController.h"
#import "BillTypeCollectionViewCell.h"
#import "AddBillType.h"
#import "AddBillViewController.h"
#import <Realm/Realm.h>
#import "RLMBillType.h"
#import "Define.h"
#import "MKDropdownMenu.h"
@interface AddBillCollectionViewController ()<MKDropdownMenuDataSource,MKDropdownMenuDelegate>
@property (strong,nonatomic) NSMutableArray<AddBillType*> *dataArray;
@property (strong,nonatomic) RLMResults<RLMBillType*> *typeDataArray;
@property (nonatomic) ExpensesType expenseType;
@end

@implementation AddBillCollectionViewController

//static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
//    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat itemWidth = (screenWidth - 10*8)/4;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 10;
    layout.itemSize = CGSizeMake(itemWidth, itemWidth);
    
    [self.collectionView setCollectionViewLayout:layout];
    
    _expenseType = ExpensesTypePayment;
    
    MKDropdownMenu *titleMune = [[MKDropdownMenu alloc]initWithFrame:CGRectMake(0, 0, 80, 22)];
    titleMune.delegate = self;
    titleMune.dataSource = self;
    titleMune.rowTextAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = titleMune;
//    [self initDataArray];
//    [self initData];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self requestData];
    [self.collectionView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - MKDrop Down Menu Data Source
-(NSInteger)numberOfComponentsInDropdownMenu:(MKDropdownMenu *)dropdownMenu{
    return 1;
}

-(NSInteger)dropdownMenu:(MKDropdownMenu *)dropdownMenu numberOfRowsInComponent:(NSInteger)component{
    return 2;
}

#pragma mark - MKDrop Down Menu Delegate
- (void)dropdownMenu:(MKDropdownMenu *)dropdownMenu didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (row == 0) {
        _expenseType = ExpensesTypePayment;
    } else {
        _expenseType = ExpensesTypeIncome;
    }
    [self requestData];
    [self.collectionView reloadData];
    [dropdownMenu reloadAllComponents];
    [dropdownMenu closeAllComponentsAnimated:YES];
}

- (nullable NSString *)dropdownMenu:(MKDropdownMenu *)dropdownMenu titleForComponent:(NSInteger)component{
    if (_expenseType == ExpensesTypePayment) {
        return @"支出";
    } else {
        return @"收入";
    }
}

- (nullable NSString *)dropdownMenu:(MKDropdownMenu *)dropdownMenu titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (row) {
        return @"收入";
    } else {
        return @"支出";
    }
}

#pragma mark - <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//    return _dataArray.count;
    return _typeDataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
//    AddBillType *type = _dataArray[indexPath.row];
    RLMBillType *type = _typeDataArray[indexPath.row];
    BillTypeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([BillTypeCollectionViewCell class]) forIndexPath:indexPath];
    cell.typeImageView.image = [type typeImage];
    cell.typeNameLabel.text = type.strDescription;
    // Configure the cell
    
    return cell;
}

#pragma mark - <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    AddBillViewController *abvc = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([AddBillViewController class])];
    abvc.type = _typeDataArray[indexPath.row];
    [self.navigationController pushViewController:abvc animated:YES];
}
/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

#pragma  mark - Init Data
- (void)initData{
    RLMRealm *realm = [RLMRealm defaultRealm];
    if ([RLMBillType allObjects].count == 0) {
        //expanses is payment
        for (NSUInteger i = 0; i <= BillTypeVegetable; i ++) {
            [realm transactionWithBlock:^{
                RLMBillType *billType = [[RLMBillType alloc]init];
                billType.id = [NSUUID UUID].UUIDString;
                billType.type = i;
                billType.expensesType = ExpensesTypePayment;
                billType.strDescription = [self descriptionFromType:i];
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
                billType.expensesType = ExpensesTypeIncome;
                billType.strDescription = [self descriptionFromType:i];
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
}

- (void)requestData{
    self.typeDataArray = [RLMBillType objectsWhere:@"expensesType = %ld",_expenseType];
}


- (NSString*)descriptionFromType:(BillType)type{
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

@end
