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
{
    UIScrollView *scrollView;
    
    
    UIView *useView;
    UILabel *useDetail;
    UITextView *useDetailText;
    
    
    
    UIView *doctorMethod;
    UILabel *doctorName;
    UITextField *doctorText;
    UILabel *doctorUnit;
    UITextView *doctorUnitText;
    
    
}
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

@property(nonatomic,strong)UIView*prescriptionView;
@property(nonatomic,strong)UILabel*medicName;
@property(nonatomic,strong)UILabel*measure;
@property(nonatomic,strong)UILabel*times;

@end

@implementation ZHPrescribeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=DWColor(243, 243, 243);
    self.navigationItem.title=@"在线开处方";
    UIImage* image1 = [UIImage imageNamed:@"navigationbar_back_withtext"];
    image1 = [image1 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIBarButtonItem* item1 = [[UIBarButtonItem alloc]initWithImage:image1 style:UIBarButtonItemStylePlain target:self action:@selector(prescribeClickleft)];
    
    self.navigationItem.leftBarButtonItem=item1;
    
    [self setupUI];
    [self setupFrame];
    
}

-(void)setupUI{
    
    scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.scrollEnabled = YES;
    scrollView.backgroundColor=DWColor(243, 243, 243);

    [self.view addSubview:scrollView];
    
    _infoView=[[UIView alloc]init];
    _infoView.userInteractionEnabled = YES;
    _infoView.backgroundColor=[UIColor whiteColor];
    [scrollView addSubview:_infoView];
    
    //姓名
    _customerName=[[UILabel alloc]init];
    [_customerName setFont:[UIFont systemFontOfSize:16]];
    _customerName.textColor = [UIColor colorWithRed:85/255.0 green:85/255.0 blue:85/255.0 alpha:1];
    _customerName.text=@"姓名";
    [self.infoView addSubview:_customerName];
    
    _contentsName=[[UITextField alloc]init];
    _contentsName.placeholder=@"请输入就诊人姓名";
    [_contentsName setFont:[UIFont systemFontOfSize:16]];
    [self.infoView addSubview:_contentsName];
    
    
   
    
    //性别
    _customerSex=[[UILabel alloc]init];
    [_customerSex setFont:[UIFont systemFontOfSize:16]];
    _customerSex.textColor = [UIColor colorWithRed:85/255.0 green:85/255.0 blue:85/255.0 alpha:1];

    _customerSex.text=@"性别";
    [self.infoView addSubview:_customerSex];
    
    //男
    _manSex=[[UILabel alloc]init];
    [_customerSex setFont:[UIFont systemFontOfSize:16]];
    _manSex.text=@"男";
    _manSex.textColor = [UIColor colorWithRed:85/255.0 green:85/255.0 blue:85/255.0 alpha:1];

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
    _womenSex.textColor = [UIColor colorWithRed:85/255.0 green:85/255.0 blue:85/255.0 alpha:1];

    [self.infoView addSubview:_womenSex];
    
    _womenBtn=[[UIButton alloc]init];
    [_womenBtn setImage:[UIImage imageNamed:@"un_select"] forState:UIControlStateNormal];
    [_womenBtn setImage:[UIImage imageNamed:@"select"] forState:UIControlStateSelected];
    [_womenBtn addTarget:self action:@selector(womenBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.infoView addSubview:_womenBtn];

    //
    _customerOffice=[[UILabel alloc]init];
    _customerOffice.text=@"科室";
    _customerOffice.textColor = [UIColor colorWithRed:85/255.0 green:85/255.0 blue:85/255.0 alpha:1];

    [_customerOffice setFont:[UIFont systemFontOfSize:16]];
    [self.infoView addSubview:_customerOffice];
    
    _contentOffice=[[UITextField alloc]init];
    [_contentOffice setFont:[UIFont systemFontOfSize:16]];
    _contentOffice.placeholder=@"请输入就诊科室";
    
    [self.infoView addSubview:_contentOffice];
    
    _seeTime=[[UILabel alloc]init];
    [_seeTime setFont:[UIFont systemFontOfSize:16]];
    _seeTime.text=@"时间";
    _seeTime.textColor = [UIColor colorWithRed:85/255.0 green:85/255.0 blue:85/255.0 alpha:1];

    [self.infoView addSubview:_seeTime];
    
    _contentTime=[[UITextField alloc]init];
    [_contentTime setFont:[UIFont systemFontOfSize:16]];
    _contentTime.placeholder=@"请输入就诊时间";
    [self.infoView addSubview:_contentTime];
    
    _initdiagnoView=[[UIView alloc]init];
    _initdiagnoView.backgroundColor=[UIColor whiteColor];
    [scrollView addSubview:_initdiagnoView];
    
    _initdiaLbl=[[UILabel alloc]init];
    [_initdiaLbl setFont:[UIFont systemFontOfSize:16]];
    _initdiaLbl.text=@"初步诊断";
    _initdiaLbl.textColor = [UIColor colorWithRed:85/255.0 green:85/255.0 blue:85/255.0 alpha:1];

    [self.initdiagnoView addSubview:_initdiaLbl];
    
    _diaTextView=[[UITextView alloc]init];
    [_diaTextView setFont:[UIFont systemFontOfSize:16]];
    _diaTextView.layer.cornerRadius = 6;
    _diaTextView.layer.borderWidth = 0.5;
    _diaTextView.layer.borderColor = [UIColor colorWithRed:166/255.0 green:171/255.0 blue:185/255.0 alpha:1].CGColor;
    [self.initdiagnoView addSubview:_diaTextView];
    
    
    
    
    useView=[[UIView alloc]init];
    useView.userInteractionEnabled = YES;
    useView.backgroundColor=[UIColor whiteColor];
    [scrollView addSubview:useView];

    
    useDetail=[[UILabel alloc]init];
    [useDetail setFont:[UIFont systemFontOfSize:16]];
    useDetail.text=@"处方明细";
    useDetail.textColor = [UIColor colorWithRed:85/255.0 green:85/255.0 blue:85/255.0 alpha:1];
    
    [useView addSubview:useDetail];
    
    useDetailText=[[UITextView alloc]init];
    [useDetailText setFont:[UIFont systemFontOfSize:16]];
    useDetailText.layer.cornerRadius = 6;
    useDetailText.layer.borderWidth = 0.5;
    useDetailText.layer.borderColor = [UIColor colorWithRed:166/255.0 green:171/255.0 blue:185/255.0 alpha:1].CGColor;
    [useView addSubview:useDetailText];
    
    

    
    
    
    
    
    
    doctorMethod=[[UIView alloc]init];
    doctorMethod.userInteractionEnabled = YES;

    doctorMethod.backgroundColor=[UIColor whiteColor];
    [scrollView addSubview:doctorMethod];
    
    //药名
    doctorName=[[UILabel alloc]init];
    [doctorName setFont:[UIFont systemFontOfSize:16]];
    doctorName.textColor = [UIColor colorWithRed:85/255.0 green:85/255.0 blue:85/255.0 alpha:1];
    doctorName.text=@"医生名称";
    [doctorMethod addSubview:doctorName];
    
    doctorText=[[UITextField alloc]init];
    doctorText.placeholder=@"点击输入医生名称";
    [doctorText setFont:[UIFont systemFontOfSize:16]];
    [doctorMethod addSubview:doctorText];

    
    //使用方法
    doctorUnit=[[UILabel alloc]init];
    [doctorUnit setFont:[UIFont systemFontOfSize:14]];
    doctorUnit.textColor = [UIColor colorWithRed:85/255.0 green:85/255.0 blue:85/255.0 alpha:1];
    doctorUnit.text=@"医生单位";
    [doctorMethod addSubview:doctorUnit];
    
    doctorUnitText=[[UITextView alloc]init];
//    usageText.placeholder=@"点击输入使用方法";
    [doctorUnitText setFont:[UIFont systemFontOfSize:14]];
    [doctorMethod addSubview:doctorUnitText];

    
//    //
//    useTime=[[UILabel alloc]init];
//    [useTime setFont:[UIFont systemFontOfSize:14]];
//    useTime.textColor = [UIColor colorWithRed:85/255.0 green:85/255.0 blue:85/255.0 alpha:1];
//    useTime.text=@"用药时间";
//    [doctorMethod addSubview:useTime];
//    
//    useTimeText=[[UITextField alloc]init];
//    useTimeText.placeholder=@"输入用药时间";
//    [useTimeText setFont:[UIFont systemFontOfSize:14]];
//    [doctorMethod addSubview:useTimeText];
    
    
    
    
    
    
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
        
        make.top.equalTo(scrollView.mas_top);
        make.left.mas_equalTo(scrollView.mas_left);
        make.height.mas_equalTo(170);
        make.width.mas_equalTo(kWidth);
        
    }];
    
    [self.customerName mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.infoView.mas_top).with.offset(10);
        make.left.mas_equalTo(self.infoView.mas_left).with.offset(15);
        make.height.mas_equalTo(35);
        make.width.mas_equalTo(40);
        
    }];
    
    [self.contentsName mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.infoView.mas_top).with.offset(10);
        make.left.mas_equalTo(self.customerName.mas_right).with.offset(8);
        make.height.mas_equalTo(35);
        make.right.mas_equalTo(self.infoView.mas_right).with.offset(-15);
        
    }];
    
    [self setLineView:self.infoView offView:self.contentsName];
    
    [self.customerSex mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.customerName.mas_bottom).with.offset(5);
        make.left.mas_equalTo(self.infoView.mas_left).with.offset(15);
        make.height.mas_equalTo(35);
        make.width.mas_equalTo(40);
        
    }];
    
    [self.manSex mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.customerName.mas_bottom).with.offset(5);
        make.left.mas_equalTo(self.customerSex.mas_right).with.offset(8);
        make.height.mas_equalTo(35);
        make.width.mas_equalTo(20);
        
    }];
    
    [self.manBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.customerName.mas_bottom).with.offset(15);
        make.left.mas_equalTo(self.manSex.mas_right).with.offset(8);
        make.height.mas_equalTo(15);
        make.width.mas_equalTo(15);
        
    }];
    
    [self.womenSex mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.customerName.mas_bottom).with.offset(5);
        make.left.mas_equalTo(self.manBtn.mas_right).with.offset(8);
        make.height.mas_equalTo(35);
        make.width.mas_equalTo(20);
        
    }];
    
    [self.womenBtn
     mas_makeConstraints:^(MASConstraintMaker *make) {
         
        make.top.equalTo(self.customerName.mas_bottom).with.offset(15);
        make.left.mas_equalTo(self.womenSex.mas_right).with.offset(8);
        make.height.mas_equalTo(15);
        make.width.mas_equalTo(15);
         
    }];
    
     [self setLineView:self.infoView offView:self.manSex];
    
    [self.customerOffice mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.customerSex.mas_bottom).with.offset(5);
        make.left.mas_equalTo(self.infoView.mas_left).with.offset(15);
        make.height.mas_equalTo(35);
        make.width.mas_equalTo(40);
        
    }];
    
    [self.contentOffice mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.customerSex.mas_bottom).with.offset(5);
        make.left.mas_equalTo(self.customerOffice.mas_right).with.offset(8);
        make.height.mas_equalTo(35);
        make.right.mas_equalTo(self.infoView.mas_right).with.offset(-15);
        
    }];
    
    [self setLineView:self.infoView offView:self.contentOffice];
    
    
    [self.seeTime mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.contentOffice.mas_bottom).with.offset(5);
        make.left.mas_equalTo(self.infoView.mas_left).with.offset(15);
        make.height.mas_equalTo(35);
        make.width.mas_equalTo(40);
        
    }];
  
    [self.contentTime mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.contentOffice.mas_bottom).with.offset(5);
        make.left.mas_equalTo(self.seeTime.mas_right).with.offset(8);
        make.height.mas_equalTo(35);
        make.right.mas_equalTo(self.infoView.mas_right).with.offset(-15);
        
    }];
    
    
    
    
    [self.initdiagnoView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.infoView.mas_bottom).with.offset(10);
        make.left.mas_equalTo(self.view.mas_left);
        make.height.mas_equalTo(140);
        make.width.mas_equalTo(kWidth);
        
    }];
    
    [self.initdiaLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.initdiagnoView.mas_top).with.offset(10);
        make.left.mas_equalTo(self.initdiagnoView.mas_left).with.offset(15);
        make.height.mas_equalTo(35);
        make.width.mas_equalTo(80);
        
    }];
    
    [self.diaTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.initdiaLbl.mas_bottom).with.offset(10);
        make.left.mas_equalTo(self.initdiagnoView.mas_left).with.offset(15);
        make.height.mas_equalTo(64);
        make.right.mas_equalTo(self.initdiagnoView.mas_right).with.offset(-15);
        
    }];
    
    
    
    
    [useView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.initdiagnoView.mas_bottom).with.offset(10);
        make.left.mas_equalTo(scrollView.mas_left);
        make.height.mas_equalTo(140);
        make.width.mas_equalTo(kWidth);
        
    }];
    [useDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(useView.mas_top).with.offset(10);
        make.left.mas_equalTo(useView.mas_left).with.offset(15);
        make.height.mas_equalTo(35);
        make.width.mas_equalTo(80);
        
    }];
    [useDetailText mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(useDetail.mas_bottom).with.offset(10);
        make.left.mas_equalTo(useView.mas_left).with.offset(15);
        make.height.mas_equalTo(64);
        make.right.mas_equalTo(useView.mas_right).with.offset(-15);
        
    }];
    

    
    
    
    
    
    [doctorMethod mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(useView.mas_bottom).with.offset(10);
        make.left.mas_equalTo(scrollView.mas_left);
        make.height.mas_equalTo(90);
        make.width.mas_equalTo(kWidth);

        
    }];
    
    [doctorName mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(doctorMethod.mas_top).with.offset(10);
        make.left.mas_equalTo(doctorMethod.mas_left).with.offset(15);
        make.height.mas_equalTo(35);
        make.width.mas_equalTo(70);
        
    }];
    
    [doctorText mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(doctorMethod.mas_top).with.offset(10);
        make.left.mas_equalTo(doctorName.mas_right).with.offset(8);
        make.height.mas_equalTo(35);
        make.right.mas_equalTo(doctorMethod.mas_right).with.offset(-15);
        
    }];
    [self setLineView:doctorMethod offView:doctorText];

    
    [doctorUnit mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(doctorText.mas_bottom).with.offset(5);
        make.left.mas_equalTo(doctorMethod.mas_left).with.offset(15);
        make.height.mas_equalTo(35);
        make.width.mas_equalTo(70);
        
    }];
    
    [doctorUnitText mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(doctorText.mas_bottom).with.offset(5);
        make.left.mas_equalTo(doctorUnit.mas_right).with.offset(8);
        make.height.mas_equalTo(35);
        make.right.mas_equalTo(doctorMethod.mas_right).with.offset(-15);
        
    }];
    
    [scrollView.superview layoutIfNeeded];
    scrollView.contentSize = CGSizeMake(kWidth, CGRectGetMaxY(doctorMethod.frame)+64);

//    [self setLineView:doctorMethod offView:usageText];
    
  
//    [useTime mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.top.equalTo(usageText.mas_bottom).with.offset(5);
//        make.left.mas_equalTo(doctorMethod.mas_left).with.offset(15);
//        make.height.mas_equalTo(35);
//        make.width.mas_equalTo(40);
//        
//    }];
//    
//    [useTimeText mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.top.equalTo(usageText.mas_bottom).with.offset(5);
//        make.left.mas_equalTo(useTime.mas_right).with.offset(8);
//        make.height.mas_equalTo(35);
//        make.right.mas_equalTo(doctorMethod.mas_right).with.offset(-15);
//        
//    }];

    
}

-(void)setLineView:(UIView *)view offView:(UIView *)offView
{
    UIView *lineView=[[UIView alloc]init];
    lineView.backgroundColor=DWColor(223, 222, 222);
    [view addSubview:lineView];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(offView.mas_bottom).with.offset(3);
        make.left.mas_equalTo(scrollView.mas_left).with.offset(15);
        make.right.mas_equalTo(scrollView.mas_right).with.offset(-15);
        make.height.mas_equalTo(1);
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
