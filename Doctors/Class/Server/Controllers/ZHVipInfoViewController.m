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
#import "ZHPrescribeViewController.h"
#import "PhotoViewController.h"
#import "LookPdfViewController.h"
#import "NTESSessionViewController.h"
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

@property(nonatomic,strong)NSArray*viewArray;

@end

@implementation ZHVipInfoViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title=@"客户信息";
    self.view.backgroundColor=DWColor(40, 128, 194);
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];

    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showPicture:) name:@"showPicture" object:nil];
    UIImage* image1 = [UIImage imageNamed:@"navigationbar_back_withtext"];
    image1 = [image1 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIBarButtonItem* item1 = [[UIBarButtonItem alloc]initWithImage:image1 style:UIBarButtonItemStylePlain target:self action:@selector(vipClickleft)];
    
    self.navigationItem.leftBarButtonItem=item1;
    
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    UIImage* image2 = [UIImage imageNamed:@"chat_message"];
    // 告诉系统以后这张图片不进行默认的渲染
    image2 = [image2 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem* item2 = [[UIBarButtonItem alloc]initWithImage:image2 style:UIBarButtonItemStylePlain target:self action:@selector(chatMessage)];
    self.navigationItem.rightBarButtonItem = item2;
    
    
    RecordView*record=[[RecordView alloc]init];
    record.customId = self.dataDic[@"id"];

    DiagnoseView*dia=[[DiagnoseView alloc]init];
    dia.customId = self.dataDic[@"id"];
    JudgeView*juge=[[JudgeView alloc]init];
    juge.customId = self.dataDic[@"id"];
    
    _viewArray=@[record,dia,juge];
    
    [self setupUI];
    
    [self setupFrame];
    
}

-(void)setupUI{
    
    _custIcon=[[UIImageView alloc]init];
    _custIcon.image=[UIImage imageNamed:@"vipIcon"];
    _custIcon.clipsToBounds=YES;
    [_custIcon.layer setCornerRadius:30];
    [self.view addSubview:_custIcon];

    _custName=[[UILabel alloc]init];
    _custName.text=self.dataDic[@"name"];
    [_custName setFont:[UIFont systemFontOfSize:15]];
    _custName.textColor = [UIColor whiteColor];
    [self.view addSubview:_custName];
    
    _custSex=[[UIImageView alloc]init];

    NSString *sexStr = self.dataDic[@"sex"];
    if (sexStr.intValue == 1) {
        _custSex.image=[UIImage imageNamed:@"manIcon"];
    }else{
        _custSex.image=[UIImage imageNamed:@"womenIcon"];
    }
    
    
    [self.view addSubview:_custSex];
    
    _custAge=[[UILabel alloc]init];
    [_custAge setFont:[UIFont systemFontOfSize:12]];
    _custAge.text=@"生日:";
    _custAge.textColor = [UIColor whiteColor];
    [self.view addSubview:_custAge];
    
    _ageValue=[[UILabel alloc]init];
    [_ageValue setFont:[UIFont systemFontOfSize:12]];
    _ageValue.text=self.dataDic[@"birthday"];
    _ageValue.textColor = [UIColor whiteColor];

    [self.view addSubview:_ageValue];
    
    _disease=[[UILabel alloc]init];
    [_disease setFont:[UIFont systemFontOfSize:12]];
    _disease.textColor = [UIColor whiteColor];

    _disease.text=self.dataDic[@"question"];
    [self.view addSubview:_disease];
    
    
    _browseView=[[UIView alloc]init];
    _browseView.backgroundColor=[UIColor lightGrayColor];
    [self.view addSubview:_browseView];
    
    _prescribeBtn=[[UIButton alloc]init];
    [_prescribeBtn setTitle:@"在线开处方" forState:UIControlStateNormal];
    [_prescribeBtn addTarget:self action:@selector(prescribeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_prescribeBtn setTintColor:[UIColor whiteColor]];
    _prescribeBtn.backgroundColor=DWColor(40, 128, 194);
    [self.browseView addSubview:_prescribeBtn];
    
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
        make.width.mas_equalTo(130);
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
    
    _scView=[[LXSegmentScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width,KscViewH) titleArray:@[@"健康档案",@"就医记录",@"效果评价"] contentViewArray:self.viewArray];
    
    [self.browseView addSubview:_scView];
    
    [self.prescribeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.scView.mas_bottom);
        make.left.mas_equalTo(self.view.mas_left);
        make.width.mas_equalTo(kWidth);
        make.bottom.mas_equalTo(self.view.mas_bottom);
        
    }];
    
}

-(void)prescribeBtnClick{
//跳转开处方控制器界面
    ZHPrescribeViewController*preVc=[[ZHPrescribeViewController alloc]init];
    preVc.personInfo = self.dataDic;
    [self.navigationController pushViewController:preVc animated:YES];
    
}
-(void)chatMessage
{
    //创建session,这里聊天对象预设为韩梅梅，此账号也是事先提交到此App下的
    NIMSession *session = [NIMSession session:self.dataDic[@"memPhone"] type:NIMSessionTypeP2P];
    //创建聊天页，这个页面继承自 NIMKit 中的组件 NIMSessionViewController
    NTESSessionViewController *vc = [[NTESSessionViewController alloc] initWithSession:session];
    [self.navigationController pushViewController:vc animated:YES];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)vipClickleft{
    
    [self.navigationController popViewControllerAnimated:YES];

}


- (void)showPicture:(NSNotification *)notif{
    {
        //创建模态对象
        PhotoViewController *photoVc = [[PhotoViewController alloc]init];
        //把数据传递到photoVc中
        
        NSDictionary *dic = notif.userInfo;
        
        NSMutableArray *imageArray = dic[@"picture"];
        NSString *indexStr = dic[@"index"];
        NSString *selectImage = imageArray[indexStr.intValue];
        if ([selectImage hasSuffix:@".pdf"]) {
            LookPdfViewController *vc = [[LookPdfViewController alloc] init];
            vc.urlStr = selectImage;
            [self.navigationController pushViewController:vc animated:YES];
            
        }else{
            NSIndexPath *index = [NSIndexPath indexPathForItem:indexStr.integerValue inSection:0];
            photoVc.images = imageArray;
            photoVc.indexpath = index;
            [self presentViewController:photoVc animated:YES completion:nil];
        }
        
        
        
    }
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"showPicture" object:nil];
}

@end
