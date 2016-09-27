//
//  RecordViewCell.m
//  Doctors
//
//  Created by 崔敬轩 on 16/9/25.
//  Copyright © 2016年 XueHuiWang. All rights reserved.
//

#import "RecordViewCell.h"
#import "Masonry.h"
@implementation RecordViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.postImageView];
        [self.contentView addSubview:self.hospitalLabel];
        [self.contentView addSubview:self.hosContentLabel];
        [self.contentView addSubview:self.recordTimeLabel];
        [self.contentView addSubview:self.timeContentLabel];
        
        [self setupFrame];
    }
    return self;
    
}

- (void)RecordViewCellWithObject:(RecordModel *)model
{
    self.postImageView.image=[UIImage imageNamed:model.postImageName];
    self.nameLabel.text=model.name;
    [self.nameLabel setFont:[UIFont systemFontOfSize:13]];
    self.hospitalLabel.text = model.hospitalName;
    [self.hospitalLabel setFont:[UIFont systemFontOfSize:13]];
    
    self.hosContentLabel.text = model.hosContentName;
    [self.hosContentLabel setFont:[UIFont systemFontOfSize:13]];
    
    self.recordTimeLabel.text=model.recordTime;
    [self.recordTimeLabel setFont:[UIFont systemFontOfSize:13]];
    
    self.timeContentLabel.text=model.timeContentName;
    [self.timeContentLabel setFont:[UIFont systemFontOfSize:13]];

    }

- (void)setupFrame
{
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.contentView.mas_top).with.offset(10);
        make.left.mas_equalTo(self.contentView.mas_left).with.offset(15);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(15);
        
    }];
    
    [self.postImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.nameLabel.mas_bottom).with.offset(8);
        make.left.mas_equalTo(self.nameLabel.mas_left);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(40);
        
    }];
    
    
    [self.hospitalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.postImageView.mas_bottom).with.offset(8);
        make.left.mas_equalTo(self.nameLabel.mas_left);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(15);
        
    }];
    
    [self.hosContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.postImageView.mas_bottom).with.offset(8);
        make.left.mas_equalTo(self.hospitalLabel.mas_right).with.offset(12);
        make.right.mas_equalTo(self.contentView.mas_right).with.offset(-15);
        make.height.mas_equalTo(15);
        
    }];
    
    [self.recordTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.hospitalLabel.mas_bottom).with.offset(8);
        make.left.mas_equalTo(self.nameLabel.mas_left);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(15);
    }];
    
    [self.timeContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.hospitalLabel.mas_bottom).with.offset(8);
        make.left.mas_equalTo(self.recordTimeLabel.mas_right).with.offset(12);
        make.right.mas_equalTo(self.contentView.mas_right).with.offset(-15);
        make.height.mas_equalTo(15);
        
    }];

}

/**懒加载*/


-(UILabel *)nameLabel{
    
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc]init];
    }
    return _nameLabel;
    
}

-(UIImageView *)postImageView{
    
    if (_postImageView==nil) {
        _postImageView=[[UIImageView alloc]init];
        
    }
    
    return _postImageView;
    
}


- (UILabel *)hospitalLabel
{
    if (_hospitalLabel == nil) {
        _hospitalLabel = [[UILabel alloc]init];
    }
    return _hospitalLabel;
}

-(UILabel *)hosContentLabel{
    
    if (_hosContentLabel==nil) {
        _hosContentLabel=[[UILabel alloc]init];
    }
    return _hosContentLabel;
}

- (UILabel *)recordTimeLabel
{
    if (_recordTimeLabel == nil) {
        _recordTimeLabel = [[UILabel alloc]init];
    }
    return _recordTimeLabel;
}

-(UILabel *)timeContentLabel{
    
    if (_timeContentLabel==nil) {
        _timeContentLabel=[[UILabel alloc]init];
    }
    return _timeContentLabel;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
