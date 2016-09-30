
//
//  ZHAboutViewController.m
//  Doctors
//
//  Created by 崔敬轩 on 16/9/29.
//  Copyright © 2016年 XueHuiWang. All rights reserved.
//

#import "ZHAboutViewController.h"
#import "Masonry.h"

@interface ZHAboutViewController ()

@property(nonatomic,strong)UIImageView*aboutIcon;
@property(nonatomic,strong)UILabel*versionLbl;
@property(nonatomic,strong)UITextView*aboutTextView;
@property(nonatomic,strong)UILabel*aboutLbl;
@property(nonatomic,strong)UILabel*companyLbl;
@property(nonatomic,strong)UILabel*eCompanyLbl;

@end

@implementation ZHAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=DWColor(245, 245, 245);
    self.title = @"关于";
    UIImage* image1 = [UIImage imageNamed:@"navigationbar_back_withtext"];
    // 告诉系统以后这张图片不进行默认的渲染
    image1 = [image1 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    // 创建活动的按钮
    UIBarButtonItem* item1 = [[UIBarButtonItem alloc]initWithImage:image1 style:UIBarButtonItemStylePlain target:self action:@selector(aboutClickleft)];
    self.navigationItem.leftBarButtonItem = item1;
    
    [self setupUI];
    [self setupFrame];
}

-(void)aboutClickleft{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(void)setupUI{
    
    _aboutIcon=[[UIImageView alloc]init];
    _aboutIcon.image=[UIImage imageNamed:@"aboutIcon"];
    [self.view addSubview:_aboutIcon];
    
    _versionLbl=[[UILabel alloc]init];
    _versionLbl.text=@"当前版本 v3.1.0";
    [_versionLbl setFont:[UIFont systemFontOfSize:16]];
    [_versionLbl setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:_versionLbl];
    
    _aboutTextView=[[UITextView alloc]init];
    _aboutTextView.editable=NO;
    _aboutTextView.text=@"        天使团队借鉴国外成熟的健康管理模式，又结合中国国情和现状，创造性地推出了适合中国人就医观念的健康管理新模式——天使健康管理（HEAP），以临床医学、预防医学、社会医学、中医养生学、心理学、运动学、营养学等理论知识为核心，通过专业技术人员对客户健康状况、重大疾病风险、心理特质等进行评估分析，继而提供个性化的健康处方、养生保健、慢病管理、名医预约等增值服务，帮助客户将病症消除在萌芽状态，始终保持良好的健康与活力。开启了中国大陆健康行业的新天地，深获各界好评。";
    [_aboutTextView setFont:[UIFont systemFontOfSize:16]];
    [self.view addSubview:_aboutTextView];
 
    _aboutLbl=[[UILabel alloc]init];
    [self.view addSubview:_aboutLbl];
    
    _companyLbl=[[UILabel alloc]init];
    _companyLbl.text=@"天使健康管理有限公司";
    [_companyLbl setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:_companyLbl];
    
    _eCompanyLbl=[[UILabel alloc]init];
    _eCompanyLbl.text=@"Angel Health Management.Ltd";
    [_eCompanyLbl setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:_eCompanyLbl];
    
}

-(void)setupFrame{
    
    [self.aboutTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(kWidth-60);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.centerY.mas_equalTo(self.view.mas_centerY);
        make.height.mas_equalTo(200);
    }];

    
    [self.aboutIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).with.offset(30);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(60);
    }];
    
    [self.versionLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.aboutIcon.mas_bottom).with.offset(10);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(30);
    }];

    
    [self.eCompanyLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_bottom).with.offset(-40);
        make.width.mas_equalTo(kWidth-60);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.height.mas_equalTo(30);
    }];
    [self.companyLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.eCompanyLbl.mas_top).with.offset(-10);
        make.width.mas_equalTo(kWidth-60);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.height.mas_equalTo(30);
    }];

    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
