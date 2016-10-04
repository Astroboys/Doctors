//
//  PhotoCell.m
//  familyTest
//
//  Created by Gao on 15-1-15.
//  Copyright (c) 2015年 huangxiaoya. All rights reserved.
//

#import "PhotoCell.h"
#import "PhotoScrollview.h"
@implementation PhotoCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self _initscrollview];
        
        // Initialization code
    }
    return self;
}


- (void)_initscrollview{
    
    _scrollview = [[PhotoScrollview alloc]initWithFrame:self.bounds];
    [self addSubview:_scrollview];
    
}

- (void)setImageUrl:(NSString *)imageUrl{
    
    if (_imageUrl != imageUrl) {
        _imageUrl = [imageUrl copy];
        
        //_scrollview.imageUrl = self.imageUrl;
        [self setNeedsLayout];
    }
    
    
}




//数据传递
- (void)layoutSubviews {
    
    [super layoutSubviews];
    _scrollview.imageUrl = self.imageUrl;
    
}

@end


