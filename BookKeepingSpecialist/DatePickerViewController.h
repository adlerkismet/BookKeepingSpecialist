//
//  DatePickerViewController.h
//  BookKeepingSpecialist
//
//  Created by adlerkismet on 2017/4/8.
//  Copyright © 2017年 adlerkismet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DatePickerViewController : UIViewController
@property (nonatomic, copy) void (^backDateBlock)(NSDate*);
@property (nonatomic,strong) NSDate *currentSelectedDate;
@end
