//
//  MoreActionView.h
//  ChatMessageDemo
//
//  Created by ZQ on 15/11/23.
//  Copyright © 2015年 ZQ. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol MoreActionDelegate <NSObject>

-(void)selectMoreActionWithIndex:(NSInteger)index;
@end

@interface MoreActionView : UIView
@property(nonatomic,strong)NSArray *imageArray;
@property(nonatomic,assign) id<MoreActionDelegate>delegate;
@end
