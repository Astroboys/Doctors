
//
//  ZHForgetViewController.m
//  Doctors
//
//  Created by 崔敬轩 on 16/9/23.
//  Copyright © 2016年 XueHuiWang. All rights reserved.
//

#import "ZHForgetViewController.h"
#import "Masonry.h"

@interface ZHForgetViewController ()

@property(nonatomic,strong)UIView*registerView;
@property(nonatomic,strong)UILabel*titleLbl;
@property(nonatomic,strong)UILabel*phoneLbl;
@property(nonatomic,strong)UITextField*phoneText;
@property(nonatomic,strong)UIView*lineView;
@property(nonatomic,strong)UIButton*registerbtn;

@end

@implementation ZHForgetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor lightGrayColor];
    UIImage* image1 = [UIImage imageNamed:@"navigationbar_back_withtext"];
    image1 = [image1 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIBarButtonItem* item2 = [[UIBarButtonItem alloc]initWithImage:image1 style:UIBarButtonItemStylePlain target:self action:@selector(forgetClickleft)];
    
    self.navigationItem.title=@"找回密码";
    self.navigationItem.leftBarButtonItem = item2;
    
    [self setupUI];
    [self setupFrame];
    
}

-(void)setupUI{

    _titleLbl=[[UILabel alloc]init];
    _titleLbl.text=@"开启您的健康之旅";
    [_titleLbl setFont:[UIFont systemFontOfSize:14]];
    [self.view addSubview:_titleLbl];
    
    _registerView=[[UIView alloc]init];
    [self.view addSubview:_registerView];
    self.registerView.backgroundColor=[UIColor whiteColor];
    
    _phoneLbl=[[UILabel alloc]init];
    _phoneLbl.text=@"手机号";
    [_phoneLbl setFont:[UIFont systemFontOfSize:14]];
    [self.registerView addSubview:_phoneLbl];
    
    _phoneText=[[UITextField alloc]init];
    _phoneText.placeholder=@"请输入您的手机号";
    [_phoneText setFont:[UIFont systemFontOfSize:14]];
    [self.registerView addSubview:_phoneText];
    
    _lineView=[[UIView alloc]init];
    _lineView.backgroundColor=[UIColor lightGrayColor];
    [self.registerView addSubview:_lineView];
    
    _registerbtn=[[UIButton alloc]init];
    [_registerbtn setTitle:@"下一步" forState:UIControlStateNormal];
    [_registerbtn addTarget:self action:@selector(nextBtnClick) forControlEvents:UIControlEventTouchUpInside];
    _registerbtn.backgroundColor=DWColor(40, 128, 194);
    self.registerbtn.clipsToBounds=YES;
    [self.registerbtn.layer setCornerRadius:5];
    [self.registerView addSubview:_registerbtn];
}

-(void)setupFrame{

    [self.titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(15);
        make.left.mas_equalTo(self.view.mas_left).with.offset(15);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(15);
    }];
    
    [self.registerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.left.mas_equalTo(self.view.mas_left);
        make.width.mas_equalTo(kWidth);
        make.bottom.mas_equalTo(self.view.mas_bottom);
    }];
    
    [self.phoneLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.registerView.mas_top).with.offset(80);
        make.left.mas_equalTo(self.registerView.mas_left).with.offset(30);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(15);
    }];
    
    [self.phoneText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.registerView.mas_top).with.offset(80);
        make.left.mas_equalTo(self.phoneLbl.mas_right).with.offset(5);
        make.right.mas_equalTo(self.registerView.mas_right).with.offset(-30);
        make.height.mas_equalTo(15);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.phoneLbl.mas_bottom).with.offset(15);
        make.left.mas_equalTo(self.registerView.mas_left).with.offset(30);
        make.right.mas_equalTo(self.registerView.mas_right).with.offset(-30);
        make.height.mas_equalTo(1);
    }];
    
    [self.registerbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lineView.mas_bottom).with.offset(15);
        make.left.mas_equalTo(self.registerView.mas_left).with.offset(30);
        make.right.mas_equalTo(self.registerView.mas_right).with.offset(-30);
        make.height.mas_equalTo(30);
    }];



}

-(void)nextBtnClick{

    
}

-(void)forgetClickleft{
    
    [self.navigationController popViewControllerAnimated:YES];
    
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
