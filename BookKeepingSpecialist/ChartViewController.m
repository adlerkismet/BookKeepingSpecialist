//
//  ChartViewController.m
//  BookKeepingSpecialist
//
//  Created by adlerkismet on 2017/4/1.
//  Copyright © 2017年 adlerkismet. All rights reserved.
//

#import "ChartViewController.h"
#import "MKDropdownMenu/MKDropdownMenu.h"
#import <Realm/Realm.h>
#import "BillChartTableViewCell.h"
#import "Define.h"
#import "RLMBill.h"
#import "DateTools/DateTools.h"
#import "PNChart.h"
@interface ChartViewController ()<UITableViewDelegate,UITableViewDataSource,MKDropdownMenuDelegate,MKDropdownMenuDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic)  PNLineChart *lineChart;
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (strong,nonatomic) RLMResults<RLMBill*> *dataArray;
@property (strong,nonatomic) NSMutableArray<RLMBill*> *tempDataArray;
@property (strong,nonatomic) MKDropdownMenu *timePeriodMenu;
@property (strong,nonatomic) MKDropdownMenu *expensesMenu;
@property (nonatomic) TimePeriodType timePeriodType;
@end

@implementation ChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self initData];
    self.tableView.tableFooterView = [[UIView alloc]init];
    _expensesType = ExpensesTypePayment;
    _timePeriodType = TimePeriodTypeMonth;
    _selectedDate = [NSDate date];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.expensesMenu = [[MKDropdownMenu alloc]initWithFrame:CGRectMake(0, 0, 80, 22)];
    self.expensesMenu.delegate = self;
    self.expensesMenu.dataSource = self;
    self.expensesMenu.rowTextAlignment = NSTextAlignmentCenter;
    self.tabBarController.navigationItem.titleView = self.expensesMenu;
    
    self.timePeriodMenu = [[MKDropdownMenu alloc]initWithFrame:CGRectMake(0, 0, 50, 22)];
    self.timePeriodMenu.delegate = self;
    self.timePeriodMenu.dataSource = self;
    self.timePeriodMenu.rowTextAlignment = NSTextAlignmentCenter;
    self.tabBarController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.timePeriodMenu];
    [self requestData];
    [self.tableView reloadData];
    if (_expensesType == ExpensesTypePayment) {
        self.titleLabel.text = @"支出排行榜";
    } else {
        self.titleLabel.text = @"收入排行榜";
    }
    [self requestLineData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - MKDrop Down Menu Data Source
-(NSInteger)numberOfComponentsInDropdownMenu:(MKDropdownMenu *)dropdownMenu{
    return 1;
}

-(NSInteger)dropdownMenu:(MKDropdownMenu *)dropdownMenu numberOfRowsInComponent:(NSInteger)component{
    if (dropdownMenu == _expensesMenu) {
        return 2;
    } else {
        return 3;
    }
}

#pragma mark - MKDrop Down Menu Delegate
- (void)dropdownMenu:(MKDropdownMenu *)dropdownMenu didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (dropdownMenu == _expensesMenu) {
        if (row == 0) {
            _expensesType = ExpensesTypePayment;
        } else {
            _expensesType = ExpensesTypeIncome;
        }
        [self requestData];
        if (_expensesType == ExpensesTypePayment) {
            self.titleLabel.text = @"支出排行榜";
        } else {
            self.titleLabel.text = @"收入排行榜";
        }
        [self.tableView reloadData];
        [self requestLineData];
        [dropdownMenu reloadAllComponents];
        [dropdownMenu closeAllComponentsAnimated:YES];
    } else {
        switch (row) {
            case TimePeriodTypeWeek:
                _timePeriodType = TimePeriodTypeWeek;
                break;
            case TimePeriodTypeMonth:
                _timePeriodType = TimePeriodTypeMonth;
                break;
            case TimePeriodTypeYear:
                _timePeriodType = TimePeriodTypeYear;
                break;
        }
        [self requestData];
        [self requestLineData];
        [self.tableView reloadData];
        [dropdownMenu reloadAllComponents];
        [dropdownMenu closeAllComponentsAnimated:YES];
    }
    
}

- (nullable NSString *)dropdownMenu:(MKDropdownMenu *)dropdownMenu titleForComponent:(NSInteger)component{
    if (dropdownMenu == _expensesMenu) {
        if (_expensesType == ExpensesTypePayment) {
            return @"支出";
        } else {
            return @"收入";
        }
    } else {
        if (_timePeriodType == TimePeriodTypeWeek) {
            return @"周";
        } else if(_timePeriodType == TimePeriodTypeMonth){
            return @"月";
        } else {
            return @"年";
        }
    }
}

- (nullable NSString *)dropdownMenu:(MKDropdownMenu *)dropdownMenu titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (dropdownMenu == _expensesMenu) {
        if (row == ExpensesTypePayment) {
            return @"支出";
        } else {
            return @"收入";
        }
    } else {
        if (row == TimePeriodTypeWeek) {
            return @"周";
        } else if(row == TimePeriodTypeMonth){
            return @"月";
        } else {
            return @"年";
        }
    }
}

#pragma mark - UITableView Data Source
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return _dataArray.count;
    return _tempDataArray.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    RLMBill *bill = _dataArray[indexPath.row];
    double totalValue = 0;
    for (RLMBill *tempBill in _tempDataArray) {
        totalValue += [tempBill.value doubleValue];
    }
    RLMBill *bill = _tempDataArray[indexPath.row];
    BillChartTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([BillChartTableViewCell class])];
    cell.typeImageView.image = [self  typeImageFromBillType:bill.type.type];
    if (bill.strDescription) {
        cell.typeNameLabel.text = bill.strDescription;
    } else {
        cell.typeNameLabel.text = [bill typeDescription];
    }    double i = 0;
    double ret = modf([bill.value doubleValue], &i);
    if (ret!=0) {
        cell.valueLabel.text = [NSString stringWithFormat:@"%.2f",[bill.value floatValue]];
    } else {
        cell.valueLabel.text = [NSString stringWithFormat:@"%ld",[bill.value integerValue]];
    }
//    cell.valueLabel.text = [NSString stringWithFormat:@"%.2f",[bill.value floatValue]];
//    if ([bill.value floatValue]<1000) {
//        cell.proportionWidthLayout.constant = [bill.value floatValue]/1000*319;
//    } else {
//        cell.proportionWidthLayout.constant = 319;
//    }
    
    cell.proportionWidthLayout.constant = [bill.value floatValue]/totalValue*319;
    cell.valueProportionLabel.text = [NSString stringWithFormat:@"%.2f%%",[bill.value floatValue]/totalValue*100];
    if (bill.type.type == BillTypeBook) {
        NSLog(@"%@",bill);
    }
    
    return cell;
}
#pragma mark - UITableView Delegate

#pragma mark - Data
- (void)initData{
    RLMResults *bills = [RLMBill allObjects];
    self.dataArray = bills;
    
    self.lineChart.backgroundColor = [UIColor whiteColor];
    [self.lineChart.chartData enumerateObjectsUsingBlock:^(PNLineChartData *obj, NSUInteger idx, BOOL *stop) {
        obj.pointLabelColor = [UIColor blackColor];
    }];
    
    self.lineChart = [[PNLineChart alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 220.0)];
    self.lineChart.showCoordinateAxis = YES;
//    self.lineChart.yLabelFormat = @"%1.1f";
    self.lineChart.xLabelFont = [UIFont fontWithName:@"Helvetica-Light" size:8.0];
    [self.lineChart setXLabels:@[@"1-1", @"", @"", @"", @"", @"", @"1-31"]];
    self.lineChart.yLabelColor = [UIColor blackColor];
    self.lineChart.xLabelColor = [UIColor blackColor];
    
    // added an example to show how yGridLines can be enabled
    // the color is set to clearColor so that the demo remains the same
    self.lineChart.showGenYLabels = NO;

    
    //Use yFixedValueMax and yFixedValueMin to Fix the Max and Min Y Value
    //Only if you needed
//    self.lineChart.yFixedValueMax = 300.0;
//    self.lineChart.yFixedValueMin = 0.0;
    
//    [self.lineChart setYLabels:@[
//                                 @"0 min",
//                                 @"50 min",
//                                 @"100 min",
//                                 @"150 min",
//                                 @"200 min",
//                                 @"250 min",
//                                 @"300 min",
//                                 ]
//     ];
    
    // Line Chart #1
    NSArray *data01Array = @[@15.1, @60.1, @110.4, @10.0, @186.2, @197.2, @276.2];
    data01Array = [[data01Array reverseObjectEnumerator] allObjects];
    PNLineChartData *data01 = [PNLineChartData new];
    

    data01.dataTitle = @"Alpha";
    data01.color = PNFreshGreen;
    data01.pointLabelColor = [UIColor blackColor];
    data01.alpha = 0.3f;
//    data01.showPointLabel = YES;
    data01.pointLabelFont = [UIFont fontWithName:@"Helvetica-Light" size:9.0];
    data01.itemCount = data01Array.count;
    data01.inflexionPointStyle = PNLineChartPointStyleTriangle;
    data01.getData = ^(NSUInteger index) {
        CGFloat yValue = [data01Array[index] floatValue];
        return [PNLineChartDataItem dataItemWithY:yValue];
    };

    self.lineChart.chartData = @[data01];
    [self.lineChart.chartData enumerateObjectsUsingBlock:^(PNLineChartData *obj, NSUInteger idx, BOOL *stop) {
        obj.pointLabelColor = [UIColor blackColor];
    }];
    
    
    [self.lineChart strokeChart];
//    self.lineChart.delegate = self;
    
    
    [self.headerView addSubview:self.lineChart];
}

-(void)requestLineData{
    NSMutableArray *dataArray = [[NSMutableArray alloc]init];
    switch (_timePeriodType) {
        case TimePeriodTypeWeek:
        {
            for (NSUInteger i = 0; i < 7; i ++) {
                NSDate *startDate = [[NSDate date]dateByAddingDays:(-7+i)];
                NSDate *endDate = [[NSDate date]dateByAddingDays:(-6+i)];
                RLMResults *result = [RLMBill objectsWhere:@"date >= %@ AND date < %@ AND type.expensesType = %ld",startDate,endDate,_expensesType];
                double totalValue = 0;
                for (RLMBill *tempBill in result) {
                    totalValue += [tempBill.value doubleValue];
                }
                [dataArray addObject:[NSNumber numberWithDouble:fabs(totalValue)]];
            }
            NSDate *startDate = [[NSDate date]dateByAddingDays:-7];
            NSDate *endDate = [NSDate date];
            NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
            [formatter setDateFormat:@"M-d"];
            NSString *strStartDate = [formatter stringFromDate:startDate];
            NSString *strEndDate = [formatter stringFromDate:endDate];
            [self.lineChart setXLabels:@[strStartDate,@"",@"",@"",@"",@"",strEndDate]];
        }
            break;
            
        case TimePeriodTypeMonth:
        {
            double totalValue = 0;
            for (NSUInteger i = 0; i < [self howManyDaysInThisYear:[NSDate date].year withMonth:[NSDate date].month]; i ++) {
                NSDate *startDate = [NSDate dateWithYear:[NSDate date].year month:[NSDate date].month day:i];
                NSDate *endDate = [NSDate dateWithYear:[NSDate date].year month:[NSDate date].month day:i+1];
                RLMResults *result = [RLMBill objectsWhere:@"date >= %@ AND date < %@ AND type.expensesType = %ld",startDate,endDate,_expensesType];
                
                for (RLMBill *tempBill in result) {
                    totalValue += [tempBill.value doubleValue];
                }
                if (i%5 == 0) {
                    [dataArray addObject:[NSNumber numberWithDouble:fabs(totalValue)]];
                    totalValue = 0;
                }
            }
            NSDate *startDate = [NSDate dateWithYear:[NSDate date].year month:[NSDate date].month day:1];
            NSDate *endDate = [NSDate dateWithYear:[NSDate date].year month:[NSDate date].month+1 day:1];
            NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
            [formatter setDateFormat:@"M-d"];
            NSString *strStartDate = [formatter stringFromDate:startDate];
            NSString *strEndDate = [formatter stringFromDate:endDate];
            [self.lineChart setXLabels:@[strStartDate,@"",@"",@"",@"",@"",strEndDate]];
        }
            break;
            
        case TimePeriodTypeYear:
        {
            double totalValue = 0;
            for (NSUInteger i = 0; i <= 365; i ++) {
                NSDate *startDate = [NSDate dateWithYear:[NSDate date].year month:1 day:1];
                NSDate *tempDate = [startDate dateByAddingDays:i];
                NSDate *endDate = [startDate dateByAddingDays:i+1];
                RLMResults *result = [RLMBill objectsWhere:@"date >= %@ AND date < %@ AND type.expensesType = %ld",tempDate,endDate,_expensesType];
                
                for (RLMBill *tempBill in result) {
                    totalValue += [tempBill.value doubleValue];
                }
                if (i%53 == 0) {
                    [dataArray addObject:[NSNumber numberWithDouble:fabs(totalValue)]];
                    totalValue = 0;
                }
            }
            NSDate *startDate = [NSDate dateWithYear:[NSDate date].year month:1 day:1];
            NSDate *endDate = [NSDate dateWithYear:[NSDate date].year month:12 day:31];
            NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
            [formatter setDateFormat:@"M-d"];
            NSString *strStartDate = [formatter stringFromDate:startDate];
            NSString *strEndDate = [formatter stringFromDate:endDate];
            [self.lineChart setXLabels:@[strStartDate,@"",@"",@"",@"",@"",strEndDate]];
        }
            break;
    }
    PNLineChartData *lineData = [PNLineChartData new];
    lineData.color = PNFreshGreen;
    lineData.itemCount = dataArray.count;
    lineData.inflexionPointStyle = PNLineChartPointStyleTriangle;
    lineData.getData = ^(NSUInteger index) {
        CGFloat yValue = [dataArray[index] floatValue];
        return [PNLineChartDataItem dataItemWithY:yValue];
    };
    [self.lineChart updateChartData:@[lineData]];
}

- (void)requestData{
    NSMutableArray *result = [[NSMutableArray alloc]init];
    switch (_timePeriodType) {
        case TimePeriodTypeWeek:
        { if (_expensesType == ExpensesTypePayment) {
                for (NSUInteger i = BillTypeBook; i <= PaymentTypeVegetable; i ++) {
                    RLMResults *billResultsWithWeek = [RLMBill objectsWhere:@"date >= %@ AND date < %@ AND type.type = %ld",[NSDate date],[[NSDate date] dateByAddingDays:-7],i];
                    RLMBill *bill = [[RLMBill alloc]init];
                    double valueTemp = 0;
                    for (RLMBill *billTemp in billResultsWithWeek) {
                        valueTemp += [billTemp.value doubleValue];
                    }
                    bill.type = [[RLMBillType objectsWhere:@"type = %ld",i]firstObject];
                    bill.value = [NSNumber numberWithDouble:fabs(valueTemp)];
                    if (valueTemp) {
                        [result addObject:bill];
                    }
                }
            } else {
                for (NSUInteger i = BillTypeFinance; i <= BillTypeDefault; i ++) {
                    RLMResults *billResultsWithWeek = [RLMBill objectsWhere:@"date >= %@ AND date < %@ AND type.type = %ld",[NSDate date],[[NSDate date] dateByAddingDays:-7],i];
                    RLMBill *bill = [[RLMBill alloc]init];
                    double valueTemp = 0;
                    for (RLMBill *billTemp in billResultsWithWeek) {
                        valueTemp += [billTemp.value doubleValue];
                    }
                    bill.type = [[RLMBillType objectsWhere:@"type = %ld",i]firstObject];
                    bill.value = [NSNumber numberWithDouble:fabs(valueTemp)];
                    if (valueTemp) {
                        [result addObject:bill];
                    }
                }
            }
            NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"value" ascending:NO];
            self.tempDataArray = [[NSMutableArray alloc]initWithArray:[result sortedArrayUsingDescriptors:@[sortDescriptor]]];
            break;
    }
        case TimePeriodTypeMonth:
        {
            if (_expensesType == ExpensesTypePayment) {
                for (NSUInteger i = BillTypeBook; i <= PaymentTypeVegetable; i ++) {
                    RLMResults *billResultsWithWeek = [RLMBill objectsWhere:@"date >= %@ AND date < %@ AND type.type = %ld",[NSDate dateWithYear:_selectedDate.year month:_selectedDate.month day:1],[NSDate dateWithYear:_selectedDate.year month:_selectedDate.month+1 day:1],i];
                    RLMBill *bill = [[RLMBill alloc]init];
                    double valueTemp = 0;
                    for (RLMBill *billTemp in billResultsWithWeek) {
                        valueTemp += [billTemp.value doubleValue];
                    }
                    bill.type = [[RLMBillType objectsWhere:@"type = %ld",i]firstObject];
                    bill.value = [NSNumber numberWithDouble:fabs(valueTemp)];
                    if (valueTemp) {
                        [result addObject:bill];
                    }
                }
            } else {
                for (NSUInteger i = BillTypeFinance; i <= BillTypeDefault; i ++) {
                    RLMResults *billResultsWithWeek = [RLMBill objectsWhere:@"date >= %@ AND date < %@ AND type.type = %ld",[NSDate dateWithYear:_selectedDate.year month:_selectedDate.month day:1],[NSDate dateWithYear:_selectedDate.year month:_selectedDate.month+1 day:1],i];
                    RLMBill *bill = [[RLMBill alloc]init];
                    double valueTemp = 0;
                    for (RLMBill *billTemp in billResultsWithWeek) {
                        valueTemp += [billTemp.value doubleValue];
                    }
                    bill.type = [[RLMBillType objectsWhere:@"type = %ld",i]firstObject];
                    bill.value = [NSNumber numberWithDouble:fabs(valueTemp)];
                    if (valueTemp) {
                        [result addObject:bill];
                    }
                }
            }
            NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"value" ascending:NO];
            self.tempDataArray = [[NSMutableArray alloc]initWithArray:[result sortedArrayUsingDescriptors:@[sortDescriptor]]];
            break;
    }
        case TimePeriodTypeYear:
        {if (_expensesType == ExpensesTypePayment) {
                for (NSUInteger i = BillTypeBook; i <= PaymentTypeVegetable; i ++) {
                    RLMResults *billResultsWithWeek = [RLMBill objectsWhere:@"date >= %@ AND date < %@ AND type.type = %ld",[NSDate dateWithYear:_selectedDate.year month:1 day:1],[NSDate dateWithYear:_selectedDate.year month:12 day:31],i];
                    RLMBill *bill = [[RLMBill alloc]init];
                    double valueTemp = 0;
                    for (RLMBill *billTemp in billResultsWithWeek) {
                        valueTemp += [billTemp.value doubleValue];
                    }
                    bill.type = [[RLMBillType objectsWhere:@"type = %ld",i]firstObject];
                    bill.value = [NSNumber numberWithDouble:fabs(valueTemp)];
                    if (valueTemp) {
                        [result addObject:bill];
                    }
                }
            } else {
                for (NSUInteger i = BillTypeFinance; i <= BillTypeDefault; i ++) {
                    RLMResults *billResultsWithWeek = [RLMBill objectsWhere:@"date >= %@ AND date < %@ AND type.type = %ld",[NSDate dateWithYear:_selectedDate.year month:1 day:1],[NSDate dateWithYear:_selectedDate.year month:12 day:31],i];
                    RLMBill *bill = [[RLMBill alloc]init];
                    double valueTemp = 0;
                    for (RLMBill *billTemp in billResultsWithWeek) {
                        valueTemp += [billTemp.value doubleValue];
                    }
                    bill.type = [[RLMBillType objectsWhere:@"type = %ld",i]firstObject];
                    bill.value = [NSNumber numberWithDouble:fabs(valueTemp)];
                    if (valueTemp) {
                        [result addObject:bill];
                    }
                }
            }
            NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"value" ascending:NO];
            self.tempDataArray = [[NSMutableArray alloc]initWithArray:[result sortedArrayUsingDescriptors:@[sortDescriptor]]];
            break;
        }
    }
    
}

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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
