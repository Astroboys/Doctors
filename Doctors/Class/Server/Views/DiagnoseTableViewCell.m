
//
//  DiagnoseTableViewCell.m
//  Doctors
//
//  Created by 崔敬轩 on 16/9/24.
//  Copyright © 2016年 XueHuiWang. All rights reserved.
//

#import "DiagnoseTableViewCell.h"
#import "Masonry.h"
@implementation DiagnoseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self.contentView addSubview:self.timeImage];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.timeLabel];
        [self.contentView addSubview:self.consultLabel];
        [self.contentView addSubview:self.consultTopicView];
        
        [self setupFrame];
    }
    return self;

}

- (void)DiagnoseTableViewCellWithObject:(DiagnoseModel *)model
{
    self.timeImage.image=[UIImage imageNamed:model.timeImagename];
    self.timeLabel.text=model.time;
    self.titleLabel.text = model.title;
    [self.titleLabel setFont:[UIFont systemFontOfSize:13]];
    self.consultLabel.text=model.consult;
    [self.consultLabel setFont:[UIFont systemFontOfSize:13]];
    self.consultTopicView.text=model.consultTopic;
    [self.consultTopicView setFont:[UIFont systemFontOfSize:13]];
}

- (void)setupFrame
{
    
    [self.timeImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.contentView.mas_top).with.offset(10);
        make.left.mas_equalTo(self.contentView.mas_left).with.offset(15);
        make.width.mas_equalTo(15);
        make.height.mas_equalTo(15);
        
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.contentView.mas_top).with.offset(10);
        make.left.mas_equalTo(self.timeImage.mas_right).with.offset(8);
        make.width.mas_equalTo(KDeviceWidth - 35);
        make.height.mas_equalTo(15);
        
    }];
    
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.contentView.mas_top).with.offset(10);
        make.right.mas_equalTo(self.contentView.mas_right).with.offset(-15);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(15);
        
    }];
    
    
    [self.consultLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.timeImage.mas_bottom).with.offset(8);
        make.left.mas_equalTo(self.contentView.mas_left).with.offset(15);
        make.right.mas_equalTo(self.contentView.mas_right).with.offset(-15);
        make.height.mas_equalTo(15);
        
    }];
    
    [self.consultTopicView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.consultLabel.mas_bottom).with.offset(0);
        make.right.mas_equalTo(self.contentView.mas_right).with.offset(-15);
        make.left.mas_equalTo(self.contentView.mas_left).with.offset(15);
        make.height.mas_equalTo(30);
        
    }];
}

/**懒加载*/

-(UIImageView *)timeImage{

    if (_timeImage==nil) {
        _timeImage=[[UIImageView alloc]init];
        
    }
    
    return _timeImage;

}

-(UILabel *)timeLabel{
    
    if (_timeLabel == nil) {
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.textAlignment = NSTextAlignmentLeft;
        _timeLabel.textColor = DWColor(149, 149, 149);
        _timeLabel.font = [UIFont systemFontOfSize:14];
    }
    return _timeLabel;
    
}

- (UILabel *)titleLabel
{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = DWColor(85, 85, 85);
        _titleLabel.font = [UIFont systemFontOfSize:14];

    }
    return _titleLabel;
}

-(UILabel *)consultLabel{

    if (_consultLabel==nil) {
        _consultLabel=[[UILabel alloc]init];
        _consultLabel.textColor = DWColor(24, 144, 203);
        _consultLabel.font = [UIFont systemFontOfSize:14];
    }
    return _consultLabel;
}

-(UILabel *)consultTopicView{

    if (_consultTopicView==nil) {
        _consultTopicView=[[UILabel alloc]init];
    }
    return _consultTopicView;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
