//
//  ZHLoginViewController.m
//  Doctors
//
//  Created by 崔敬轩 on 16/8/23.
//  Copyright © 2016年 崔敬轩. All rights reserved.
//

#import "ZHLoginViewController.h"
#import "ZHTabViewController.h"
#import "YCLeftViewController.h"
#import "Masonry.h"
#import "ZHNavViewController.h"
#import "UIView+Frame.h"
#import "MMDrawerController.h"
#import "ZHNavViewController.h"
#import "ZHRegisterViewController.h"
#import "ZHForgetViewController.h"
#import "NetWorkingManager.h"
#define NIMMyAccount   @"lilei"
#define NIMMyToken     @"123456"
#define NIMChatTarget  @"hanmeimei"
@interface ZHLoginViewController ()

@property(nonatomic,strong)UIView*loginView;
@property(nonatomic,strong)UIImageView*loginImg;

@property(nonatomic,strong)UIView*firstView;
@property(nonatomic,strong)UILabel*accountlbl;
@property(nonatomic,strong)UILabel*passWordlbl;
@property(nonatomic,strong)UITextField*accountText;
@property(nonatomic,strong)UITextField*passWordText;

@property(nonatomic,strong)UIView*loginBtnView;
@property(nonatomic,strong)UIButton*loginBtn;
@property(nonatomic,strong)UIButton*registerBtn;
@property(nonatomic,strong)UIButton*forgetBtn;

@end

@implementation ZHLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    
//    UIImage* image1 = [UIImage imageNamed:@"navigationbar_back_withtext"];
//    image1 = [image1 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    
//    UIBarButtonItem* item2 = [[UIBarButtonItem alloc]initWithImage:image1 style:UIBarButtonItemStylePlain target:self action:@selector(loginClickleft)];
    //        self.navigationItem.leftBarButtonItem = item2;

    self.navigationItem.title=@"中国健康云";

    [self setupUI];
    [self setupFrame];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setupUI{
    
    _loginView = [[UIView alloc]init];

    _loginImg=[[UIImageView alloc]init];
    _loginImg.image=[UIImage imageNamed:@"logo"];
    [_loginImg.layer setMasksToBounds:YES];
    [_loginImg.layer setCornerRadius:40];
    [self.loginView addSubview:_loginImg];
    
    _firstView=[[UIView alloc]init];
    _firstView.backgroundColor=[UIColor colorWithRed:203/255.0 green:227/255.0 blue:243/255.0 alpha:1];
    
    _accountlbl=[[UILabel alloc]init];
    _accountlbl.text=@"账号";
    _accountlbl.textColor = DWColor(85, 85, 85);

    [self.firstView addSubview:_accountlbl];
    
    _passWordlbl=[[UILabel alloc]init];
    _passWordlbl.text=@"密码";
    _passWordlbl.textColor = DWColor(85, 85, 85);

    [self.firstView addSubview:_passWordlbl];
       
    _accountText=[[UITextField alloc]init];
    _accountText.placeholder=@"手机号";
    _accountText.textColor = DWColor(85, 85, 85);

    [self.firstView addSubview:_accountText];
    
    _passWordText=[[UITextField alloc]init];
    _passWordText.placeholder=@"密码";
    _passWordText.textColor = DWColor(85, 85, 85);

    _passWordText.secureTextEntry=YES;
    [self.firstView addSubview:_passWordText];
    
    [self.loginView addSubview:_firstView];
    
    _loginBtnView=[[UIView alloc]init];
    
    _loginBtn=[[UIButton alloc]init];
    [_loginBtn.layer setMasksToBounds:YES];
    [_loginBtn.layer setCornerRadius:5];
    
    _registerBtn=[[UIButton alloc]init];
    [_registerBtn.layer setMasksToBounds:YES];
    [_registerBtn.layer setCornerRadius:5];
    _registerBtn.backgroundColor=[UIColor colorWithRed:56/255.0 green:180/255.0 blue:215/255.0 alpha:1];
    
    _forgetBtn=[[UIButton alloc]init];
    [_forgetBtn.layer setMasksToBounds:YES];
    [_forgetBtn.layer setCornerRadius:5];
    _forgetBtn.backgroundColor=[UIColor colorWithRed:56/255.0 green:180/255.0 blue:215/255.0 alpha:1];

    
    _loginBtn.backgroundColor=[UIColor colorWithRed:56/255.0 green:180/255.0 blue:215/255.0 alpha:1];
    [_loginBtn setTitle:@"立即登录" forState:UIControlStateNormal];
    [_loginBtn setBackgroundColor:DWColor(40, 128, 194)];
    [self.loginBtn addTarget:self action:@selector(loginsbtn) forControlEvents:UIControlEventTouchUpInside];
    [self.loginBtnView addSubview:_loginBtn];
    
    _registerBtn = [[UIButton alloc]init];
    [_registerBtn setTitle:@"注册新用户" forState:UIControlStateNormal];
    [self.registerBtn addTarget:self action:@selector(registerbtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_registerBtn setTitleColor:DWColor(40, 128, 194) forState:UIControlStateNormal];
    [_registerBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [self.loginBtnView addSubview:_registerBtn];
    
    _forgetBtn = [[UIButton alloc]init];
    [_forgetBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
    [self.forgetBtn addTarget:self action:@selector(forgetbtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_forgetBtn setTitleColor:DWColor(40, 128, 194) forState:UIControlStateNormal];
    [_forgetBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [self.loginBtnView addSubview:_forgetBtn];
    
    [self.view addSubview:_loginView];
    [self.view addSubview:_loginBtnView];

    self.view.backgroundColor =[UIColor colorWithRed:203/255.0 green:227/255.0 blue:243/255.0 alpha:1];
 }


-(void)registerbtnClick{

    ZHRegisterViewController*regisVc=[[ZHRegisterViewController alloc]init];
    
    [self.navigationController pushViewController:regisVc animated:YES];

}

-(void)forgetbtnClick{

    ZHForgetViewController*forgetVc=[[ZHForgetViewController alloc]init];
    [self.navigationController pushViewController:forgetVc animated:YES];
}

-(void)setupFrame{

    
    if (isiPhone6P) {
        
        //登录
        [self.loginView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view.mas_top);
            make.left.mas_equalTo(self.view.mas_left);
            make.width.mas_equalTo(kWidth);
            make.height.mas_equalTo(200);

        }];
        
        [self.loginImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.loginView.mas_top).with.offset(40);
            make.left.mas_equalTo((kWidth-100)/2);
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(100);
        }];
        
        [self.firstView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.loginView.mas_bottom);
            make.left.mas_equalTo(self.view.mas_left);
            make.width.mas_equalTo(kWidth);
            make.height.mas_equalTo(85);
        }];
        
        
        [self.accountlbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.firstView.mas_top);
            make.left.mas_equalTo(40);
            make.width.mas_equalTo(60);
            make.height.mas_equalTo(40);
        }];
        
        [self.accountText mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.firstView.mas_top);
            make.left.mas_equalTo(self.accountlbl.mas_right).with.offset(5);
            make.right.mas_equalTo(self.firstView.mas_right).with.offset(-30);
            make.height.mas_equalTo(40);
            
        }];

        [self.passWordlbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.accountlbl.mas_bottom).with.offset(5);
            make.left.mas_equalTo(40);
            make.width.mas_equalTo(60);
            make.height.mas_equalTo(40);
        }];
        
        [self.passWordText mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.accountlbl.mas_bottom).with.offset(5);
            make.left.mas_equalTo(self.passWordlbl.mas_right).with.offset(5);
            make.right.mas_equalTo(self.firstView.mas_right).with.offset(-30);
            make.height.mas_equalTo(40);
        }];
        
        [self.loginBtnView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.firstView.mas_bottom);
            make.left.mas_equalTo(self.view.mas_left);
            make.width.mas_equalTo(kWidth);
            make.height.mas_equalTo(180);
        }];
        
        [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.loginBtnView.mas_top).with.offset(20);
            make.left.mas_equalTo(self.loginBtnView.mas_left).with.offset(20);
            make.right.mas_equalTo(self.loginBtnView.mas_right).with.offset(-20);
            make.height.mas_equalTo(40);
        }];
        
        [self.registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.loginBtn.mas_bottom).with.offset(5);
            make.left.mas_equalTo(self.loginBtn.mas_left);
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(40);
        }];
        
        [self.forgetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.loginBtn.mas_bottom).with.offset(5);
            make.right.mas_equalTo(self.loginBtn.mas_right);
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(40);
        }];

    }else{
    //登录
    [self.loginView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.left.mas_equalTo(self.view.mas_left);
        make.width.mas_equalTo(kWidth);
        make.height.mas_equalTo(200);
    }];
    
    [self.loginImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.loginView.mas_top).with.offset(20);
        make.left.mas_equalTo((kWidth-80)/2);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(80);
    }];
    
    [self.firstView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.loginImg.mas_bottom).with.offset(20);
        make.left.mas_equalTo(self.view.mas_left);
        make.width.mas_equalTo(kWidth);
        make.height.mas_equalTo(65);
    }];


    [self.accountlbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.firstView.mas_top);
        make.left.mas_equalTo(30);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(30);
    }];
        
        [self.accountText mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.firstView.mas_top);
            make.left.mas_equalTo(self.accountlbl.mas_right).with.offset(5);
            make.right.mas_equalTo(self.firstView.mas_right).with.offset(-30);
            make.height.mas_equalTo(30);
        }];

        
    [self.passWordlbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.accountlbl.mas_bottom).with.offset(5);
        make.left.mas_equalTo(30);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(30);
    }];
        
        [self.passWordText mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.accountlbl.mas_bottom).with.offset(5);
            make.left.mas_equalTo(self.passWordlbl.mas_right).with.offset(5);
            make.right.mas_equalTo(self.firstView.mas_right).with.offset(-30);
            make.height.mas_equalTo(30);
        }];

    [self.loginBtnView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.loginView.mas_bottom);
        make.left.mas_equalTo(self.view.mas_left);
        make.width.mas_equalTo(kWidth);
        make.height.mas_equalTo(180);
        //self.loginBtnView.backgroundColor=[UIColor blueColor];
    }];
    
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.loginBtnView.mas_top).with.offset(20);
        make.left.mas_equalTo(self.loginBtnView.mas_left).with.offset(20);
        make.right.mas_equalTo(self.loginBtnView.mas_right).with.offset(-20);
        make.height.mas_equalTo(40);
    }];
    
    [self.registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.loginBtn.mas_bottom).with.offset(5);
        make.left.mas_equalTo(self.loginBtn.mas_left);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(30);
    }];
    
    [self.forgetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.loginBtn.mas_bottom).with.offset(5);
        make.right.mas_equalTo(self.loginBtn.mas_right);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(30);
    }];
    }
}

-(void)loginsbtn{
    [self.view endEditing:NO];
    if(_accountText.text.length<1 || _passWordText.text.length<1){
        [YJProgressHUD showSuccess:@"帐号或密码不能为空" inview:self.view];

        return;
    }
    [YJProgressHUD showProgress:@"正在登录..." inView:self.view];

    NSDictionary *dic = @{@"mobile":_accountText.text,@"password":_passWordText.text};
    
    
    
    [NetWorkingManager requestGETDataWithPath:[NSString stringWithFormat:@"%@%@",BaseUrl,@"app/doct/login"] withParamters:dic withProgress:nil success:^(BOOL isSuccess, id responseObject) {
        [YJProgressHUD hide];
        //200登陆成功，201登陆成功未认证
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSString *loginCode = responseObject[@"code"];
            if (loginCode.intValue == 200) {
                NSString *token = responseObject[@"data"][@"token"];
                NSString *doctorId = responseObject[@"data"][@"id"];
                NSString *tatus = responseObject[@"data"][@"status"];
                [UConfig setLoginToken:token];
                [UConfig setDoctorId:doctorId];
                [UConfig setVerifyStatus:tatus.integerValue];
                [UConfig setLoginNumber:_accountText.text];
                if (tatus.integerValue == 1) {
                    [[NIMSDK sharedSDK].loginManager login:[NSString stringWithFormat:@"_%@",_accountText.text] token:token completion:^(NSError *error) {
                        if (!error) {
                            NSLog(@"登录成功");
                            [self loginMainView];
                            
                        }else{
                            NSLog(@"登录失败");
                          [YJProgressHUD showSuccess:@"登录失败" inview:self.view];
                        }
                    }];

                }else{
                    [self loginMainView];
                }
                
            }else{
                [YJProgressHUD showSuccess:@"帐号或密码不正确" inview:self.view];
            }
            NSLog(@"%@",responseObject);

        }
        
    } failure:^(NSError *error) {
        [YJProgressHUD hide];
        [YJProgressHUD showSuccess:@"登录失败,请检查网络" inview:self.view];
    }];
    
    
    

    
        
}

-(void)loginMainView
{
    UIViewController*leftVc;
    
    YCLeftViewController *leftMenuViewController = [[YCLeftViewController alloc] init];
    
    leftVc=[[ZHNavViewController alloc]initWithRootViewController:leftMenuViewController];
    
    ZHTabViewController *centerVc = [[ZHTabViewController alloc] init];
    
    MMDrawerController *drawerVc = [[MMDrawerController alloc] initWithCenterViewController:centerVc leftDrawerViewController:leftVc];
    drawerVc.maximumLeftDrawerWidth = kLeftSize;
    drawerVc.showsShadow = YES;
    drawerVc.openDrawerGestureModeMask = MMOpenDrawerGestureModeNone;
    drawerVc.closeDrawerGestureModeMask = MMCloseDrawerGestureModeAll;
    
    [self.navigationController pushViewController:drawerVc animated:YES];
    
    self.navigationController.navigationBar.hidden=YES;
    
    
    NSDictionary *dict = @{@"id":[UConfig getDoctorId]};
    [NetWorkingManager requestGETDataWithPath:[NSString stringWithFormat:@"%@app/doct/index",BaseUrl] withParamters:dict withProgress:^(float progress) {
        
    } success:^(BOOL isSuccess, id responseObject) {
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSArray *array = responseObject[@"data"];
            if ([array isKindOfClass:[NSArray class]]) {
                NSDictionary *dic = array.firstObject;
                if ([dic isKindOfClass:[NSDictionary class]]) {
                    NSString *idStr = dic[@"id"];
                    NSString *photoUrl = dic[@"photo"];
                    if (idStr.intValue>0) {
                        [UConfig setDoctorId:idStr];
                        [UConfig setPersonInfo:dic];
                        [UConfig setPhotoUrl:photoUrl];
                        //创建通知
                        NSNotification *notification =[NSNotification notificationWithName:@"updatePhoto" object:nil userInfo:nil];
                        //通过通知中心发送通知
                        [[NSNotificationCenter defaultCenter] postNotification:notification];
                    }
                }
            }

        }
        NSLog(@"%@",responseObject);
    } failure:^(NSError *error) {
        
    }];
    
    
}

-(void)loginClickleft{

    

}
@end
