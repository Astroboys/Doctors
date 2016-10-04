//
//  HealthycircleCell.m
//  Doctors
//
//  Created by 崔敬轩 on 16/9/25.
//  Copyright © 2016年 XueHuiWang. All rights reserved.
//

#import "HealthycircleCell.h"
#import "Masonry.h"
@implementation HealthycircleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        if (_rootView==nil) {
            _rootView=[[UIView alloc]initWithFrame:CGRectMake(10, 5, kWidth-20, 60)];
            _rootView.layer.cornerRadius = 6;
            _rootView.backgroundColor = [UIColor whiteColor];
            [self.contentView addSubview:self.rootView];

            
        }
        [self.rootView addSubview:self.nameLabel];
        [self.rootView addSubview:self.timeLabel];
        [self.rootView addSubview:self.topicLabel];
        [self.rootView addSubview:self.circleImage];
        
        [self setupFrame];
    }
    return self;
    
}

- (void)HealthycircleCellWithObject:(HealthycircleModel *)model
{
    self.circleImage.image=[UIImage imageNamed:model.circleImage] ;
    self.nameLabel.text= model.name;
    [self.timeLabel setFont:[UIFont systemFontOfSize:13]];
    self.timeLabel.text=model.time;
    self.topicLabel.text = model.topic;
    [self.topicLabel setFont:[UIFont systemFontOfSize:13]];
   
}

- (void)setupFrame
{
    
//    
//    [self.rootView mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.top.mas_equalTo(self.contentView.mas_top).with.offset(5);
//        make.left.mas_equalTo(self.contentView.mas_left).with.offset(10);
//        make.width.mas_equalTo(kWidth-20);
//        make.height.mas_equalTo(60);
//    }];

    
    [self.circleImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.rootView.mas_top).with.offset(5);
        make.left.mas_equalTo(self.rootView.mas_left).with.offset(10);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];

    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.rootView.mas_top).with.offset(5);
        make.left.mas_equalTo(self.circleImage.mas_right).with.offset(8);
//        make.right.mas_equalTo(self.rootView.mas_right).with.offset(10);
        make.height.mas_equalTo(15);
        make.width.mas_equalTo(80);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.rootView.mas_top).with.offset(10);
        make.right.mas_equalTo(self.rootView.mas_right).with.offset(-10);
        make.width.mas_equalTo(140);
        make.height.mas_equalTo(15);
        
    }];
    
    [self.topicLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.nameLabel.mas_bottom).with.offset(15);
        make.left.mas_equalTo(self.circleImage.mas_right).with.offset(8);
        make.right.mas_equalTo(self.rootView.mas_right).with.offset(-10);
        make.height.mas_equalTo(15);
        
    }];
}

/**懒加载*/

//-(UIView *)rootView{
//    
//    if (_rootView==nil) {
//        _rootView=[[UIView alloc]initWithFrame:CGRectMake(10, 5, kWidth-20, 60)];
//        _rootView.backgroundColor = [UIColor redColor];
//        
//    }
//    
//    return _nameLabel;
//    
//}

-(UILabel *)nameLabel{
    
    if (_nameLabel==nil) {
        _nameLabel=[[UILabel alloc]init];
        _nameLabel.textColor=DWColor(85, 85, 85);
        _nameLabel.font=[UIFont systemFontOfSize:15];

        
    }
    
    return _nameLabel;
    
}

-(UILabel *)timeLabel{
    
    if (_timeLabel == nil) {
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.textAlignment = NSTextAlignmentRight;
        _timeLabel.textColor=DWColor(166, 171, 185);
        _timeLabel.font=[UIFont systemFontOfSize:12];
    }
    return _timeLabel;
    
    
}

- (UILabel *)topicLabel
{
    if (_topicLabel == nil) {
        _topicLabel = [[UILabel alloc]init];
        _topicLabel.textAlignment = NSTextAlignmentLeft;
        _topicLabel.textColor=DWColor(149, 149, 149);
        _topicLabel.font=[UIFont systemFontOfSize:13];
    }
    return _topicLabel;
}

-(UIImageView *)circleImage{

    if (_circleImage==nil) {
        _circleImage=[[UIImageView alloc]init];
        _circleImage.layer.masksToBounds = YES;
        _circleImage.layer.cornerRadius = 5;
    }
    
    return _circleImage;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
