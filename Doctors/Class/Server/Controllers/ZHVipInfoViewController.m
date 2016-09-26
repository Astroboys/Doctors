//
//  ZHVipInfoViewController.m
//  Doctors
//
//  Created by 崔敬轩 on 16/9/22.
//  Copyright © 2016年 XueHuiWang. All rights reserved.
//

#import "ZHVipInfoViewController.h"
#import "Masonry.h"
#import "RecordView.h"
#import "DiagnoseView.h"
#import "JudgeView.h"
#import "UIView+Frame.h"
#import "LXSegmentScrollView.h"

@interface ZHVipInfoViewController ()

@property(nonatomic,strong)UILabel*custName;
@property(nonatomic,strong)UIImageView*custIcon;
@property(nonatomic,strong)UIImageView*custSex;
@property(nonatomic,strong)UILabel*custAge;
@property(nonatomic,strong)UILabel*ageValue;
@property(nonatomic,strong)UILabel*disease;
@property(nonatomic,strong)UILabel*icon;

@property(nonatomic,strong)UIView*browseView;

@property(nonatomic,strong)UIView*lineView;

@property(nonatomic,strong)UIButton*prescribeBtn;

@property(nonatomic,strong)LXSegmentScrollView *scView;

@end

@implementation ZHVipInfoViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title=@"客户信息";
    self.view.backgroundColor=DWColor(40, 128, 194);
    UIImage* image1 = [UIImage imageNamed:@"navigationbar_back_withtext"];
    image1 = [image1 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIBarButtonItem* item1 = [[UIBarButtonItem alloc]initWithImage:image1 style:UIBarButtonItemStylePlain target:self action:@selector(vipClickleft)];
    
    self.navigationItem.leftBarButtonItem=item1;
    
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    RecordView*record=[[RecordView alloc]init];
    DiagnoseView*dia=[[DiagnoseView alloc]init];
    JudgeView*juge=[[JudgeView alloc]init];
    
    NSArray*array=@[record,dia,juge];
    
    [self setupUI];
    [self setupFrame];

    LXSegmentScrollView *scView=[[LXSegmentScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width,KscViewH) titleArray:@[@"电子病历",@"就医记录",@"效果评价"] contentViewArray:array];
    NSLog(@"%f", self.view.bounds.size.height);
    self.scView=scView;
    [self.browseView addSubview:scView];
    
}

-(void)setupUI{
    
    _custIcon=[[UIImageView alloc]init];
    _custIcon.image=[UIImage imageNamed:@"vipIcon"];
    _custIcon.clipsToBounds=YES;
    [_custIcon.layer setCornerRadius:30];
    [self.view addSubview:_custIcon];

    _custName=[[UILabel alloc]init];
    _custName.text=@"王美丽";
    [_custName setFont:[UIFont systemFontOfSize:16]];
    [self.view addSubview:_custName];
    
    _custSex=[[UIImageView alloc]init];
    _custSex.image=[UIImage imageNamed:@"女"];
    [self.view addSubview:_custSex];
    
    _custAge=[[UILabel alloc]init];
    [_custAge setFont:[UIFont systemFontOfSize:14]];
    _custAge.text=@"年龄:";
    [self.view addSubview:_custAge];
    
    _ageValue=[[UILabel alloc]init];
    [_ageValue setFont:[UIFont systemFontOfSize:14]];
    _ageValue.text=@"21";
    [self.view addSubview:_ageValue];
    
    _disease=[[UILabel alloc]init];
    [_disease setFont:[UIFont systemFontOfSize:14]];
    _disease.text=@"高血压,冠心病等";
    [self.view addSubview:_disease];
    
    
    _browseView=[[UIView alloc]init];
    _browseView.backgroundColor=[UIColor lightGrayColor];
    [self.view addSubview:_browseView];
    
    _prescribeBtn=[[UIButton alloc]init];
    _prescribeBtn.backgroundColor=[UIColor redColor];
    
}

-(void)setupFrame{
    //头像
    [self.custIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.view.mas_top).with.offset(32);
        make.left.mas_equalTo(self.view.mas_left).with.offset(30);
        make.height.mas_equalTo(60);
        make.width.mas_equalTo(60);
        
    }];
    
    //客户姓名
    [self.custName mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.view.mas_top).with.offset(34);
        make.left.mas_equalTo(self.custIcon.mas_right).with.offset(12);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(16);
        
    }];
    //男女
    [self.custSex mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.view.mas_top).with.offset(34);
        make.left.mas_equalTo(self.custName.mas_right).with.offset(5);
        make.width.mas_equalTo(16);
        make.height.mas_equalTo(16);
        
    }];

    //年龄：
    [self.custAge mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.custName.mas_bottom).with.offset(8);
        make.left.mas_equalTo(self.custIcon.mas_right).with.offset(12);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(14);
        
    }];

    //年龄value
    [self.ageValue mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.custName.mas_bottom).with.offset(8);
        make.left.mas_equalTo(self.custAge.mas_right).with.offset(8);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(14);
        
    }];
    //病症
    [self.disease mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.custAge.mas_bottom).with.offset(8);
        make.left.mas_equalTo(self.custIcon.mas_right).with.offset(12);
        make.right.mas_equalTo(self.view.mas_right).with.offset(-30);
        make.height.mas_equalTo(14);
        
    }];
    //
    [self.browseView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.disease.mas_bottom).with.offset(34);
        make.left.mas_equalTo(self.view.mas_left);
        make.width.mas_equalTo(kWidth);
        make.bottom.mas_equalTo(self.view.mas_bottom);
        
    }];
    
   }


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)vipClickleft{
    
    [self.navigationController popViewControllerAnimated:YES];

}

@end
