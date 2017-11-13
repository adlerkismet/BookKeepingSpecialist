//
//  BillType.h
//  BookKeepingSpecialist
//
//  Created by adlerkismet on 2017/4/3.
//  Copyright © 2017年 adlerkismet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Define.h"


@interface AddBillType : NSObject
@property (nonatomic) BillType type;
@property (strong,nonatomic) NSString *typeName;
- (id)initWithType:(BillType)type typeName:(NSString*)typeName;
- (UIImage*)typeImage;
@end
