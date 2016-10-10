//
//  ZHFirstTableViewCell.m
//  Doctors
//
//  Created by zhonghe on 16/10/6.
//  Copyright © 2016年 XueHuiWang. All rights reserved.
//

#import "ZHFirstTableViewCell.h"
@interface ZHFirstTableViewCell ()<UITextViewDelegate>

@end


@implementation ZHFirstTableViewCell

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
    self.photoView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 15, 15, 15)];
//    self.photoView.layer.masksToBounds = YES;
//    self.photoView.layer.cornerRadius = 25;
    [self.contentView addSubview:self.photoView];
    
    
    self.titleLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.photoView.frame)+10, 15, 70, 15)];
    self.titleLab.textColor = DWColor(85, 85, 85);
    self.titleLab.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:self.titleLab];
    
    
    self.detailText = [[UITextView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.titleLab.frame)+10, 8, kWidth-CGRectGetMaxX(self.titleLab.frame)-10, 35)];
    self.detailText.delegate = self;;
    self.detailText.textColor = DWColor(85, 85, 85);
    self.detailText.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:self.detailText];
    
}
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
        return NO;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
