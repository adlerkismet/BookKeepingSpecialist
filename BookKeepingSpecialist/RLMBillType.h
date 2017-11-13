//
//  RLMBillType.h
//  BookKeepingSpecialist
//
//  Created by adlerkismet on 2017/5/13.
//  Copyright © 2017年 adlerkismet. All rights reserved.
//

#import <Realm/Realm.h>
#import <UIKit/UIKit.h>
#import "Define.h"
@interface RLMBillType : RLMObject
@property NSInteger type;
@property NSString *strDescription;
@property NSString *id;
@property NSInteger expensesType;
- (UIImage*)typeImage;
- (UIImage*)selectedTypeImage;
- (NSString*)typeDescription;
- (NSString*)typeDescriptionFromType:(BillType)type;
@end
