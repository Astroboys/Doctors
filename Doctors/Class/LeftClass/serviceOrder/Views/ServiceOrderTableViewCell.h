//
//  ServiceOrderTableViewCell.h
//  Doctors
//
//  Created by zhonghe on 16/10/2.
//  Copyright © 2016年 XueHuiWang. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ServiceOrderCellDelegate <NSObject>

-(void)clickCheckBtn:(NSDictionary *)dict;

@end
@interface ServiceOrderTableViewCell : UITableViewCell
@property(nonatomic,strong)UIImageView *photoView;
@property (nonatomic,strong)UILabel *nameLab;
@property (nonatomic,strong)UILabel *titleLab;
@property (nonatomic,strong)UILabel *timeLab;
@property (nonatomic,strong)UIButton *checkBtn;
@property (nonatomic,assign)id<ServiceOrderCellDelegate> delegate;
@property (nonatomic,strong)NSDictionary *dic;
@end
