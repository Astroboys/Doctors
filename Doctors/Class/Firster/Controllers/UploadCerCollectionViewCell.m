//
//  UploadCerCollectionViewCell.m
//  Doctors
//
//  Created by zhonghe on 16/9/28.
//  Copyright © 2016年 XueHuiWang. All rights reserved.
//

#import "UploadCerCollectionViewCell.h"

@implementation UploadCerCollectionViewCell
@synthesize photoImgeView;
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
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 85, 115)];
    photoImgeView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 85, 85)];
    //    _selectNumLabel.layer.cornerRadius = 15;
    //    photoImgeView.image = [UIImage imageNamed:@"upload"];
    imageTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 85, 85, 30)];
    imageTitle.textAlignment = NSTextAlignmentCenter;
    imageTitle.textColor = [UIColor colorWithRed:62/256.0 green:62/256.0 blue:62/256.0 alpha:0.600];
    imageTitle.font = [UIFont systemFontOfSize:14];
    [view addSubview:photoImgeView];
    [view addSubview:imageTitle];
    [self.contentView addSubview:view];
}

@end
