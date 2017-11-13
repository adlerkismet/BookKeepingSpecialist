//
//  ChartViewController.h
//  BookKeepingSpecialist
//
//  Created by adlerkismet on 2017/4/1.
//  Copyright © 2017年 adlerkismet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Define.h"
@interface ChartViewController : UIViewController
@property (nonatomic) ExpensesType expensesType;
@property (strong,nonatomic) NSDate *selectedDate;
@end
