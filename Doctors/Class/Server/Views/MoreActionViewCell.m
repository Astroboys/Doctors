//
//  MoreActionViewCell.m
//  ChatMessageDemo
//
//  Created by ZQ on 15/11/23.
//  Copyright © 2015年 ZQ. All rights reserved.
//

#import "MoreActionViewCell.h"
#define LNUIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
@implementation MoreActionViewCell
@synthesize moreActionBtn;
@synthesize imageTitle;
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        [self addAllViews];
    }
    return self;
}
- (void)addAllViews
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [self.contentView addSubview:view];
    
    moreActionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    moreActionBtn.frame = CGRectMake(0, 0, 40, 40);
    moreActionBtn.userInteractionEnabled = YES;
    [moreActionBtn setBackgroundColor:[UIColor redColor]];
    moreActionBtn.contentMode = UIViewContentModeCenter;
    moreActionBtn.layer.cornerRadius = 5;
    moreActionBtn.enabled = NO;
    moreActionBtn.adjustsImageWhenDisabled = NO;
    [view addSubview:moreActionBtn];
    
//    imageTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 65, 60, 15)];
//    imageTitle.textAlignment = NSTextAlignmentCenter;
//    imageTitle.font = [UIFont fontWithName:@"PingFangSC-Light" size:12];
//    imageTitle.textColor = [UIColor colorWithRed:147/255.0 green:147/255.0 blue:147/255.0 alpha:1];
//    [view addSubview:imageTitle];
    
  
}


@end
