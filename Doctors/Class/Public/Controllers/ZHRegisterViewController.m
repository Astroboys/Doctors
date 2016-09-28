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
@interface ZHRegisterViewController ()

@property(nonatomic,strong)UIView*registerView;
@property(nonatomic,strong)UILabel*titleLbl;
@property(nonatomic,strong)UILabel*phoneLbl;
@property(nonatomic,strong)UITextField*phoneText;
@property(nonatomic,strong)UIView*lineView;

@property(nonatomic,strong)UILabel*testLbl;
@property(nonatomic,strong)UITextField*testText;
@property(nonatomic,strong)UIView*lineView2;

@property(nonatomic,strong)UILabel*identLbl;
@property(nonatomic,strong)UITextField*identText;
@property(nonatomic,strong)UIView*lineView3;

@property(nonatomic,strong)UILabel*sexLbl;
@property(nonatomic,strong)UISwitch*sexText;
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
    self.view.backgroundColor=[UIColor lightGrayColor];
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

    _testLbl=[[UILabel alloc]init];
    _testLbl.text=@"验证码";
    [_testLbl setFont:[UIFont systemFontOfSize:14]];
    [self.registerView addSubview:_testLbl];
    
    _testText=[[UITextField alloc]init];
    _testText.placeholder=@"获取验证码";
    [_testText setFont:[UIFont systemFontOfSize:14]];
    [self.registerView addSubview:_testText];
    
    _codeBtn = [ZHVerifyCodeButton buttonWithType:UIButtonTypeCustom];
    [_codeBtn addTarget:self action:@selector(codeBtnVerification) forControlEvents:UIControlEventTouchUpInside];
    [self.registerView addSubview:_codeBtn];
    
    _lineView2=[[UIView alloc]init];
    _lineView2.backgroundColor=[UIColor lightGrayColor];
    [self.registerView addSubview:_lineView2];
    
    _identLbl=[[UILabel alloc]init];
    _identLbl.text=@"身份证";
    [_identLbl setFont:[UIFont systemFontOfSize:14]];
    [self.registerView addSubview:_identLbl];
    
    _identText=[[UITextField alloc]init];
    _identText.placeholder=@"请输入身份证号";
    [_identText setFont:[UIFont systemFontOfSize:14]];
    [self.registerView addSubview:_identText];
    
    _lineView3=[[UIView alloc]init];
    _lineView3.backgroundColor=[UIColor lightGrayColor];
    [self.registerView addSubview:_lineView3];
    
    _sexLbl=[[UILabel alloc]init];
    _sexLbl.text=@"性别";
    [_sexLbl setFont:[UIFont systemFontOfSize:14]];
    [self.registerView addSubview:_sexLbl];
    
    _sexText=[[UISwitch alloc]init];
    [self.registerView addSubview:_sexText];
    
    _switchLbl=[[UILabel alloc]init];
    _switchLbl.text=@"男";
    [_switchLbl setFont:[UIFont systemFontOfSize:14]];
    [self.registerView addSubview:_switchLbl];

    
    _lineView4=[[UIView alloc]init];
    _lineView4.backgroundColor=[UIColor lightGrayColor];
    [self.registerView addSubview:_lineView4];
    
    _passwordLbl=[[UILabel alloc]init];
    _passwordLbl.text=@"密码";
    [_passwordLbl setFont:[UIFont systemFontOfSize:14]];
    [self.registerView addSubview:_passwordLbl];
    
    _passwordText=[[UITextField alloc]init];
    _passwordText.placeholder=@"至少6位，必须包含数字和字母";
    [_passwordText setFont:[UIFont systemFontOfSize:14]];
    [self.registerView addSubview:_passwordText];
    
    _lineView5=[[UIView alloc]init];
    _lineView5.backgroundColor=[UIColor lightGrayColor];
    [self.registerView addSubview:_lineView5];
    
    _repasswordLbl=[[UILabel alloc]init];
    _repasswordLbl.text=@"确认密码";
    [_repasswordLbl setFont:[UIFont systemFontOfSize:14]];
    [self.registerView addSubview:_repasswordLbl];
    
    _repassText=[[UITextField alloc]init];
    _repassText.placeholder=@"再次确认密码";
    [_repassText setFont:[UIFont systemFontOfSize:14]];
    [self.registerView addSubview:_repassText];
    
    _lineView6=[[UIView alloc]init];
    _lineView6.backgroundColor=[UIColor lightGrayColor];
    [self.registerView addSubview:_lineView6];
    
    _registerbtn=[[UIButton alloc]init];
    [_registerbtn setTitle:@"立即注册" forState:UIControlStateNormal];
    _registerbtn.backgroundColor=DWColor(40, 128, 194);
    self.registerbtn.clipsToBounds=YES;
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
    
    [self.identLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lineView2.mas_bottom).with.offset(15);
        make.left.mas_equalTo(self.registerView.mas_left).with.offset(30);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(15);
    }];
    
    [self.identText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lineView2.mas_bottom).with.offset(15);
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
    
   
    [self.sexText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lineView3.mas_bottom).with.offset(10);
        make.left.mas_equalTo(self.sexLbl.mas_right).with.offset(5);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(15);
    }];
    
    [self.switchLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lineView3.mas_bottom).with.offset(15);
        make.left.mas_equalTo(self.sexText.mas_right).with.offset(10);
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
        make.height.mas_equalTo(30);
    }];
    
    [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.registerbtn.mas_bottom).with.offset(5);
        make.width.mas_equalTo(100);
        make.right.mas_equalTo(self.registerView.mas_right).with.offset(-30);
        make.height.mas_equalTo(30);
    }];
    

}

- (void)codeBtnVerification {
    
    // 调用短信验证码接口
    if(true){
        
        [self.codeBtn timeFailBeginFrom:60];  // 倒计时60s
    
    }else{
    
        [self.codeBtn timeFailBeginFrom:1]; // 处理请求成功但是匹配不成功的情况，并不需要执行倒计时功能
    }
}

-(void)backToLogin{

    [self.navigationController popViewControllerAnimated:YES];
}


-(void)registerClickleft{

    
//    NTESRegisterData *data = [[NTESRegisterData alloc] init];
//    data.account = [_accountTextfield text];
//    data.nickname= [_nicknameTextfield text];
//    data.token = [[_passwordTextfield text] tokenByPassword];
//    if (![self check]) {
//        return;
//    }
//
//[SVProgressHUD show];
//__weak typeof(self) weakSelf = self;
//
//[[NTESDemoService sharedService] registerUser:data
//                                   completion:^(NSError *error, NSString *errorMsg) {
//                                       [SVProgressHUD dismiss];
//                                       if (error == nil) {
//                                           [weakSelf.navigationController.view makeToast:@"注册成功"
//                                                                                duration:2
//                                                                                position:CSToastPositionCenter];
//                                           if ([weakSelf.delegate respondsToSelector:@selector(registDidComplete:password:)]) {
//                                               [weakSelf.delegate registDidComplete:data.account password:[_passwordTextfield text]];
//                                           }
//                                           [weakSelf.navigationController popViewControllerAnimated:YES];
//                                       }
//                                       else
//                                       {
//                                           if ([weakSelf.delegate respondsToSelector:@selector(registDidComplete:password:)]) {
//                                               [weakSelf.delegate registDidComplete:nil password:nil];
//                                           }
//                                           
//                                           NSString *toast = [NSString stringWithFormat:@"注册失败"];
//                                           if ([errorMsg isKindOfClass:[NSString class]] &&errorMsg.length) {
//                                               toast = [toast stringByAppendingFormat:@": %@",errorMsg];
//                                           }
//                                           [weakSelf.view makeToast:toast
//                                                           duration:2
//                                                           position:CSToastPositionCenter];
//                                           
//                                       }
//                                       
//                                   }];

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
