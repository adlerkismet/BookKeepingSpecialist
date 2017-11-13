//
//  RLMBill.h
//  BookKeepingSpecialist
//
//  Created by adlerkismet on 2017/4/4.
//  Copyright © 2017年 adlerkismet. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <Realm/Realm.h>
#import <UIKit/UIKit.h>
#import "Define.h"
#import "RLMBillType.h"

@interface RLMBill : RLMObject
//@property  NSInteger type;
//@property  NSString *date;
@property NSDate *date;
@property RLMBillType *type;
@property  NSString *strDescription;
@property  NSNumber<RLMFloat> *value;
@property NSString *id;
- (NSString*)typeDescription;
- (NSString*)typeDescriptionFromType:(BillType)type;
- (double)currentValueFromValue:(double)value expenseType:(ExpensesType)type;
@end
