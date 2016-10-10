//
//  ZHRegisterViewController.m
//  Doctors
//
//  Created by 崔敬轩 on 16/8/24.
//  Copyright © 2016年 崔敬轩. All rights reserved.
//

#import "ZHRegisterViewController.h"
#import "Masonry.h"
#import "SVProgressHUD.h"
#import "NTESDemoService.h"
#import "ZHVerifyCodeButton.h"
#import "NetWorkingManager.h"
#import "NSString+NTES.h"
#import "MethodUtil.h"
@interface ZHRegisterViewController ()
{
    NSString *sexStr;
    int checkCode;
}
@property(nonatomic,strong)UIView*registerView;
@property(nonatomic,strong)UILabel*titleLbl;
@property(nonatomic,strong)UILabel*phoneLbl;
@property(nonatomic,strong)UITextField*phoneText;
@property(nonatomic,strong)UIView*lineView;

@property(nonatomic,strong)UILabel*testLbl;
@property(nonatomic,strong)UITextField*testText;
@property(nonatomic,strong)UIView*lineView2;


@property(nonatomic,strong)UILabel*nameLbl;
@property(nonatomic,strong)UITextField*nameText;
@property(nonatomic,strong)UIView*lineView1;

@property(nonatomic,strong)UILabel*identLbl;
@property(nonatomic,strong)UITextField*identText;
@property(nonatomic,strong)UIView*lineView3;

@property(nonatomic,strong)UILabel*sexLbl;
@property(nonatomic,strong)UISegmentedControl *segmentControl;
@property(nonatomic,strong)UILabel*switchLbl;
@property(nonatomic,strong)UIView*lineView4;

@property(nonatomic,strong)UILabel*passwordLbl;
@property(nonatomic,strong)UITextField*passwordText;
@property(nonatomic,strong)UIView*lineView5;

@property(nonatomic,strong)UILabel*repasswordLbl;
@property(nonatomic,strong)UITextField*repassText;
@property(nonatomic,strong)UIView*lineView6;

@property(nonatomic,strong)UIButton*registerbtn;
@property(nonatomic,strong)UIButton*backBtn;

@property (nonatomic, strong) ZHVerifyCodeButton *codeBtn;


@end

@implementation ZHRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    UIImage* image1 = [UIImage imageNamed:@"navigationbar_back_withtext"];
    image1 = [image1 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIBarButtonItem* item2 = [[UIBarButtonItem alloc]initWithImage:image1 style:UIBarButtonItemStylePlain target:self action:@selector(registerClickleft)];
    
    self.navigationItem.title=@"注册";
    self.navigationItem.leftBarButtonItem = item2;
    
    [self setupUI];
    [self setupFrame];
}

-(void)setupUI{

    _titleLbl=[[UILabel alloc]init];
    _titleLbl.text=@"开启您的健康之旅";
    _titleLbl.textColor = DWColor(85, 85, 85);
    [_titleLbl setFont:[UIFont systemFontOfSize:14]];
    [self.view addSubview:_titleLbl];
    sexStr = @"男";
    _registerView=[[UIView alloc]init];
    [self.view addSubview:_registerView];
    self.registerView.backgroundColor=[UIColor whiteColor];
    
    _phoneLbl=[[UILabel alloc]init];
    _phoneLbl.text=@"手机号";
    _phoneLbl.textColor = DWColor(85, 85, 85);

    [_phoneLbl setFont:[UIFont systemFontOfSize:14]];
    [self.registerView addSubview:_phoneLbl];
    
    _phoneText=[[UITextField alloc]init];
    _phoneText.placeholder=@"请输入您的手机号";
    _phoneText.textColor = DWColor(85, 85, 85);

    [_phoneText setFont:[UIFont systemFontOfSize:14]];
    [self.registerView addSubview:_phoneText];
    
    _lineView=[[UIView alloc]init];
    _lineView.backgroundColor=[UIColor lightGrayColor];
    [self.registerView addSubview:_lineView];

    _testLbl=[[UILabel alloc]init];
    _testLbl.text=@"验证码";
    _testLbl.textColor = DWColor(85, 85, 85);

    [_testLbl setFont:[UIFont systemFontOfSize:14]];
    [self.registerView addSubview:_testLbl];
    
    _testText=[[UITextField alloc]init];
    _testText.placeholder=@"获取验证码";
    _testText.textColor = DWColor(85, 85, 85);

    [_testText setFont:[UIFont systemFontOfSize:14]];
    [self.registerView addSubview:_testText];
    
    _codeBtn = [ZHVerifyCodeButton buttonWithType:UIButtonTypeCustom];
    [_codeBtn addTarget:self action:@selector(codeBtnVerification) forControlEvents:UIControlEventTouchUpInside];
    [self.registerView addSubview:_codeBtn];
    
    _lineView2=[[UIView alloc]init];
    _lineView2.backgroundColor=[UIColor lightGrayColor];
    [self.registerView addSubview:_lineView2];
    
    
    _nameLbl=[[UILabel alloc]init];
    _nameLbl.text=@"姓名";
    _nameLbl.textColor = DWColor(85, 85, 85);

    [_nameLbl setFont:[UIFont systemFontOfSize:14]];
    [self.registerView addSubview:_nameLbl];
    
    _nameText=[[UITextField alloc]init];
    _nameText.placeholder=@"请输您的真实姓名";
    _nameText.textColor = DWColor(85, 85, 85);

    [_nameText setFont:[UIFont systemFontOfSize:14]];
    [self.registerView addSubview:_nameText];
    
    _lineView1=[[UIView alloc]init];
    _lineView1.backgroundColor=[UIColor lightGrayColor];
    [self.registerView addSubview:_lineView1];

    
    
    _identLbl=[[UILabel alloc]init];
    _identLbl.text=@"身份证";
    _identLbl.textColor = DWColor(85, 85, 85);

    [_identLbl setFont:[UIFont systemFontOfSize:14]];
    [self.registerView addSubview:_identLbl];
    
    _identText=[[UITextField alloc]init];
    _identText.placeholder=@"请输入身份证号";
    _identText.textColor = DWColor(85, 85, 85);

    [_identText setFont:[UIFont systemFontOfSize:14]];
    [self.registerView addSubview:_identText];
    
    _lineView3=[[UIView alloc]init];
    _lineView3.backgroundColor=[UIColor lightGrayColor];
    [self.registerView addSubview:_lineView3];
    
    _sexLbl=[[UILabel alloc]init];
    _sexLbl.text=@"性别";
    _sexLbl.textColor = DWColor(85, 85, 85);

    [_sexLbl setFont:[UIFont systemFontOfSize:14]];
    [self.registerView addSubview:_sexLbl];
    
    NSArray *array=@[@"男",@"女"];
    _segmentControl=[[UISegmentedControl alloc]initWithItems:array];
    //    segmentControl.segmentedControlStyle=UISegmentedControlStyleBordered;
    //设置位置 大小
    //    segmentControl.frame=CGRectMake(60, 100, 80, 40);
    //默认选择
    _segmentControl.selectedSegmentIndex=0;
    //设置背景色
    _segmentControl.tintColor=[UIColor colorWithRed:108/255.0 green:205/255.0 blue:123/255.0 alpha:1];
    //设置监听事件
    [_segmentControl addTarget:self action:@selector(change:) forControlEvents:UIControlEventValueChanged];
    [self.registerView addSubview:_segmentControl];
    
//    _switchLbl=[[UILabel alloc]init];
//    _switchLbl.text=@"男";
//    [_switchLbl setFont:[UIFont systemFontOfSize:14]];
//    [self.registerView addSubview:_switchLbl];

    
    
    
    
    _lineView4=[[UIView alloc]init];
    _lineView4.backgroundColor=[UIColor lightGrayColor];
    [self.registerView addSubview:_lineView4];
    
    _passwordLbl=[[UILabel alloc]init];
    _passwordLbl.text=@"密码";
    _passwordLbl.textColor = DWColor(85, 85, 85);

    [_passwordLbl setFont:[UIFont systemFontOfSize:14]];
    [self.registerView addSubview:_passwordLbl];
    
    _passwordText=[[UITextField alloc]init];
    _passwordText.placeholder=@"至少6位，必须包含数字和字母";
    _passwordText.textColor = DWColor(85, 85, 85);

    [_passwordText setFont:[UIFont systemFontOfSize:14]];
    [self.registerView addSubview:_passwordText];
    
    _lineView5=[[UIView alloc]init];
    _lineView5.backgroundColor=[UIColor lightGrayColor];
    [self.registerView addSubview:_lineView5];
    
    _repasswordLbl=[[UILabel alloc]init];
    _repasswordLbl.text=@"确认密码";
    
    _repasswordLbl.textColor = DWColor(85, 85, 85);

    [_repasswordLbl setFont:[UIFont systemFontOfSize:14]];
    [self.registerView addSubview:_repasswordLbl];
    
    _repassText=[[UITextField alloc]init];
    _repassText.placeholder=@"再次确认密码";
    _repassText.textColor = DWColor(85, 85, 85);

    [_repassText setFont:[UIFont systemFontOfSize:14]];
    [self.registerView addSubview:_repassText];
    
    _lineView6=[[UIView alloc]init];
    _lineView6.backgroundColor=[UIColor lightGrayColor];
    [self.registerView addSubview:_lineView6];
    
    _registerbtn=[[UIButton alloc]init];
    [_registerbtn setTitle:@"立即注册" forState:UIControlStateNormal];
    _registerbtn.backgroundColor=DWColor(40, 128, 194);
    self.registerbtn.clipsToBounds=YES;
    [_registerbtn addTarget:self action:@selector(registerAction) forControlEvents:UIControlEventTouchUpInside];

    [self.registerbtn.layer setCornerRadius:5];
    [self.registerView addSubview:_registerbtn];
    
    _backBtn=[[UIButton alloc]init];
    [_backBtn addTarget:self action:@selector(backToLogin) forControlEvents:UIControlEventTouchUpInside];
    [_backBtn setTitle:@"已注册返回登陆" forState:UIControlStateNormal];
    [_backBtn setTitleColor:DWColor(40, 128, 194) forState:UIControlStateNormal];
    [_backBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [self.registerView addSubview:_backBtn];
    
}

-(void)setupFrame{

    [self.titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(15);
        make.left.mas_equalTo(self.view.mas_left).with.offset(15);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(15);
    }];
    
    [self.registerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(45);
        make.left.mas_equalTo(self.view.mas_left);
        make.width.mas_equalTo(kWidth);
        make.bottom.mas_equalTo(self.view.mas_bottom);
    }];
    
    [self.phoneLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.registerView.mas_top).with.offset(15);
        make.left.mas_equalTo(self.registerView.mas_left).with.offset(30);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(15);
    }];
    
    [self.phoneText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.registerView.mas_top).with.offset(15);
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
    
    [self.testLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lineView.mas_bottom).with.offset(15);
        make.left.mas_equalTo(self.registerView.mas_left).with.offset(30);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(15);
    }];
    
    [self.codeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lineView.mas_bottom).with.offset(5);
        make.right.mas_equalTo(self.registerView.mas_right).with.offset(-30);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(30);
    }];
    
    [self.testText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lineView.mas_bottom).with.offset(15);
        make.left.mas_equalTo(self.testLbl.mas_right).with.offset(5);
        make.right.mas_equalTo(self.codeBtn.mas_left).with.offset(-5);
        make.height.mas_equalTo(15);
    }];
    

    [self.lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.testLbl.mas_bottom).with.offset(15);
        make.left.mas_equalTo(self.registerView.mas_left).with.offset(30);
        make.right.mas_equalTo(self.registerView.mas_right).with.offset(-30);
        make.height.mas_equalTo(1);
    }];
    
    
    [self.nameLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lineView2.mas_bottom).with.offset(15);
        make.left.mas_equalTo(self.registerView.mas_left).with.offset(30);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(15);
    }];
    
    [self.nameText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lineView2.mas_bottom).with.offset(15);
        make.left.mas_equalTo(self.identLbl.mas_right).with.offset(5);
        make.right.mas_equalTo(self.registerView.mas_right).with.offset(-30);
        make.height.mas_equalTo(15);
    }];

    [self.lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameText.mas_bottom).with.offset(15);
        make.left.mas_equalTo(self.registerView.mas_left).with.offset(30);
        make.right.mas_equalTo(self.registerView.mas_right).with.offset(-30);
        make.height.mas_equalTo(1);
    }];

    
    [self.identLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lineView1.mas_bottom).with.offset(15);
        make.left.mas_equalTo(self.registerView.mas_left).with.offset(30);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(15);
    }];
    
    [self.identText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lineView1.mas_bottom).with.offset(15);
        make.left.mas_equalTo(self.identLbl.mas_right).with.offset(5);
        make.right.mas_equalTo(self.registerView.mas_right).with.offset(-30);
        make.height.mas_equalTo(15);
    }];
    
    [self.lineView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.identLbl.mas_bottom).with.offset(15);
        make.left.mas_equalTo(self.registerView.mas_left).with.offset(30);
        make.right.mas_equalTo(self.registerView.mas_right).with.offset(-30);
        make.height.mas_equalTo(1);
    }];

    [self.sexLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lineView3.mas_bottom).with.offset(15);
        make.left.mas_equalTo(self.registerView.mas_left).with.offset(30);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(15);
    }];
    
   
    [self.segmentControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lineView3.mas_bottom).with.offset(8);
        make.left.mas_equalTo(self.sexLbl.mas_right).with.offset(5);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(30);
    }];
    
    [self.switchLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lineView3.mas_bottom).with.offset(15);
        make.left.mas_equalTo(self.segmentControl.mas_right).with.offset(10);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(15);
    }];

    [self.lineView4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.sexLbl.mas_bottom).with.offset(15);
        make.left.mas_equalTo(self.registerView.mas_left).with.offset(30);
        make.right.mas_equalTo(self.registerView.mas_right).with.offset(-30);
        make.height.mas_equalTo(1);
    }];
    
    
    [self.passwordLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lineView4.mas_bottom).with.offset(15);
        make.left.mas_equalTo(self.registerView.mas_left).with.offset(30);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(15);
    }];
    
    [self.passwordText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lineView4.mas_bottom).with.offset(15);
        make.left.mas_equalTo(self.passwordLbl.mas_right).with.offset(5);
        make.right.mas_equalTo(self.registerView.mas_right).with.offset(-30);
        make.height.mas_equalTo(15);
    }];
    
    [self.lineView5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.passwordLbl.mas_bottom).with.offset(15);
        make.left.mas_equalTo(self.registerView.mas_left).with.offset(30);
        make.right.mas_equalTo(self.registerView.mas_right).with.offset(-30);
        make.height.mas_equalTo(1);
    }];

    [self.repasswordLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lineView5.mas_bottom).with.offset(15);
        make.left.mas_equalTo(self.registerView.mas_left).with.offset(30);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(15);
    }];
    
    [self.repassText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lineView5.mas_bottom).with.offset(15);
        make.left.mas_equalTo(self.repasswordLbl.mas_right).with.offset(5);
        make.right.mas_equalTo(self.registerView.mas_right).with.offset(-30);
        make.height.mas_equalTo(15);
    }];
    
    [self.lineView6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.repasswordLbl.mas_bottom).with.offset(15);
        make.left.mas_equalTo(self.registerView.mas_left).with.offset(30);
        make.right.mas_equalTo(self.registerView.mas_right).with.offset(-30);
        make.height.mas_equalTo(1);
    }];
    
    [self.registerbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lineView6.mas_bottom).with.offset(15);
        make.left.mas_equalTo(self.registerView.mas_left).with.offset(30);
        make.right.mas_equalTo(self.registerView.mas_right).with.offset(-30);
        make.height.mas_equalTo(40);
    }];
    
    [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.registerbtn.mas_bottom).with.offset(5);
        make.width.mas_equalTo(100);
        make.right.mas_equalTo(self.registerView.mas_right).with.offset(-30);
        make.height.mas_equalTo(30);
    }];
    
    
}
-(void)change:(UISegmentedControl *)Seg
{
    NSInteger index=Seg.selectedSegmentIndex;
    if (index == 0) {
        sexStr = @"男";
    }else{
        sexStr = @"女";
    }
    NSLog(@"%ld",index);
    
}
- (void)codeBtnVerification {
   
    BOOL isMobile = [MethodUtil isMobileNumber:_phoneText.text];
    if(!isMobile){
        [YJProgressHUD showSuccess:@"请输入正确的手机号" inview:self.view];
        return;
    }
    //type 1为注册 2为找回密码
    NSDictionary *dic = @{@"mobile":_phoneText.text,@"type":@"1"};
    NSString *url = [NSString stringWithFormat:@"%@%@",BaseUrl,@"app/doct/getCode"];
    [NetWorkingManager requestGETDataWithPath:url withParamters:dic withProgress:^(float progress) {
        
    } success:^(BOOL isSuccess, id responseObject) {
        NSLog(@"%@",responseObject);
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSString *checkCodeStr = responseObject[@"data"];
            checkCode = checkCodeStr.intValue;

        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error.userInfo);

    }];
    
    // 调用短信验证码接口
    if(true){
        
        [self.codeBtn timeFailBeginFrom:60];  // 倒计时60s
    
    }else{
    
        [self.codeBtn timeFailBeginFrom:1]; // 处理请求成功但是匹配不成功的情况，并不需要执行倒计时功能
    }
}

-(void)backToLogin{

    [NetWorkingManager cancelAllNetworkRequest];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)registerAction
{
    [self.view endEditing:NO];
    BOOL isMobile = [MethodUtil isMobileNumber:_phoneText.text];
    if(!isMobile){
        [YJProgressHUD showSuccess:@"请输入正确的手机号" inview:self.view];

        return;
    }
    if (![MethodUtil isCorrect:_identText.text]) {
        [YJProgressHUD showSuccess:@"输入的身份证号不合法" inview:self.view];

        return;
    }
    if (![_passwordText.text isEqualToString:_repassText.text]) {
        [YJProgressHUD showSuccess:@"两次密码输入不一致" inview:self.view];

        return;
    }
    if (_passwordText.text.length<1 || _repassText.text.length<1) {
        [YJProgressHUD showSuccess:@"密码不能为空" inview:self.view];

        return;
    }
    if (_testText.text.length<1 || checkCode != _testText.text.intValue) {
        [YJProgressHUD showSuccess:@"验证码不能为空或验证码不正确" inview:self.view];

        return;
    }
    if (_nameText.text.length<1) {
        [YJProgressHUD showSuccess:@"姓名不能为空" inview:self.view];

        return;
    }
    //性别
    NSString *sexCode;
    if ([sexStr isEqualToString:@"男"]) {
        sexCode = @"1";
    }else{
        sexCode = @"2";
    }
    
    [YJProgressHUD showProgress:@"注册中..." inView:self.view];

    NSDictionary *dic = @{@"mobile":_phoneText.text,@"cheakCode":_testText.text,@"cardNumber":_identText.text,@"sex":sexCode,@"password":_passwordText.text,@"name":_nameText.text,@"doctorFrom":@"2"};
    
    [NetWorkingManager requestGETDataWithPath:[NSString stringWithFormat:@"%@%@",BaseUrl,@"app/doct/addDoctor"] withParamters:dic withProgress:^(float progress) {
       
        
    } success:^(BOOL isSuccess, id responseObject) {
        [YJProgressHUD hide];
        NSLog(@"%@",responseObject);
        NSString *code = responseObject[@"code"];
        if (code.intValue == 200) {
            [YJProgressHUD showSuccess:@"注册成功" inview:self.view];

        }else{
            [YJProgressHUD showSuccess:@"注册失败" inview:self.view];
        }
        
    } failure:^(NSError *error) {
        [YJProgressHUD hide];
         [YJProgressHUD showSuccess:@"连接网络失败，请检查您的网络" inview:self.view];

    }];

}
-(void)registerClickleft{

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
