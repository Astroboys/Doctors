
//
//  ChangeBtn.m
//  Doctors
//
//  Created by 崔敬轩 on 16/8/22.
//  Copyright © 2016年 崔敬轩. All rights reserved.
//

#import "ChangeBtn.h"
#import "UIView+Frame.h"

@implementation ChangeBtn

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imageView.h=self.imageView.w = self.w/2;
    
    self.imageView.x = (self.w-self.imageView.w)/2;
    self.imageView.y =((self.h-self.imageView.h-self.titleLabel.h)-5)/2;
    
    self.titleLabel.w=self.w;
    
    self.titleLabel.textAlignment= NSTextAlignmentCenter;
    
    self.titleLabel.x = (self.w-self.titleLabel.w)/2;
    
    self.titleLabel.y=self.imageView.y+self.imageView.h+5;
    
    [self.titleLabel setFont:[UIFont systemFontOfSize:13]];
    
}

@end
