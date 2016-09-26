//
//  ZHEmailViewController.m
//  YCSideslip
//
//  Created by 崔敬轩 on 16/8/20.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ZHEmailViewController.h"
#import "Masonry.h"

@interface ZHEmailViewController ()

@property(nonatomic,strong)UIView*firstView;


@property(nonatomic,strong)UILabel*renzhengLbl;

@property(nonatomic,strong)UITextField*renzhengText;

@property(nonatomic,strong)UILabel*tuyanLbl;

@property(nonatomic,strong)UITextField*tuyanText;

@property(nonatomic,strong)UILabel*yanzhengLbl;

@property(nonatomic,strong)UITextField*yanzhengText;

@property(nonatomic,strong)UIButton*quereBtn;

@end

@implementation ZHEmailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:19],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    self.view.backgroundColor = DWColor(243, 243, 243);
    
    self.title = @"邮箱认证";
    UIImage* image1 = [UIImage imageNamed:@"navigationbar_back_withtext"];
    // 告诉系统以后这张图片不进行默认的渲染
    image1 = [image1 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    // 创建活动的按钮
    UIBarButtonItem* item1 = [[UIBarButtonItem alloc]initWithImage:image1 style:UIBarButtonItemStylePlain target:self action:@selector(emailClickleft)];
    self.navigationItem.leftBarButtonItem = item1;
    
    [self setupUI];
    [self setupFrame];

}

-(void)emailClickleft{
    
    [self.renzhengText resignFirstResponder];
    [self.yanzhengText resignFirstResponder];
    [self.tuyanText resignFirstResponder];
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)setupUI{
    
    //姓名
    //_firstView=[[UIView alloc]initWithFrame:CGRectMake(0, 94,kWidth, 250)];
    _firstView= [[UIView alloc]init];
    _firstView.backgroundColor =[UIColor whiteColor];
    
    
    //UILabel*renzhengLbl=[[UILabel alloc]initWithFrame:CGRectMake(20, 0, 80, 50)];
    _renzhengLbl=[[UILabel alloc]init];
    _renzhengLbl.text =@"认证邮箱:";
    
    //UITextField*renzhengText=[[UITextField alloc]initWithFrame:CGRectMake(100,0 , kWidth-80-20, 50)];
    _renzhengText=[[UITextField alloc]init];
    _renzhengText.placeholder =@"输入邮箱号";
    [self.firstView addSubview:_renzhengLbl];
    [self.firstView addSubview:_renzhengText];
    
    //昵称
    //UILabel*tuyanLbl=[[UILabel alloc]initWithFrame:CGRectMake(20, 50, 80, 50)];
    _tuyanLbl=[[UILabel alloc]init];
    _tuyanLbl.text =@"图验证码:";
    //UITextField*tuyanText=[[UITextField alloc]initWithFrame:CGRectMake(100,50 , kWidth-80-20, 50)];
    _tuyanText=[[UITextField alloc]init];
    _tuyanText.placeholder =@"图片验证码";
    [self.firstView addSubview:_tuyanText];
    [self.firstView addSubview:_tuyanLbl];
    
    //性别
    //UILabel*yanzhengLbl=[[UILabel alloc]initWithFrame:CGRectMake(20, 100, 80, 50)];
    _yanzhengLbl=[[UILabel alloc]init];
    _yanzhengLbl.text =@"验证码:";
    //UITextField*yanzhengText=[[UITextField alloc]initWithFrame:CGRectMake(100,100 , kWidth-80-20, 50)];
    _yanzhengText=[[UITextField alloc]init];
    _yanzhengText.placeholder =@"邮箱验证码";
    [self.firstView addSubview:_yanzhengLbl];
    [self.firstView addSubview:_yanzhengText];
    
    [self.view addSubview:_firstView];
    
    //UIButton*quereBtn=[[UIButton alloc]initWithFrame:CGRectMake(20, 180, kWidth-40, 40)];
    _quereBtn=[[UIButton alloc]init];
    
    _quereBtn.backgroundColor=[UIColor colorWithRed:100/255.0 green:178/255.0 blue:241/255.0 alpha:1];
    
    [_quereBtn setTitle:@"邮箱认证" forState:UIControlStateNormal];
    
    [_quereBtn.layer setCornerRadius:5];
    [_quereBtn.layer setMasksToBounds:YES];
    [self.view addSubview:_quereBtn];
    
    
    
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.renzhengText resignFirstResponder];
    [self.yanzhengText resignFirstResponder];
    [self.tuyanText resignFirstResponder];
    
}

-(void)setupFrame{
    
    [self.firstView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(10);
        make.left.mas_equalTo(self.view.mas_left).with.offset(5);
        make.right.mas_equalTo(self.view.mas_right).with.offset(-5);
        make.height.mas_equalTo(120);
    }];
    
    [self.renzhengLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.firstView.mas_top);
        make.left.mas_equalTo(20);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(80);
    }];
    
    [self.renzhengText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.firstView.mas_top);
        make.left.mas_equalTo(self.renzhengLbl.mas_right);
        make.height.mas_equalTo(40);
        make.right.equalTo(self.view.mas_right).with.offset(-20);
    }];
    
    [self.tuyanLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.renzhengLbl.mas_bottom);
        make.left.mas_equalTo(self.renzhengLbl.mas_left);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(80);
    }];
    [self.tuyanText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.renzhengText.mas_bottom);
        make.left.mas_equalTo(self.renzhengText.mas_left);
        make.height.mas_equalTo(40);
        make.right.equalTo(self.view.mas_right).with.offset(-20);
    }];
    
    [self.yanzhengLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tuyanLbl.mas_bottom);
        make.left.mas_equalTo(self.renzhengLbl.mas_left);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(80);
    }];
    
    [self.yanzhengText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tuyanText.mas_bottom);
        make.left.mas_equalTo(self.tuyanLbl.mas_right);
        make.height.mas_equalTo(40);
        make.right.equalTo(self.view.mas_right).with.offset(-20);
    }];
    
    [self.quereBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.yanzhengText.mas_bottom).with.offset(50);
        make.left.mas_equalTo(self.firstView.mas_left).with.offset(40);
        make.height.mas_equalTo(30);
        make.right.equalTo(self.firstView.mas_right).with.offset(-40);
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
