//
//  ServiceOrderTableViewCell.m
//  Doctors
//
//  Created by zhonghe on 16/10/2.
//  Copyright © 2016年 XueHuiWang. All rights reserved.
//

#import "ServiceOrderTableViewCell.h"

@implementation ServiceOrderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        [self addAllViews];
    }
    return self;
    
}

-(void)addAllViews
{
    UIView *rootView = [[UIView alloc] initWithFrame:CGRectMake(10, 10, kWidth-20, 174)];
    rootView.backgroundColor = [UIColor whiteColor];
    rootView.layer.cornerRadius = 6;
    [self.contentView addSubview:rootView];
    
    
    self.photoView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 10, 29, 29)];
    self.photoView.layer.masksToBounds = YES;
    self.photoView.image = [UIImage imageNamed:@"healthIcon"];
    self.photoView.layer.cornerRadius = 14.5;
    [rootView addSubview:self.photoView];
    
    self.nameLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.photoView.frame)+15, 10, kWidth-70-80, 20)];
    self.nameLab.textColor = DWColor(85, 85, 85);
    self.nameLab.font = [UIFont systemFontOfSize:14];
    [rootView addSubview:self.nameLab];
    
    UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(10, 50, kWidth-40, 1)];
    lineView.backgroundColor=DWColor(223, 222, 222);
    [rootView addSubview:lineView];
    
    self.titleLab = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(lineView.frame)+10, KDeviceWidth-20, 20)];
    self.titleLab.textColor = DWColor(85, 85, 85);
    self.titleLab.textAlignment = NSTextAlignmentCenter;
    self.titleLab.font = [UIFont systemFontOfSize:14];
    [rootView addSubview:self.titleLab];
    
    
    self.timeLab = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.titleLab.frame)+15, kWidth-20, 20)];
    self.timeLab.textAlignment = NSTextAlignmentCenter;

    self.timeLab.textColor = DWColor(85, 85, 85);
    self.timeLab.font = [UIFont systemFontOfSize:14];
    [rootView addSubview:self.timeLab];
    UIView *lineView2=[[UIView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(self.timeLab.frame)+15, kWidth-40, 1)];
    lineView2.backgroundColor=DWColor(223, 222, 222);
    [rootView addSubview:lineView2];

    
    
    self.checkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.checkBtn.frame = CGRectMake((KDeviceWidth-64)/2, CGRectGetMaxY(lineView2.frame)+10, 64, 25);
    [self.checkBtn setBackgroundColor:DWColor(114, 218, 102)];
    [self.checkBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.checkBtn.layer.cornerRadius = 10;
    [self.checkBtn setTitle:@"查看" forState:UIControlStateNormal];
    self.checkBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.checkBtn addTarget:self action:@selector(checkBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [rootView addSubview:self.checkBtn];
    
}

//createTime = "Oct 2, 2016 8:00:19 PM";
//customerId = 21;
//doctorId = 18;
//id = 41;
//reserveFrom = 1;
//reserveTime = "2016-12-2";
//servicePackageId = 10;
//servicePackagesName = "\U670d\U52a1\U5957\U9910\U4e00";
//updateTime = "Oct 2, 2016 8:00:19 PM";

-(void)setDic:(NSDictionary *)dic
{
    _dic = dic;
    self.nameLab.text = [NSString stringWithFormat:@"客户ID:%@",dic[@"customerId"]];
    self.titleLab.text = dic[@"servicePackagesName"];
    self.timeLab.text = [NSString stringWithFormat:@"预约时间:%@",dic[@"reserveTime"]];
}
-(void)checkBtnAction
{
    if (_delegate && [_delegate respondsToSelector:@selector(clickCheckBtn:)]) {
        [_delegate clickCheckBtn:_dic];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
