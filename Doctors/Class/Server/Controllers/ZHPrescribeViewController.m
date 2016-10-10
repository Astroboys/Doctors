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
//    UIScrollView *scrollView;
    
    
    UIView *useView;
    UILabel *useDetail;
    UITextView *useDetailText;
    
    NSInteger sextValue;
    UIDatePicker *datePicker;
//    UIView *doctorMethod;
//    UILabel *doctorName;
//    UITextField *doctorText;
//    UILabel *doctorUnit;
//    UITextView *doctorUnitText;
    
    
}

@property(nonatomic,strong)UIScrollView *scrollView;
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
@property(nonatomic,strong)UIButton *contentTime;

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
    UIBarButtonItem* item2 = [[UIBarButtonItem alloc]initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(clickright)];
                              
                              
    self.navigationItem.rightBarButtonItem = item2;
    
    
    
    
    
    
    
    [self setupUI];
    [self setupFrame];
    
    
    // 初始化UIDatePicker，旋转滚动选择日期类
    datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, kHeight-64-216, kWidth, 216)];
    datePicker.backgroundColor = DWColor(243, 243, 243);
    [datePicker setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"]];
    // 设置时区
    [datePicker setTimeZone:[NSTimeZone localTimeZone]];
    datePicker.hidden = YES;
    // 设置当前显示时间
    [datePicker setDate:[NSDate date] animated:YES];
    // 设置显示最大时间（此处为当前时间）
    [datePicker setMaximumDate:[NSDate date]];
    // 设置UIDatePicker的显示模式
    [datePicker setDatePickerMode:UIDatePickerModeDate];
    // 当值发生改变的时候调用的方法
    [datePicker addTarget:self action:@selector(datePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.scrollView addSubview:datePicker];
    
    UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(btnAction)];
    [self.scrollView addGestureRecognizer:tap];
}


-(void)setupUI{
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    //    _mterScroView=[[UIScrollView alloc]init];
    self.scrollView.showsVerticalScrollIndicator=NO;
    self.scrollView.showsHorizontalScrollIndicator=NO;
    self.scrollView.bounces=NO;
    self.scrollView.backgroundColor=DWColor(243, 243, 243);
    [self.view addSubview:self.scrollView];
    
    _infoView=[[UIView alloc]init];
    _infoView.userInteractionEnabled = YES;
    _infoView.backgroundColor=[UIColor whiteColor];
    [self.scrollView addSubview:_infoView];
    
    //姓名
    _customerName=[[UILabel alloc]init];
    [_customerName setFont:[UIFont systemFontOfSize:16]];
    _customerName.textColor = [UIColor colorWithRed:85/255.0 green:85/255.0 blue:85/255.0 alpha:1];
    _customerName.text=@"姓名";
    [self.infoView addSubview:_customerName];
    
    _contentsName=[[UITextField alloc]init];
    _contentsName.text = self.personInfo[@"name"];
    _contentsName.placeholder=@"请输入就诊人姓名";
    _contentsName.textColor = [UIColor colorWithRed:85/255.0 green:85/255.0 blue:85/255.0 alpha:1];

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
    NSString *sexStr = self.personInfo[@"sex"];
    sextValue = sexStr.integerValue;
    
    if (sextValue==1) {
        _manBtn.selected = YES;
        _womenBtn.selected = NO;
    }else{
        _womenBtn.selected = YES;
        _manBtn.selected = NO;
    }

    
    
    //
    _customerOffice=[[UILabel alloc]init];
    _customerOffice.text=@"科室";
    _customerOffice.textColor = [UIColor colorWithRed:85/255.0 green:85/255.0 blue:85/255.0 alpha:1];

    [_customerOffice setFont:[UIFont systemFontOfSize:16]];
    [self.infoView addSubview:_customerOffice];
    
    _contentOffice=[[UITextField alloc]init];
    [_contentOffice setFont:[UIFont systemFontOfSize:16]];
    _contentOffice.placeholder=@"请输入就诊科室";
    _contentOffice.textColor = [UIColor colorWithRed:85/255.0 green:85/255.0 blue:85/255.0 alpha:1];

    
    [self.infoView addSubview:_contentOffice];
    
    _seeTime=[[UILabel alloc]init];
    [_seeTime setFont:[UIFont systemFontOfSize:16]];
    _seeTime.text=@"时间";
    _seeTime.textColor = [UIColor colorWithRed:85/255.0 green:85/255.0 blue:85/255.0 alpha:1];

    [self.infoView addSubview:_seeTime];
    
    _contentTime=[UIButton buttonWithType:UIButtonTypeCustom];
    _contentTime.titleLabel.font = [UIFont systemFontOfSize:16];
    [_contentTime setTitleColor:[UIColor colorWithRed:85/255.0 green:85/255.0 blue:85/255.0 alpha:1] forState:UIControlStateNormal];
    [_contentTime setTitle:@"选择就诊时间" forState:UIControlStateNormal];
    [_contentTime addTarget:self action:@selector(clientPickDate) forControlEvents:UIControlEventTouchUpInside];
    [self.infoView addSubview:_contentTime];
    
    _initdiagnoView=[[UIView alloc]init];
    _initdiagnoView.backgroundColor=[UIColor whiteColor];
    [self.scrollView addSubview:_initdiagnoView];
    
    _initdiaLbl=[[UILabel alloc]init];
    [_initdiaLbl setFont:[UIFont systemFontOfSize:16]];
    _initdiaLbl.text=@"初步诊断";
    _initdiaLbl.textColor = [UIColor colorWithRed:85/255.0 green:85/255.0 blue:85/255.0 alpha:1];

    [self.initdiagnoView addSubview:_initdiaLbl];
    
    _diaTextView=[[UITextView alloc]init];
    [_diaTextView setFont:[UIFont systemFontOfSize:14]];
    _diaTextView.layer.cornerRadius = 6;
    _diaTextView.layer.borderWidth = 0.5;
    _diaTextView.textColor = DWColor(149, 149, 149);
    _diaTextView.layer.borderColor = [UIColor colorWithRed:166/255.0 green:171/255.0 blue:185/255.0 alpha:1].CGColor;
    [self.initdiagnoView addSubview:_diaTextView];
    
    
    
    
    useView=[[UIView alloc]init];
//    useView.userInteractionEnabled = YES;
    useView.backgroundColor=[UIColor whiteColor];
    [self.scrollView addSubview:useView];

    
    useDetail=[[UILabel alloc]init];
    [useDetail setFont:[UIFont systemFontOfSize:16]];
    useDetail.text=@"处方明细";
    useDetail.textColor = [UIColor colorWithRed:85/255.0 green:85/255.0 blue:85/255.0 alpha:1];
    
    [useView addSubview:useDetail];
    
    useDetailText=[[UITextView alloc]init];
    [useDetailText setFont:[UIFont systemFontOfSize:14]];
    useDetailText.layer.cornerRadius = 6;
    useDetailText.layer.borderWidth = 0.5;
    useDetailText.textColor = DWColor(149, 149, 149);
    useDetailText.layer.borderColor = [UIColor colorWithRed:166/255.0 green:171/255.0 blue:185/255.0 alpha:1].CGColor;
    [useView addSubview:useDetailText];
    
    
    
}

-(void)manBtnClick{

    self.manBtn.selected=YES;
    self.womenBtn.selected=NO;
    sextValue = 1;
}

-(void)womenBtnClick{
    sextValue = 2;
    self.womenBtn.selected=YES;
    self.manBtn.selected=NO;
}


-(void)setupFrame{
    
    [self.infoView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.scrollView.mas_top);
        make.left.mas_equalTo(self.scrollView.mas_left);
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
        make.width.mas_equalTo(100);;
        
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
        make.left.mas_equalTo(self.scrollView.mas_left);
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
    
    [self.scrollView.superview layoutIfNeeded];

    
    CGFloat scroH=CGRectGetMaxY(useView.frame);
    NSLog(@"%f",scroH);
    
    self.scrollView.contentSize=CGSizeMake(kWidth, scroH*1.3);

    

    
}

-(void)setLineView:(UIView *)view offView:(UIView *)offView
{
    UIView *lineView=[[UIView alloc]init];
    lineView.backgroundColor=DWColor(223, 222, 222);
    [view addSubview:lineView];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(offView.mas_bottom).with.offset(3);
        make.left.mas_equalTo(self.scrollView.mas_left).with.offset(15);
        make.right.mas_equalTo(self.scrollView.mas_right).with.offset(-15);
        make.height.mas_equalTo(1);
    }];

}
-(void)btnAction
{
    datePicker.hidden = YES;
}
-(void)clientPickDate
{
    datePicker.hidden = NO;
}
-(void)datePickerValueChanged:(UIDatePicker *)picker
{
    NSLog(@"%@",picker);
    NSDate *select = datePicker.date;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *selectDate = [dateFormatter stringFromDate:select];
    [_contentTime setTitle:selectDate forState:UIControlStateNormal];
   
}
-(void)clickright
{
    [self.view endEditing:NO];
    [YJProgressHUD showProgress:@"正在提交..." inView:self.view];
    NSDictionary *dic = @{@"doctorId":[UConfig getDoctorId],@"customerId":self.personInfo[@"id"],@"visitTime":_contentTime.titleLabel.text,@"tentDiag":_diaTextView.text,@"presContent":useDetailText.text,@"section":_contentOffice.text};
    [NetWorkingManager requestGETDataWithPath:[NSString stringWithFormat:@"%@%@",BaseUrl,@"app/pres/addPres"] withParamters:dic withProgress:^(float progress) {
        
    } success:^(BOOL isSuccess, id responseObject) {
        NSString *code = responseObject[@"code"];
        [YJProgressHUD hide];
        if (code.intValue == 200) {
            [YJProgressHUD showSuccess:@"提交成功" inview:self.view];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [YJProgressHUD showSuccess:@"提交失败" inview:self.view];
        }
        
        NSLog(@"%@",responseObject);
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        [YJProgressHUD hide];
        [YJProgressHUD showSuccess:@"提交失败，请检查网络" inview:self.view];
    }];
    

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prescribeClickleft{
    [NetWorkingManager cancelAllNetworkRequest];
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
