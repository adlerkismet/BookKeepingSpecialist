//
//  BillHeaderView.h
//  BookKeepingSpecialist
//
//  Created by adlerkismet on 2017/4/7.
//  Copyright © 2017年 adlerkismet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BillHeaderView : UITableViewHeaderFooterView
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *valueLabel;
@end
