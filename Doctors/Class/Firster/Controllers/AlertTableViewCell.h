//
//  AlertTableViewCell.h
//  Doctors
//
//  Created by zhonghe on 16/10/2.
//  Copyright © 2016年 XueHuiWang. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol AlertTableViewCellDelegate <NSObject>

-(void)clickAgreeBtn:(NIMSystemNotification *)notification;

@end

@interface AlertTableViewCell : UITableViewCell

@property(nonatomic,strong)UIImageView *photoView;
@property (nonatomic,strong)UILabel *titleLab;
@property (nonatomic,strong)UILabel *detailLab;
@property (nonatomic,strong)UIButton *agreeBtn;

@property (nonatomic,assign)id<AlertTableViewCellDelegate> delegate;

@property (nonatomic,strong)NIMSystemNotification *notification;


@end
