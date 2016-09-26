//
//  CustomerViewCell.h
//  Doctors
//
//  Created by 崔敬轩 on 16/9/25.
//  Copyright © 2016年 XueHuiWang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomerModel.h"

@interface CustomerViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *nameLabel;
@property(nonatomic,strong) UILabel*timeLabel;
@property(nonatomic,strong)UILabel* topicLabel;
@property(nonatomic,strong)UIImageView*circleImage;

- (void)CustomerViewCellWithObject:(CustomerModel*)model;


@end