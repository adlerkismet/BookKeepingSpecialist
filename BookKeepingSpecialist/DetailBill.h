//
//  DetailBill.h
//  BookKeepingSpecialist
//
//  Created by adlerkismet on 2017/4/1.
//  Copyright © 2017年 adlerkismet. All rights reserved.
//

//#import <Realm/Realm.h>
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Define.h"

@interface DetailBill : NSObject
@property (nonatomic) BillType type;
@property (strong,nonatomic) NSString *date;
@property (strong,nonatomic) NSString *typeName;
@property (strong,nonatomic) NSNumber *value;
@property (strong,nonatomic) UIImage *typeImage;
- (id)initWithType:(BillType)type date:(NSString*)date typeName:(NSString*)typeName value:(NSNumber*)value;
- (UIImage*)typeImage;
@end
