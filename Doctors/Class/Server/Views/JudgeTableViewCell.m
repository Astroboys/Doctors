//
//  JudgeTableViewCell.m
//  Doctors
//
//  Created by zhonghe on 16/10/5.
//  Copyright © 2016年 XueHuiWang. All rights reserved.
//

#import "JudgeTableViewCell.h"

@implementation JudgeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        [self addAllViews];
    }
    return self;
    
}


-(void)addAllViews
{
    self.photoView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 50, 50)];
    self.photoView.layer.masksToBounds = YES;
    self.photoView.layer.cornerRadius = 25;
    [self.contentView addSubview:self.photoView];
    
    
    self.titleLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.photoView.frame)+15, 10, kWidth-70-80, 20)];
    self.titleLab.textColor = DWColor(85, 85, 85);
    self.titleLab.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:self.titleLab];
    
    
    self.detailLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.photoView.frame)+15, CGRectGetMaxY(self.titleLab.frame)+10, kWidth-70-80, 15)];
    self.detailLab.textColor = DWColor(85, 85, 85);
    self.detailLab.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:self.detailLab];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
