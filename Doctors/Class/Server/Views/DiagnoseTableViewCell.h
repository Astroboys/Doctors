//
//  DiagnoseTableViewCell.h
//  Doctors
//
//  Created by 崔敬轩 on 16/9/24.
//  Copyright © 2016年 XueHuiWang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DiagnoseModel.h"

@interface DiagnoseTableViewCell : UITableViewCell

@property(nonatomic,strong)UIImageView*timeImage;
@property(nonatomic,strong) UILabel*timeLabel;
@property (nonatomic, strong) UILabel *titleLabel;
@property(nonatomic,strong)UILabel*consultLabel;
@property(nonatomic,strong)UILabel*consultTopicView;

- (void)DiagnoseTableViewCellWithObject:(DiagnoseModel*)model;



@end
