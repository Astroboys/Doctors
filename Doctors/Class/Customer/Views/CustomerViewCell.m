//
//  CustomerViewCell.m
//  Doctors
//
//  Created by 崔敬轩 on 16/9/25.
//  Copyright © 2016年 XueHuiWang. All rights reserved.
//

#import "CustomerViewCell.h"
#import "Masonry.h"
@implementation CustomerViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.timeLabel];
        [self.contentView addSubview:self.topicLabel];
        [self.contentView addSubview:self.circleImage];
        
        [self setupFrame];
    }
    return self;
}

- (void)CustomerViewCellWithObject:(CustomerModel *)model
{
    self.circleImage.image=[UIImage imageNamed:model.circleImage];
    self.nameLabel.text= model.name;
    [self.timeLabel setFont:[UIFont systemFontOfSize:13]];
    self.timeLabel.text=model.time;
    self.topicLabel.text = model.topic;
    [self.topicLabel setFont:[UIFont systemFontOfSize:13]];
    
}

- (void)setupFrame
{
    
    [self.circleImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.contentView.mas_top).with.offset(5);
        make.left.mas_equalTo(self.contentView.mas_left).with.offset(10);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(60);
    }];
    
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.contentView.mas_top).with.offset(10);
        make.left.mas_equalTo(self.circleImage.mas_right).with.offset(8);
        make.right.mas_equalTo(self.contentView.mas_right).with.offset(10);
        make.height.mas_equalTo(15);
        
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.contentView.mas_top).with.offset(10);
        make.right.mas_equalTo(self.contentView.mas_right).with.offset(-10);
        make.width.mas_equalTo(90);
        make.height.mas_equalTo(15);
        
    }];
    
    [self.topicLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.nameLabel.mas_bottom).with.offset(15);
        make.left.mas_equalTo(self.circleImage.mas_right).with.offset(8);
        make.right.mas_equalTo(self.contentView.mas_right).with.offset(-10);
        make.height.mas_equalTo(15);
        
    }];
}

/**懒加载*/


-(UILabel *)nameLabel{
    
    if (_nameLabel==nil) {
        _nameLabel=[[UILabel alloc]init];
        
    }
    
    return _nameLabel;
    
}

-(UILabel *)timeLabel{
    
    if (_timeLabel == nil) {
        _timeLabel = [[UILabel alloc]init];
    }
    return _timeLabel;
    
    
}

- (UILabel *)topicLabel
{
    if (_topicLabel == nil) {
        _topicLabel = [[UILabel alloc]init];
        _topicLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _topicLabel;
}

-(UIImageView *)circleImage{
    
    if (_circleImage==nil) {
        _circleImage=[[UIImageView alloc]init];
    }
    
    return _circleImage;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
