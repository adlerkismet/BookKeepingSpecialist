//
//  BillChartTableViewCell.h
//  BookKeepingSpecialist
//
//  Created by adlerkismet on 2017/4/9.
//  Copyright © 2017年 adlerkismet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BillChartTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *typeImageView;
@property (weak, nonatomic) IBOutlet UILabel *typeNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *valueProportionLabel;
@property (weak, nonatomic) IBOutlet UILabel *valueLabel;
@property (weak, nonatomic) IBOutlet UIView *proportionView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *proportionWidthLayout;

@end
