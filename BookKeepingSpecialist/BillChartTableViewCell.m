//
//  BillChartTableViewCell.m
//  BookKeepingSpecialist
//
//  Created by adlerkismet on 2017/4/9.
//  Copyright © 2017年 adlerkismet. All rights reserved.
//

#import "BillChartTableViewCell.h"

@implementation BillChartTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.proportionView.layer.cornerRadius = 2.5f;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
