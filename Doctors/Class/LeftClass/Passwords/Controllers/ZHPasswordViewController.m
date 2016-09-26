//
//  ZHPasswordViewController.m
//  YCSideslip
//
//  Created by 崔敬轩 on 16/8/20.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ZHPasswordViewController.h"
#import "Masonry.h"


@interface ZHPasswordViewController ()
@property(nonatomic,strong)UIView*firstView;

@property(nonatomic,strong)UITextField*yuanshiText;
@property(nonatomic,strong)UITextField*xinsheText;
@property(nonatomic,strong)UITextField*moreText;

@end

@implementation ZHPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:19],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    self.view.backgroundColor = DWColor(243, 243, 243);
    self.title = @"修改密码";
    UIImage* image1 = [UIImage imageNamed:@"navigationbar_back_withtext"];
    // 告诉系统以后这张图片不进行默认的渲染
    image1 = [image1 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    // 创建活动的按钮
    UIBarButtonItem* item1 = [[UIBarButtonItem alloc]initWithImage:image1 style:UIBarButtonItemStylePlain target:self action:@selector(passwordClickleft)];
    self.navigationItem.leftBarButtonItem = item1;

    
    [self setupUI];
    
    [self setupFrame];
}

-(void)passwordClickleft{
    
    [self.moreText resignFirstResponder];
    [self.yuanshiText resignFirstResponder];
    [self.xinsheText resignFirstResponder];
    [self.navigationController popViewControllerAnimated:YES];
    
}



-(void)setupUI{
    
    //姓名
   //_firstView=[[UIView alloc]initWithFrame:CGRectMake(0, 94,kWidth, 250)];
    _firstView=[[UIView alloc]init];
    _firstView.backgroundColor=[UIColor whiteColor];
    //_firstView.backgroundColor =[UIColor yellowColor];
    

    UILabel*yuanshiLbl=[[UILabel alloc]initWithFrame:CGRectMake(20, 0, 80, 50)];
    yuanshiLbl.text =@"原始密码:";
    _yuanshiText=[[UITextField alloc]initWithFrame:CGRectMake(100,0 , kWidth-80-20, 50)];
    _yuanshiText.placeholder =@"请输入原密码";
    [self.firstView addSubview:yuanshiLbl];
    [self.firstView addSubview:_yuanshiText];
    
    //昵称
    UILabel*xinsheLbl=[[UILabel alloc]initWithFrame:CGRectMake(20, 50, 80, 50)];
    xinsheLbl.text =@"新设密码:";
    _xinsheText=[[UITextField alloc]initWithFrame:CGRectMake(100,50 , kWidth-80-20, 50)];
    _xinsheText.placeholder =@"请输入原密码";
    [self.firstView addSubview:_xinsheText];
    [self.firstView addSubview:xinsheLbl];
    
    //性别
    UILabel*moreLbl=[[UILabel alloc]initWithFrame:CGRectMake(20, 100, 80, 50)];
    moreLbl.text =@"重复密码:";
    _moreText=[[UITextField alloc]initWithFrame:CGRectMake(100,100 , kWidth-80-20, 50)];
    _moreText.placeholder =@"请输入原密码";
    [self.firstView addSubview:moreLbl];
    [self.firstView addSubview:_moreText];
    
    [self.view addSubview:_firstView];
    
    UIButton*quereBtn=[[UIButton alloc]initWithFrame:CGRectMake(20, 180, kWidth-40, 30)];
    
    quereBtn.backgroundColor=[UIColor colorWithRed:100/255.0 green:178/255.0 blue:241/255.0 alpha:1] ;
    
    [quereBtn setTitle:@"确认修改" forState:UIControlStateNormal];
    
    [quereBtn.layer setCornerRadius:5];
    [quereBtn.layer setMasksToBounds:YES];
    
    [self.view addSubview:quereBtn];
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.moreText resignFirstResponder];
    [self.yuanshiText resignFirstResponder];
    [self.xinsheText resignFirstResponder];

    
}

-(void)setupFrame{

    [self.firstView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(10);
        make.left.mas_equalTo(self.view.mas_left).with.offset(5);
        make.right.mas_equalTo(self.view.mas_right).with.offset(-5);
        make.height.mas_equalTo(150);
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
