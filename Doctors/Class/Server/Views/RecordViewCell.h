//
//  RecordViewCell.h
//  Doctors
//
//  Created by 崔敬轩 on 16/9/25.
//  Copyright © 2016年 XueHuiWang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecordModel.h"

@interface RecordViewCell : UITableViewCell

@property(nonatomic,strong) UILabel *nameLabel;
@property(nonatomic,strong)UIImageView *postImageView;
@property (nonatomic, strong) UILabel *hospitalLabel;
@property(nonatomic,strong)UILabel*hosContentLabel;
@property(nonatomic,strong)UILabel* recordTimeLabel;
@property(nonatomic,strong)UILabel*timeContentLabel;


- (void)RecordViewCellWithObject:(RecordModel*)model;
@end
