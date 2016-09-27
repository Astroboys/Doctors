//
//  ZHPrescribeViewController.m
//  Doctors
//
//  Created by 崔敬轩 on 16/9/27.
//  Copyright © 2016年 XueHuiWang. All rights reserved.
//

#import "ZHPrescribeViewController.h"
#import "Masonry.h"

@interface ZHPrescribeViewController ()

@property(nonatomic,strong)UIView* infoView;
@property(nonatomic,strong)UILabel* customerName;
@property(nonatomic,strong)UILabel* customerSex;
@property(nonatomic,strong)UILabel* customerOffice;
@property(nonatomic,strong)UILabel* seeTime;

@property(nonatomic,strong)UITextField*contentsName;
@property(nonatomic,strong)UILabel*manSex;
@property(nonatomic,strong)UILabel*womenSex;
@property(nonatomic,strong)UIButton*manBtn;
@property(nonatomic,strong)UIButton*womenBtn;

@property(nonatomic,strong)UITextField*contentOffice;
@property(nonatomic,strong)UITextField*contentTime;

@property(nonatomic,strong)UIView*initdiagnoView;
@property(nonatomic,strong)UILabel*initdiaLbl;
@property(nonatomic,strong)UITextView* diaTextView;

@end

@implementation ZHPrescribeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor lightGrayColor];
    self.navigationItem.title=@"在线开处方";
    UIImage* image1 = [UIImage imageNamed:@"navigationbar_back_withtext"];
    image1 = [image1 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIBarButtonItem* item1 = [[UIBarButtonItem alloc]initWithImage:image1 style:UIBarButtonItemStylePlain target:self action:@selector(prescribeClickleft)];
    
    self.navigationItem.leftBarButtonItem=item1;
    
    [self setupUI];
    [self setupFrame];
    
}

-(void)setupUI{
    
    _infoView=[[UIView alloc]init];
    _infoView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:_infoView];
    
    //姓名
    _customerName=[[UILabel alloc]init];
    [_customerName setFont:[UIFont systemFontOfSize:16]];
    _customerName.text=@"姓名";
    [self.infoView addSubview:_customerName];
    
    _contentsName=[[UITextField alloc]init];
    _contentsName.placeholder=@"请输入就诊人姓名";
    [_contentsName setFont:[UIFont systemFontOfSize:16]];
    [self.infoView addSubview:_contentsName];
    //性别
    _customerSex=[[UILabel alloc]init];
    [_customerSex setFont:[UIFont systemFontOfSize:16]];
    _customerSex.text=@"性别";
    [self.infoView addSubview:_customerSex];
    
    //男
    _manSex=[[UILabel alloc]init];
    [_customerSex setFont:[UIFont systemFontOfSize:16]];
    _manSex.text=@"男";
    [self.infoView addSubview:_manSex];
    
    _manBtn=[[UIButton alloc]init];
    [_manBtn setImage:[UIImage imageNamed:@"un_select"] forState:UIControlStateNormal];
    [_manBtn setImage:[UIImage imageNamed:@"select"] forState:UIControlStateSelected];
    [_manBtn addTarget:self action:@selector(manBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.infoView addSubview:_manBtn];
    //女
    _womenSex=[[UILabel alloc]init];
    [_womenSex setFont:[UIFont systemFontOfSize:16]];
    _womenSex.text=@"女";
    [self.infoView addSubview:_womenSex];
    
    _womenBtn=[[UIButton alloc]init];
    [_womenBtn setImage:[UIImage imageNamed:@"un_select"] forState:UIControlStateNormal];
    [_womenBtn setImage:[UIImage imageNamed:@"select"] forState:UIControlStateSelected];
    [_womenBtn addTarget:self action:@selector(womenBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.infoView addSubview:_womenBtn];

    //
    _customerOffice=[[UILabel alloc]init];
    _customerOffice.text=@"科室";
    [_customerOffice setFont:[UIFont systemFontOfSize:16]];
    [self.infoView addSubview:_customerOffice];
    
    _contentOffice=[[UITextField alloc]init];
    [_contentOffice setFont:[UIFont systemFontOfSize:16]];
    _contentOffice.placeholder=@"请输入就诊科室";
    [self.infoView addSubview:_contentOffice];
    
    _seeTime=[[UILabel alloc]init];
    [_seeTime setFont:[UIFont systemFontOfSize:16]];
    _seeTime.text=@"时间";
    [self.infoView addSubview:_seeTime];
    
    _contentTime=[[UITextField alloc]init];
    [_contentTime setFont:[UIFont systemFontOfSize:16]];
    _contentTime.placeholder=@"请输入就诊时间";
    [self.infoView addSubview:_contentTime];
    
    _initdiagnoView=[[UIView alloc]init];
    _initdiagnoView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:_initdiagnoView];
    
    _initdiaLbl=[[UILabel alloc]init];
    [_initdiaLbl setFont:[UIFont systemFontOfSize:16]];
    _initdiaLbl.text=@"初步诊断";
    [self.initdiagnoView addSubview:_initdiaLbl];
    
    _diaTextView=[[UITextView alloc]init];
    [_diaTextView setFont:[UIFont systemFontOfSize:16]];
    [self.initdiagnoView addSubview:_diaTextView];
    
    
}

-(void)manBtnClick{

    self.manBtn.selected=YES;
    self.womenBtn.selected=NO;

}

-(void)womenBtnClick{

    self.womenBtn.selected=YES;
    self.manBtn.selected=NO;
}


-(void)setupFrame{
    
    [self.infoView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.view.mas_top);
        make.left.mas_equalTo(self.view.mas_left);
        make.height.mas_equalTo(140);
        make.width.mas_equalTo(kWidth);
        
    }];
    
    [self.customerName mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.infoView.mas_top);
        make.left.mas_equalTo(self.infoView.mas_left).with.offset(30);
        make.height.mas_equalTo(35);
        make.width.mas_equalTo(40);
        
    }];
    
    [self.contentsName mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.infoView.mas_top);
        make.left.mas_equalTo(self.customerName.mas_right).with.offset(8);
        make.height.mas_equalTo(35);
        make.right.mas_equalTo(self.infoView.mas_right).with.offset(-30);
        
    }];
    [self.customerSex mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.customerName.mas_bottom);
        make.left.mas_equalTo(self.infoView.mas_left).with.offset(30);
        make.height.mas_equalTo(35);
        make.width.mas_equalTo(40);
        
    }];
    
    [self.manSex mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.customerName.mas_bottom);
        make.left.mas_equalTo(self.customerSex.mas_right).with.offset(8);
        make.height.mas_equalTo(35);
        make.width.mas_equalTo(20);
        
    }];
    
    [self.manBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.customerName.mas_bottom).with.offset(5);
        make.left.mas_equalTo(self.manSex.mas_right).with.offset(8);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(30);
        
    }];
    
    [self.womenSex mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.customerName.mas_bottom);
        make.left.mas_equalTo(self.manBtn.mas_right).with.offset(8);
        make.height.mas_equalTo(35);
        make.width.mas_equalTo(20);
        
    }];
    
    [self.womenBtn
     mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.customerName.mas_bottom).with.offset(5);
        make.left.mas_equalTo(self.womenSex.mas_right).with.offset(8);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(30);
        
    }];
    
    [self.customerOffice mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.customerSex.mas_bottom);
        make.left.mas_equalTo(self.infoView.mas_left).with.offset(30);
        make.height.mas_equalTo(35);
        make.width.mas_equalTo(40);
        
    }];
    
    [self.contentOffice mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.customerSex.mas_bottom);
        make.left.mas_equalTo(self.customerOffice.mas_right).with.offset(8);
        make.height.mas_equalTo(35);
        make.right.mas_equalTo(self.infoView.mas_right).with.offset(-30);
        
    }];
    
    [self.seeTime mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.contentOffice.mas_bottom);
        make.left.mas_equalTo(self.infoView.mas_left).with.offset(30);
        make.height.mas_equalTo(35);
        make.width.mas_equalTo(40);
        
    }];
    
    [self.contentTime mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.contentOffice.mas_bottom);
        make.left.mas_equalTo(self.seeTime.mas_right).with.offset(8);
        make.height.mas_equalTo(35);
        make.right.mas_equalTo(self.infoView.mas_right).with.offset(-30);
        
    }];
    
    [self.initdiagnoView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.infoView.mas_bottom).with.offset(10);
        make.left.mas_equalTo(self.view.mas_left);
        make.height.mas_equalTo(120);
        make.width.mas_equalTo(kWidth);
        
    }];
    
    [self.initdiaLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.initdiagnoView.mas_top);
        make.left.mas_equalTo(self.view.mas_left).with.offset(30);
        make.height.mas_equalTo(35);
        make.width.mas_equalTo(80);
        
    }];
    
    [self.diaTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.initdiaLbl.mas_bottom);
        make.left.mas_equalTo(self.view.mas_left).with.offset(30);
        make.height.mas_equalTo(80);
        make.right.mas_equalTo(self.view.mas_right).with.offset(-30);
        
    }];
    
    
    

    
    
    
    
    

   
    

    
    
    

    
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prescribeClickleft{
    
    [self.navigationController popViewControllerAnimated:YES];
    
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
