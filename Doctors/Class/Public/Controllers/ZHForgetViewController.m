
//
//  ZHForgetViewController.m
//  Doctors
//
//  Created by 崔敬轩 on 16/9/23.
//  Copyright © 2016年 XueHuiWang. All rights reserved.
//

#import "ZHForgetViewController.h"
#import "Masonry.h"
#import "ZHVerifyCodeButton.h"
@interface ZHForgetViewController ()
{
    UIView *oneView;
    UIView *twoView;
    UIView *threeView;
    
    UITextField *codeText;
    ZHVerifyCodeButton *codeBtn;
    UIButton *registerTwoBtn;

    UITextField *passwordText;
    UITextField *rePasswordText;
    UIButton *registerThreeBtn;
    
    
    UIView*lineOneView;
    UIView*lineTwoView;
    UIView*lineThreeView;
    
    
    
    NSString *codeStr;

}
@property(nonatomic,strong)UILabel*titleLbl;
@property(nonatomic,strong)UILabel*phoneLbl;
@property(nonatomic,strong)UITextField*phoneText;
@property(nonatomic,strong)UIButton*registerbtn;
////
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
    
    
   
    oneView=[[UIView alloc]init];
    oneView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:oneView];
    
    [self setupOneViewUI];
    [self setupOneViewFrame];
//
    
    twoView=[[UIView alloc]init];
    twoView.backgroundColor=[UIColor whiteColor];
    twoView.hidden = YES;
    [self.view addSubview:twoView];
    
    [self setupTwoViewUI];
    [self setupTwoViewFrame];


    
    threeView=[[UIView alloc]init];
    threeView.hidden = YES;
    threeView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:threeView];
    
    [self setupThreeViewUI];
    [self setupThreeViewFrame];
    
    
    
    
    
    
    
   

}

-(void)setupOneViewUI{

    
    _titleLbl=[[UILabel alloc]init];
    _titleLbl.text=@"开启您的健康之旅";
    [_titleLbl setFont:[UIFont systemFontOfSize:14]];
    [self.view addSubview:_titleLbl];
    
   
    
    _phoneLbl=[[UILabel alloc]init];
    _phoneLbl.text=@"手机号";
    [_phoneLbl setFont:[UIFont systemFontOfSize:14]];
    [oneView addSubview:_phoneLbl];
    
    _phoneText=[[UITextField alloc]init];
    _phoneText.placeholder=@"请输入您的手机号";
    [_phoneText setFont:[UIFont systemFontOfSize:14]];
    [oneView addSubview:_phoneText];
    
    lineOneView=[[UIView alloc]init];
    lineOneView.backgroundColor=[UIColor lightGrayColor];
    [oneView addSubview:lineOneView];
    
    _registerbtn=[[UIButton alloc]init];
    [_registerbtn setTitle:@"下一步" forState:UIControlStateNormal];
    [_registerbtn addTarget:self action:@selector(nextBtnClick) forControlEvents:UIControlEventTouchUpInside];
    _registerbtn.backgroundColor=DWColor(40, 128, 194);
    self.registerbtn.clipsToBounds=YES;
    [self.registerbtn.layer setCornerRadius:5];
    [oneView addSubview:_registerbtn];
}

-(void)setupOneViewFrame{

    [self.titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(15);
        make.left.mas_equalTo(self.view.mas_left).with.offset(15);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(15);
    }];
    
    [oneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.left.mas_equalTo(self.view.mas_left);
        make.width.mas_equalTo(kWidth);
        make.bottom.mas_equalTo(self.view.mas_bottom);
    }];
    
    [self.phoneLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(oneView.mas_top).with.offset(80);
        make.left.mas_equalTo(oneView.mas_left).with.offset(30);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(15);
    }];
    
    [self.phoneText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(oneView.mas_top).with.offset(80);
        make.left.mas_equalTo(self.phoneLbl.mas_right).with.offset(5);
        make.right.mas_equalTo(oneView.mas_right).with.offset(-30);
        make.height.mas_equalTo(15);
    }];
    
    [lineOneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.phoneText.mas_bottom).with.offset(15);
        make.left.mas_equalTo(oneView.mas_left).with.offset(30);
        make.right.mas_equalTo(oneView.mas_right).with.offset(-30);
        make.height.mas_equalTo(1);
    }];
    
    [self.registerbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineOneView.mas_bottom).with.offset(40);
        make.left.mas_equalTo(oneView.mas_left).with.offset(30);
        make.right.mas_equalTo(oneView.mas_right).with.offset(-30);
        make.height.mas_equalTo(30);
    }];



}




-(void)setupTwoViewUI{
    
    
    _titleLbl=[[UILabel alloc]init];
    _titleLbl.text=@"开启您的健康之旅";
    [_titleLbl setFont:[UIFont systemFontOfSize:14]];
    [self.view addSubview:_titleLbl];
    
    
    
    
    codeText=[[UITextField alloc]init];
    codeText.placeholder=@"请输入验证码";
    [codeText setFont:[UIFont systemFontOfSize:14]];
    [twoView addSubview:codeText];
    
    
    codeBtn = [ZHVerifyCodeButton buttonWithType:UIButtonTypeCustom];
    [codeBtn addTarget:self action:@selector(codeBtnVerification) forControlEvents:UIControlEventTouchUpInside];
    [twoView addSubview:codeBtn];

    
    lineTwoView=[[UIView alloc]init];
    lineTwoView.backgroundColor=[UIColor lightGrayColor];
    [twoView addSubview:lineTwoView];
    
    registerTwoBtn=[[UIButton alloc]init];
    [registerTwoBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [registerTwoBtn addTarget:self action:@selector(nextTwoBtnClick) forControlEvents:UIControlEventTouchUpInside];
    registerTwoBtn.backgroundColor=DWColor(40, 128, 194);
    registerTwoBtn.clipsToBounds=YES;
    [registerTwoBtn.layer setCornerRadius:5];
    [twoView addSubview:registerTwoBtn];
}

-(void)setupTwoViewFrame{
    
    [self.titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(15);
        make.left.mas_equalTo(self.view.mas_left).with.offset(15);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(15);
    }];
    
    [twoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.left.mas_equalTo(self.view.mas_left);
        make.width.mas_equalTo(kWidth);
        make.bottom.mas_equalTo(self.view.mas_bottom);
    }];
    
    
    [codeText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(twoView.mas_top).with.offset(80);
        make.left.mas_equalTo(twoView.mas_left).with.offset(30);
        make.right.mas_equalTo(twoView.mas_right).with.offset(-30);
        make.height.mas_equalTo(15);
    }];
    
    [codeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(twoView.mas_top).with.offset(80);
        make.right.mas_equalTo(twoView.mas_right).with.offset(-30);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(30);
    }];

    
    [lineTwoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(codeText.mas_bottom).with.offset(15);
        make.left.mas_equalTo(twoView.mas_left).with.offset(30);
        make.right.mas_equalTo(twoView.mas_right).with.offset(-30);
        make.height.mas_equalTo(1);
    }];
    
    [registerTwoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineTwoView.mas_bottom).with.offset(40);
        make.left.mas_equalTo(twoView.mas_left).with.offset(30);
        make.right.mas_equalTo(twoView.mas_right).with.offset(-30);
        make.height.mas_equalTo(30);
    }];
    
    
    
}


-(void)setupThreeViewUI{
    
    
    _titleLbl=[[UILabel alloc]init];
    _titleLbl.text=@"开启您的健康之旅";
    [_titleLbl setFont:[UIFont systemFontOfSize:14]];
    [self.view addSubview:_titleLbl];
    
    
    
    
    passwordText=[[UITextField alloc]init];
    passwordText.placeholder=@"请输入新密码";
    [passwordText setFont:[UIFont systemFontOfSize:14]];
    [threeView addSubview:passwordText];
    
    lineThreeView=[[UIView alloc]init];
    lineThreeView.backgroundColor=[UIColor lightGrayColor];
    [threeView addSubview:lineThreeView];
    
    
    rePasswordText=[[UITextField alloc]init];
    rePasswordText.placeholder=@"请确认新密码";
    [rePasswordText setFont:[UIFont systemFontOfSize:14]];
    [threeView addSubview:rePasswordText];
    
    
    registerThreeBtn=[[UIButton alloc]init];
    [registerThreeBtn setTitle:@"完成" forState:UIControlStateNormal];
    [registerThreeBtn addTarget:self action:@selector(nextThreeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    registerThreeBtn.backgroundColor=DWColor(40, 128, 194);
    registerThreeBtn.clipsToBounds=YES;
    [registerThreeBtn.layer setCornerRadius:5];
    [threeView addSubview:registerThreeBtn];
}

-(void)setupThreeViewFrame{
    
    [self.titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(15);
        make.left.mas_equalTo(self.view.mas_left).with.offset(15);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(15);
    }];
    
    [threeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.left.mas_equalTo(self.view.mas_left);
        make.width.mas_equalTo(kWidth);
        make.bottom.mas_equalTo(self.view.mas_bottom);
    }];
    
    
    [passwordText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(threeView.mas_top).with.offset(80);
        make.left.mas_equalTo(threeView.mas_left).with.offset(30);
        make.right.mas_equalTo(threeView.mas_right).with.offset(-30);
        make.height.mas_equalTo(15);
    }];
    
    [lineThreeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(passwordText.mas_bottom).with.offset(15);
        make.left.mas_equalTo(threeView.mas_left).with.offset(30);
        make.right.mas_equalTo(threeView.mas_right).with.offset(-30);
        make.height.mas_equalTo(1);
    }];
    
    [rePasswordText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineThreeView.mas_bottom).with.offset(15);
        make.left.mas_equalTo(threeView.mas_left).with.offset(30);
        make.right.mas_equalTo(threeView.mas_right).with.offset(-30);
        make.height.mas_equalTo(15);
    }];
    
    [registerThreeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(rePasswordText.mas_bottom).with.offset(40);
        make.left.mas_equalTo(threeView.mas_left).with.offset(30);
        make.right.mas_equalTo(threeView.mas_right).with.offset(-30);
        make.height.mas_equalTo(30);
    }];
    
    
    
}

- (void)codeBtnVerification {
    
    BOOL isMobile = [MethodUtil isMobileNumber:_phoneText.text];
    if(!isMobile){
        [MBManager showBriefMessage:@"请输入正确的手机号" InView:self.view];
        return;
    }
    //type 1为注册 2为找回密码
    NSDictionary *dic = @{@"mobile":_phoneText.text,@"type":@"2"};
    NSString *url = [NSString stringWithFormat:@"%@%@",BaseUrl,@"sysSendMessage/getCode"];
    [NetWorkingManager requestGETDataWithPath:url withParamters:dic withProgress:^(float progress) {
        
    } success:^(BOOL isSuccess, id responseObject) {
        NSLog(@"%@",responseObject);
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            codeStr = responseObject[@"code"];

        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error.userInfo);
        
    }];
    
    // 调用短信验证码接口
    [codeBtn timeFailBeginFrom:60];  // 倒计时60s
}


-(void)nextBtnClick{
    BOOL isMobile = [MethodUtil isMobileNumber:_phoneText.text];
    if(!isMobile){
        [MBManager showBriefMessage:@"请输入正确的手机号" InView:self.view];
        return;
    }

    oneView.hidden = YES;
    twoView.hidden = NO;
}

-(void)nextTwoBtnClick
{
    if(codeText.text.length<1){
        [MBManager showBriefMessage:@"验证码不能为空" InView:self.view];
        return;
    }
    if(![codeText.text isEqualToString:codeText.text]){
        [MBManager showBriefMessage:@"验证码不正确" InView:self.view];
        return;
    }
    
    [codeBtn timeFailBeginFrom:1]; // 处理请求成功但是匹配不成功的情况，并不需要执行倒计时功能

    oneView.hidden = YES;
    twoView.hidden = YES;
    threeView.hidden = NO;
}

-(void)nextThreeBtnClick
{
    if (![passwordText.text isEqualToString:rePasswordText.text]) {
        [MBManager showBriefMessage:@"两次密码输入不一致" InView:self.view];
        return;
    }
    if (passwordText.text.length<1 || rePasswordText.text.length<1) {
        [MBManager showBriefMessage:@"密码不能为空" InView:self.view];
        return;
    }
    [MBManager showLoadingInView:self.view];
    NSDictionary *dic = @{@"mobile":_phoneText.text,@"password":passwordText.text};
    NSString *url = [NSString stringWithFormat:@"%@%@",BaseUrl,@"sysSendMessage/getCode"];
    [NetWorkingManager requestGETDataWithPath:url withParamters:dic withProgress:^(float progress) {
        
    } success:^(BOOL isSuccess, id responseObject) {
        [MBManager hideAlert];
        NSLog(@"%@",responseObject);
    } failure:^(NSError *error) {
        [MBManager hideAlert];
        NSLog(@"%@",error.userInfo);
        
    }];

    
    
}
-(void)forgetClickleft{
    [NetWorkingManager cancelAllNetworkRequest];
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
