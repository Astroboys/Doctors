//
//  PhotoScrollview.h
//  familyTest
//
//  Created by Gao on 15-1-15.
//  Copyright (c) 2015年 huangxiaoya. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface PhotoScrollview : UIScrollView<UIScrollViewDelegate>{
    
    
    UIImageView *_imgview;//图片视图
    
}
@property (nonatomic, copy) NSString *imageUrl;

@end


