//
//  ZHVerifyCodeButton.h
//  Doctors
//
//  Created by 崔敬轩 on 16/9/28.
//  Copyright © 2016年 XueHuiWang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZHVerifyCodeButton : UIButton

// 由于有些时间需求不同，特意露出方法，倒计时时间次数
- (void)timeFailBeginFrom:(NSInteger)timeCount;


@end
