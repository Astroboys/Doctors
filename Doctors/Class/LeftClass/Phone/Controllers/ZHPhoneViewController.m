//
//  ZHPhoneViewController.m
//  YCSideslip
//
//  Created by 崔敬轩 on 16/8/20.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ZHPhoneViewController.h"
#import "Masonry.h"
@interface ZHPhoneViewController ()

@property(nonatomic,strong)UIView*firstView;
@property(nonatomic,strong)UILabel*yuanshiLbl;
@property(nonatomic,strong)UITextField*yuanshiText;
@property(nonatomic,strong)UILabel*xinsheLbl;
@property(nonatomic,strong)UITextField*xinsheText;
@property(nonatomic,strong)UILabel*tuyanLbl;
@property(nonatomic,strong)UITextField*tuyanText;
@property(nonatomic,strong)UILabel*duanxinLbl;
@property(nonatomic,strong)UITextField*duanxinText;
@property(nonatomic,strong)UIButton*quereBtn;


@end

@implementation ZHPhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:19],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    self.view.backgroundColor = DWColor(243, 243, 243);
    self.title = @"更换手机";
    UIImage* image1 = [UIImage imageNamed:@"navigationbar_back_withtext"];
    // 告诉系统以后这张图片不进行默认的渲染
    image1 = [image1 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    // 创建活动的按钮
    UIBarButtonItem* item1 = [[UIBarButtonItem alloc]initWithImage:image1 style:UIBarButtonItemStylePlain target:self action:@selector(phoneClickleft)];
    self.navigationItem.leftBarButtonItem = item1;


    [self setupUI];
    [self setupFrame];
}


-(void)phoneClickleft{
    
    [self.yuanshiText resignFirstResponder];
    [self.xinsheText resignFirstResponder];
    [self.tuyanText resignFirstResponder];
    [self.duanxinText resignFirstResponder];
    
    [self.navigationController popViewControllerAnimated:YES];

    
}


-(void)setupUI{
    
    //姓名
    //_firstView=[[UIView alloc]initWithFrame:CGRectMake(0, 20,kWidth, 250)];
    _firstView=[[UIView alloc]init];
    _firstView.backgroundColor =[UIColor whiteColor];
    
    
    //UILabel*yuanshiLbl=[[UILabel alloc]initWithFrame:CGRectMake(20, 0, 80, 50)];
    _yuanshiLbl=[[UILabel alloc]init];
    _yuanshiLbl.text =@"原手机号:";
    [_yuanshiLbl setTextAlignment:NSTextAlignmentRight];
    [_yuanshiLbl setFont:[UIFont systemFontOfSize:16]];
    //UITextField*yuanshiText=[[UITextField alloc]initWithFrame:CGRectMake(100,0 , kWidth-80-20, 50)];
    _yuanshiText=[[UITextField alloc]init];
    _yuanshiText.placeholder =@"输入手机号";
    [_yuanshiText setFont:[UIFont systemFontOfSize:16]];
    [self.firstView addSubview:_yuanshiLbl];
    [self.firstView addSubview:_yuanshiText];
    
    //昵称
    //UILabel*xinsheLbl=[[UILabel alloc]initWithFrame:CGRectMake(20, 50, 80, 50)];
    _xinsheLbl=[[UILabel alloc]init];
    _xinsheLbl.text =@"新手机号:";
    [_xinsheLbl setTextAlignment:NSTextAlignmentRight];
    [_xinsheLbl setFont:[UIFont systemFontOfSize:16]];
    //UITextField*xinsheText=[[UITextField alloc]initWithFrame:CGRectMake(100,50 , kWidth-80-20, 50)];
    _xinsheText=[[UITextField alloc]init];
    _xinsheText.placeholder =@"请输入手机号";
    [_xinsheText setFont:[UIFont systemFontOfSize:16]];
    [self.firstView addSubview:_xinsheText];
    [self.firstView addSubview:_xinsheLbl];
    
    //
    //UILabel*tuyanLbl=[[UILabel alloc]initWithFrame:CGRectMake(20, 100, 80, 50)];
    _tuyanLbl=[[UILabel alloc]init];
    _tuyanLbl.text =@"图验证码:";
    [_tuyanLbl setTextAlignment:NSTextAlignmentRight];
    [_tuyanLbl setFont:[UIFont systemFontOfSize:16]];
    //UITextField*tuyanText=[[UITextField alloc]initWithFrame:CGRectMake(100,100 , kWidth-80-20, 50)];
    _tuyanText=[[UITextField alloc]init];
    [_tuyanText setFont:[UIFont systemFontOfSize:16]];
    _tuyanText.placeholder =@"图片验证码";
    [self.firstView addSubview:_tuyanLbl];
    [self.firstView addSubview:_tuyanText];
    
    //[self.view addSubview:_firstView];
    
    //UILabel*duanxinLbl=[[UILabel alloc]initWithFrame:CGRectMake(20, 150, 80, 50)];
    _duanxinLbl=[[UILabel alloc]init];
    _duanxinLbl.text =@"验证码:";
    [_duanxinLbl setTextAlignment:NSTextAlignmentRight];
    [_duanxinLbl setFont:[UIFont systemFontOfSize:16]];
    //UITextField*duanxinText=[[UITextField alloc]initWithFrame:CGRectMake(100,150 , kWidth-80-20, 50)];
    _duanxinText=[[UITextField alloc]init];
    _duanxinText.placeholder =@"短信验证码";
    [_duanxinText setFont:[UIFont systemFontOfSize:16]];
    [self.firstView addSubview:_duanxinLbl];
    [self.firstView addSubview:_duanxinText];
    
    [self.view addSubview:_firstView];

    
    //UIButton*quereBtn=[[UIButton alloc]initWithFrame:CGRectMake(20, 200, kWidth-40, 40)];
    _quereBtn=[[UIButton alloc]init];
    _quereBtn.backgroundColor=[UIColor colorWithRed:100/255.0 green:178/255.0 blue:241/255.0 alpha:1] ;
    
    [_quereBtn setTitle:@"确认修改" forState:UIControlStateNormal];
    
    [_quereBtn.layer setCornerRadius:5];
    [_quereBtn.layer setMasksToBounds:YES];
    
    [self.firstView addSubview:_quereBtn];
    
    
    
}

-(void)setupFrame{
    
    [self.firstView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(10);
        make.left.mas_equalTo(self.view.mas_left).with.offset(5);
        make.right.mas_equalTo(self.view.mas_right).with.offset(-5);
        make.height.mas_equalTo(160);
    }];
    
    [self.yuanshiLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(10);
        make.left.mas_equalTo(20);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(70);
    }];
    
    [self.yuanshiText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(10);
        make.left.mas_equalTo(self.yuanshiLbl.mas_right);
        make.height.mas_equalTo(40);
        make.right.equalTo(self.view.mas_right).with.offset(-20);
    }];
    
    [self.xinsheLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.yuanshiLbl.mas_bottom);
        make.left.mas_equalTo(self.yuanshiLbl.mas_left);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(70);
    }];
    [self.xinsheText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.yuanshiText.mas_bottom);
        make.left.mas_equalTo(self.yuanshiText.mas_left);
        make.height.mas_equalTo(40);
        make.right.equalTo(self.view.mas_right).with.offset(-20);
    }];

    [self.tuyanLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.xinsheLbl.mas_bottom);
        make.left.mas_equalTo(self.xinsheLbl.mas_left);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(70);
    }];
    
    [self.tuyanText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.xinsheText.mas_bottom);
        make.left.mas_equalTo(self.tuyanLbl.mas_right);
        make.height.mas_equalTo(40);
        make.right.equalTo(self.view.mas_right).with.offset(-20);
    }];

    [self.duanxinLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tuyanLbl.mas_bottom);
        make.left.mas_equalTo(self.tuyanLbl.mas_left);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(70);
    }];
    [self.duanxinText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tuyanText.mas_bottom);
        make.left.mas_equalTo(self.tuyanLbl.mas_right);
        make.height.mas_equalTo(40);
        make.right.equalTo(self.view.mas_right).with.offset(-20);
    }];
    
    [self.quereBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.duanxinText.mas_bottom).with.offset(20);
        make.left.mas_equalTo(self.firstView.mas_left).with.offset(40);
        make.height.mas_equalTo(30);
        make.right.equalTo(self.firstView.mas_right).with.offset(-40);
    }];

}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.yuanshiText resignFirstResponder];
    [self.xinsheText resignFirstResponder];
    [self.tuyanText resignFirstResponder];
    [self.duanxinText resignFirstResponder];
    
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
