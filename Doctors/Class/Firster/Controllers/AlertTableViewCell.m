//
//  AlertTableViewCell.m
//  Doctors
//
//  Created by zhonghe on 16/10/2.
//  Copyright © 2016年 XueHuiWang. All rights reserved.
//

#import "AlertTableViewCell.h"

@implementation AlertTableViewCell

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
    self.photoView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 10, 50, 50)];
    self.photoView.layer.masksToBounds = YES;
    self.photoView.layer.cornerRadius = 25;
    [self.contentView addSubview:self.photoView];
    
    
    self.titleLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.photoView.frame)+10, 10, kWidth-70-80, 30)];
    self.titleLab.textColor = DWColor(85, 85, 85);
    self.titleLab.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:self.titleLab];
    
    
    self.detailLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.photoView.frame)+10, CGRectGetMaxY(self.titleLab.frame)+10, kWidth-70-80, 15)];
    self.detailLab.textColor = DWColor(85, 85, 85);
    self.detailLab.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:self.detailLab];

    
    self.agreeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.agreeBtn.frame = CGRectMake(CGRectGetMaxX(self.titleLab.frame)+10, 20, 60, 30);
    self.agreeBtn.layer.borderColor = DWColor(223, 222, 222).CGColor;
    [self.agreeBtn setTitleColor:DWColor(85, 85, 85) forState:UIControlStateNormal];
    self.agreeBtn.layer.cornerRadius = 3;
    self.agreeBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    self.agreeBtn.layer.borderWidth = 0.5;
    [self.agreeBtn addTarget:self action:@selector(agreeBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.agreeBtn];
    UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(0, 69, kWidth, 1)];
    lineView.backgroundColor=DWColor(223, 222, 222);
    [self.contentView addSubview:lineView];
}

-(void)setNotification:(NIMSystemNotification *)notification
{
    _notification = notification;
    self.titleLab.text = notification.sourceID;
    self.detailLab.text = [NSString stringWithFormat:@"%@%@",notification.postscript,notification.targetID];
    self.photoView.image = [UIImage imageNamed:@"healthIcon"];
    
    if (notification.handleStatus == 0) {
        [self.agreeBtn setTitle:@"同意" forState:UIControlStateNormal];
        self.agreeBtn.userInteractionEnabled = YES;
    }else{
        [self.agreeBtn setTitle:@"已同意" forState:UIControlStateNormal];
        self.agreeBtn.userInteractionEnabled = NO;
    }

}

-(void)agreeBtnAction
{
    if (_delegate && [_delegate respondsToSelector:@selector(clickAgreeBtn:)]) {
        [_delegate clickAgreeBtn:_notification];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
