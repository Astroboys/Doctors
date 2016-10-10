//
//  PhotoScrollview.m
//  familyTest
//
//  Created by Gao on 15-1-15.
//  Copyright (c) 2015年 huangxiaoya. All rights reserved.
//

#import "PhotoScrollview.h"
#import "UIImageView+WebCache.h"
@implementation PhotoScrollview

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        //创建imageview
        [self _initimageview];
        
        // Initialization code
    }
    return self;
}

- (void)_initimageview{
    

    
//    _imgview = [[UIImageView alloc]initWithFrame:CGRectMake(0, self.frame.origin.y, self.frame.size.width, self.frame.size.height)];
    _imgview = [[UIImageView alloc]initWithFrame:CGRectMake(0,0, KDeviceWidth, KDeviceHeight)];

    
    //设置图片的拉伸模式

    _imgview.contentMode = UIViewContentModeScaleAspectFit;
//     _imgview.clipsToBounds=YES;
//     _imgview.contentMode=UIViewContentModeCenter;
//     _imgview.backgroundColor = [UIColor redColor];
    
    [self addSubview:_imgview];
    
    
    //添加手势
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap1Action:)];
    
    [self addGestureRecognizer:tap1];
    
    
    
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap2Action:)];
    
    
    tap2.numberOfTapsRequired = 2;
    
    
    [self addGestureRecognizer:tap2];
    
    
    //把tap1的手势禁掉
    
    [tap1 requireGestureRecognizerToFail:tap2];
    
    
    //设置放大和缩小的倍数
    
    self.maximumZoomScale = 3;
    
    self.minimumZoomScale = 1;
    
    self.delegate = self;
}

//点击事件的实现 (tap1)
- (void)tap1Action:(UITapGestureRecognizer *)tap1{
    //添加通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"quitPhoto" object:nil];
    
    
    
    
}

//点击事件的实现 (tap2)

- (void)tap2Action:(UITapGestureRecognizer *)tap2{
    
    if (self.zoomScale > 1){
        
        [self setZoomScale:1 animated:YES];
        
        //self.zoomScale = 1;
    }else{
        
        [self setZoomScale:1.5 animated:YES];
        
        //self.zoomScale = 3;
        
    }
    
    
    
    
}


//实现放大和缩小调用的方法

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    
    return _imgview;
}

- (void)setImageUrl:(NSString *)imageUrl {
    
    if (_imageUrl != imageUrl) {
        _imageUrl = [imageUrl copy];
        
        [self setNeedsLayout];
        
    }
    
    
    
    
}





//添加数据
- (void)layoutSubviews {
    
    [super layoutSubviews];
    NSString *imageUrl = self.imageUrl;
    
    
    if ([imageUrl hasSuffix:@".pdf"]) {
        _imgview.image = [UIImage imageNamed:@"pdf_image"];
    }else{
        [_imgview sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"default_image"]];
        
    }

    
    // NSLog(@"self.imageUrl:%@",self.imageUrl);
}



/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end
