//
//  DetailTableViewCell.h
//  BookKeepingSpecialist
//
//  Created by adlerkismet on 2017/3/19.
//  Copyright © 2017年 adlerkismet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *typeImageView;
@property (weak, nonatomic) IBOutlet UILabel *typeNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *valueLabel;

@end
