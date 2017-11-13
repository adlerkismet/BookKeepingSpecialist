//
//  AddBillViewController.h
//  BookKeepingSpecialist
//
//  Created by adlerkismet on 2017/4/5.
//  Copyright © 2017年 adlerkismet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddBillType.h"
#import "RLMBill.h"

@interface AddBillViewController : UIViewController
//@property (nonatomic) BillType type;
@property (strong,nonatomic) RLMBillType *type;
@property (strong,nonatomic) RLMBill *editingBill;
@end
