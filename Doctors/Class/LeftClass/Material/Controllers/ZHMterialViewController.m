//
//  ZHMterialViewController.m
//  YCSideslip
//
//  Created by 崔敬轩 on 16/8/20.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ZHMterialViewController.h"
#import "AddressPickView.h"
#import "Masonry.h"

@interface ZHMterialViewController ()

@property (nonatomic,strong)UIPickerView *pickView;
@property(nonatomic,strong)UIScrollView*mescroView;
@property(nonatomic,strong)UIView*firstView;
@property(nonatomic,strong)UIView*secondView;


@property(nonatomic,strong)UILabel*nameLbl;
@property(nonatomic,strong)UITextField*nameText;

@property(nonatomic,strong)UILabel*nichengLbl;
@property(nonatomic,strong)UILabel*nichengText;

@property(nonatomic,strong)UILabel*sexLbl;
@property(nonatomic,strong)UILabel*sexText;

@property(nonatomic,strong)UILabel*birLbl;
@property(nonatomic,strong)UILabel*birText;

@property(nonatomic,strong)UILabel*diQuLbl;
@property(nonatomic,strong)UITextField *proviceLabel;

@property(nonatomic,strong)UITextField*cityLabel;
@property(nonatomic,strong)UITextField*countyLabel;


@property(nonatomic,strong)UILabel*phoneLbl;
@property(nonatomic,strong)UILabel*phoneText;
@property(nonatomic,strong)UILabel*emailLbl;
@property(nonatomic,strong)UITextField*emailText;
@property(nonatomic,strong)UILabel*jobLbl;
@property(nonatomic,strong)UITextField*jobText;
@property(nonatomic,strong)UILabel*addLbl;
@property(nonatomic,strong)UITextField*addText;
@property(nonatomic,strong)UILabel*codeLbl;
@property(nonatomic,strong)UITextField*codeText;


@end

@implementation ZHMterialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = DWColor(243, 243, 243);
    self.title = @"基本资料";
    [self.navigationController.navigationBar setTitleTextAttributes:
  @{NSFontAttributeName:[UIFont systemFontOfSize:19],
    NSForegroundColorAttributeName:[UIColor whiteColor]}];

    UIImage* image1 = [UIImage imageNamed:@"navigationbar_back_withtext"];
    // 告诉系统以后这张图片不进行默认的渲染
    image1 = [image1 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIImage* image2 = [UIImage imageNamed:@"navigationbar_pop"];
    // 告诉系统以后这张图片不进行默认的渲染
    image2 = [image2 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    // 创建活动的按钮
     UIBarButtonItem* item1 = [[UIBarButtonItem alloc]initWithImage:image1 style:UIBarButtonItemStylePlain target:self action:@selector(mterialClickleft)];
    
    UIBarButtonItem* item2 = [[UIBarButtonItem alloc]initWithImage:image2 style:UIBarButtonItemStylePlain target:self action:@selector(mterialClickright)];
    self.navigationItem.leftBarButtonItem = item1;
    self.navigationItem.rightBarButtonItem = item2;
    [self setupUI];
    [self setupFrame];

}

-(void)mterialClickleft{

    [self.nameText resignFirstResponder];
    [self.proviceLabel resignFirstResponder];
    [self.emailText resignFirstResponder];
    [self.jobText resignFirstResponder];
    [self.addText resignFirstResponder];
    [self.codeText resignFirstResponder];
    
    [self.navigationController popViewControllerAnimated:YES];

}

-(void)setupUI{

    _mescroView=[[UIScrollView alloc]initWithFrame:self.view.frame];
    _mescroView.contentSize=CGSizeMake(kWidth, kHeight*2);
    
    
    //姓名
    //_firstView=[[UIView alloc]initWithFrame:CGRectMake(0, 10,kWidth, 250)];
    _firstView=[[UIView alloc]init];
    _firstView.backgroundColor =[UIColor whiteColor];
    
    //姓名
    //UILabel*nameLbl=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, 80, 50)];
    _nameLbl=[[UILabel alloc]init];
    [_nameLbl setFont:[UIFont systemFontOfSize:14]];
    _nameLbl.text =@"真实姓名:";
    [_nameLbl setTextAlignment:NSTextAlignmentRight];
    //_nameLbl.backgroundColor=[UIColor redColor];
    _nameText=[[UITextField alloc]initWithFrame:CGRectMake(100,0 , kWidth-80-20, 50)];
    _nameText.placeholder =@"请输入您的真实姓名（五个汉字之内）";
    [_nameText setFont:[UIFont systemFontOfSize:14]];
    [self.firstView addSubview:_nameLbl];
    [self.firstView addSubview:_nameText];
    
    //昵称
    _nichengLbl=[[UILabel alloc]initWithFrame:CGRectMake(20, 50, 80, 50)];
    [_nichengLbl setFont:[UIFont systemFontOfSize:14]];
    _nichengLbl.text =@"昵称:";
    [_nichengLbl setTextAlignment:NSTextAlignmentRight];
    _nichengText=[[UILabel alloc]initWithFrame:CGRectMake(100,50 , kWidth-80-20, 50)];
    [_nichengText setFont:[UIFont systemFontOfSize:14]];
    _nichengText.backgroundColor=DWColor(243, 243, 243);
    _nichengText.text=@"13532238947";
    [self.firstView addSubview:_nichengLbl];
    [self.firstView addSubview:_nichengText];
    
    //性别
    _sexLbl=[[UILabel alloc]initWithFrame:CGRectMake(20, 100, 80, 50)];
    _sexLbl.text =@"性别:";
    [_sexLbl setTextAlignment:NSTextAlignmentRight];
    [_sexLbl setFont:[UIFont systemFontOfSize:14]];
    _sexText=[[UILabel alloc]initWithFrame:CGRectMake(100,100 , kWidth-80-20, 50)];
    _sexText.text=@"男";
    [_sexText setFont:[UIFont systemFontOfSize:14]];
    [self.firstView addSubview:_sexLbl];
    [self.firstView addSubview:_sexText];
    
    //出生日期
    //_birLbl=[[UILabel alloc]initWithFrame:CGRectMake(20, 150, 80, 50)];
    _birLbl=[[UILabel alloc]init];
    _birLbl.text =@"出生日期:";
    [_birLbl setTextAlignment:NSTextAlignmentRight];
    [_birLbl setFont:[UIFont systemFontOfSize:14]];
    _birText=[[UILabel alloc]initWithFrame:CGRectMake(100,150 , kWidth-80-20, 50)];
    _birText.text = @"1990-08-02";
    _birText.backgroundColor=DWColor(243, 243, 243);
    [_birText setFont:[UIFont systemFontOfSize:14]];
    [self.firstView addSubview:_birLbl];
    [self.firstView addSubview:_birText];

    //所在地区
    _diQuLbl=[[UILabel alloc]initWithFrame:CGRectMake(20, 200, 80, 50)];
    _diQuLbl=[[UILabel alloc]init];
    _diQuLbl.text =@"所在地区:";
    [_diQuLbl setTextAlignment:NSTextAlignmentRight];
    [_diQuLbl setFont:[UIFont systemFontOfSize:14]];
    
    _proviceLabel=[[UITextField alloc]init];
    [_proviceLabel setFont:[UIFont systemFontOfSize:14]];
    _proviceLabel.placeholder=@"省";
    
    _cityLabel=[[UITextField alloc]init];
    [_cityLabel setFont:[UIFont systemFontOfSize:14]];
    _cityLabel.placeholder=@"市";
    
    _countyLabel=[[UITextField alloc]init];
    [_countyLabel setFont:[UIFont systemFontOfSize:14]];
    _countyLabel.placeholder=@"区（县）";

    _proviceLabel.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showAddressPickView)];
    
    [_proviceLabel addGestureRecognizer:tap];
    
    _pickView=[[UIPickerView alloc]init];
    _proviceLabel.inputView =self.pickView;

    [self.firstView addSubview:_diQuLbl];
    [self.firstView addSubview:_proviceLabel];
    [self.firstView addSubview:_countyLabel];
    [self.firstView addSubview:_cityLabel];
    [self.firstView addSubview:_secondView];
    
    [self.mescroView addSubview:_firstView];
    
    [self.view addSubview:_mescroView];
    

    //_secondView=[[UIView alloc]initWithFrame:CGRectMake(0, 284,kWidth , 250)];
    _secondView=[[UIView alloc]init];
    _secondView.backgroundColor =[UIColor whiteColor];
    
    
    //手机号
    //_phoneLbl=[[UILabel alloc]initWithFrame:CGRectMake(20, 0, 80, 50)];
    _phoneLbl=[[UILabel alloc]init];
    _phoneLbl.text =@"手机号:";
    [_phoneLbl setTextAlignment:NSTextAlignmentRight];
    [_phoneLbl setFont:[UIFont systemFontOfSize:14]];
//    _phoneText=[[UILabel alloc]initWithFrame:CGRectMake(100,50 , kWidth-80-20, 50)];
    _phoneText=[[UILabel alloc]init];
    _phoneText.text=@"13532238947";
    [_phoneText setFont:[UIFont systemFontOfSize:14]];
    
    [self.secondView addSubview:_phoneLbl];
    [self.secondView addSubview:_phoneText];
    //电子邮箱
    //UILabel*emailLbl=[[UILabel alloc]initWithFrame:CGRectMake(20, 50, 80, 50)];
    _emailLbl=[[UILabel alloc]init];
    _emailLbl.text =@"电子邮箱:";
    [_emailLbl setTextAlignment:NSTextAlignmentRight];
    [_emailLbl setFont:[UIFont systemFontOfSize:14]];

    //UITextField*emailText=[[UITextField alloc]initWithFrame:CGRectMake(100,0 , kWidth-80-20, 50)];
    _emailText=[[UITextField alloc]init];
    _emailText.placeholder =@"请输入您的电子邮箱";
    [_emailText setFont:[UIFont systemFontOfSize:14]];

    
    [self.secondView addSubview:_emailLbl];
    [self.secondView addSubview:_emailText];
    
    //工作单位
    //UILabel*jobLbl=[[UILabel alloc]initWithFrame:CGRectMake(20, 100, 80, 50)];
    _jobLbl=[[UILabel alloc]init];
    _jobLbl.text =@"工作单位:";
    [_jobLbl setTextAlignment:NSTextAlignmentRight];
    [_jobLbl setFont:[UIFont systemFontOfSize:14]];

    //UITextField*jobText=[[UITextField alloc]initWithFrame:CGRectMake(100,50 , kWidth-80-20, 50)];
    _jobText=[[UITextField alloc]init];
    [_jobText setFont:[UIFont systemFontOfSize:14]];
    _jobText.placeholder =@"请输入您的工作单位";
    [self.secondView addSubview:_jobLbl];
    [self.secondView addSubview:_jobText];
    
    //通信地址
    //UILabel*addLbl=[[UILabel alloc]initWithFrame:CGRectMake(20, 150, 80, 50)];
    _addLbl=[[UILabel alloc]init];
    _addLbl.text =@"通信地址:";
    [_addLbl setTextAlignment:NSTextAlignmentRight];
    [_addLbl setFont:[UIFont systemFontOfSize:14]];
    //UITextField*addText=[[UITextField alloc]initWithFrame:CGRectMake(100,150 , kWidth-80-20, 50)];
    _addText=[[UITextField alloc]init];
    [_addText setFont:[UIFont systemFontOfSize:14]];
    _addText.placeholder =@"请输入您的通信地址";
    [self.secondView addSubview:_addLbl];
    [self.secondView addSubview:_addText];
    
    
    //邮编
    //UILabel*codeLbl=[[UILabel alloc]initWithFrame:CGRectMake(20, 200, 80, 50)];
    _codeLbl=[[UILabel alloc]init];
    _codeLbl.text =@"邮编:";
    [_codeLbl setTextAlignment:NSTextAlignmentRight];
    [_codeLbl setFont:[UIFont systemFontOfSize:14]];
    //UITextField*codeText=[[UITextField alloc]initWithFrame:CGRectMake(100, 200, (kWidth-80-20)/2, 50)];
    _codeText=[[UITextField alloc]init];
    [_codeText setFont:[UIFont systemFontOfSize:14]];
    _codeText.placeholder =@"请输入您的邮编";
    [self.secondView addSubview:_codeLbl];
    [self.secondView addSubview:_codeText];
    
    [self.mescroView addSubview:_secondView];
    
    [self.view addSubview:self.mescroView];

}


-(void)setupFrame{
    
    [self.firstView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(20);
        make.left.mas_equalTo(self.view.mas_left).with.offset(5);
        make.right.mas_equalTo(self.view.mas_right).with.offset(-5);
        make.height.mas_equalTo(160);
        
    }];
    
    
    [self.nameLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.firstView.mas_top).with.offset(10);
        make.left.mas_equalTo(10);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(70);
    }];
    
    [self.nameText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.firstView.mas_top).with.offset(10);
        make.left.mas_equalTo(self.nameLbl.mas_right);
        make.height.mas_equalTo(30);
        make.right.equalTo(self.view.mas_right).with.offset(-20);
    }];
    
    [self.nichengLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLbl.mas_bottom);
        make.left.mas_equalTo(self.nameLbl.mas_left);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(70);
    }];
    [self.nichengText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameText.mas_bottom);
        make.left.mas_equalTo(self.nameText.mas_left);
        make.height.mas_equalTo(30);
        make.right.equalTo(self.view.mas_right).with.offset(-20);
    }];
    
    [self.sexLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nichengLbl.mas_bottom);
        make.left.mas_equalTo(self.nichengLbl.mas_left);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(70);
    }];
    [self.sexText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nichengText.mas_bottom);
        make.left.mas_equalTo(self.nichengLbl.mas_right);
        make.height.mas_equalTo(30);
        make.right.equalTo(self.view.mas_right).with.offset(-20);
    }];
    
    [self.birLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.sexLbl.mas_bottom);
        make.left.mas_equalTo(self.sexLbl.mas_left);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(70);
    }];
    [self.birText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.sexText.mas_bottom);
        make.left.mas_equalTo(self.sexLbl.mas_right);
        make.height.mas_equalTo(30);
        make.right.equalTo(self.view.mas_right).with.offset(-20);
    }];
    
    [self.diQuLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.birLbl.mas_bottom);
        make.left.mas_equalTo(self.birLbl.mas_left);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(70);
    }];
    [self.proviceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.birText.mas_bottom);
        make.left.mas_equalTo(self.birLbl.mas_right);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(_cityLabel.mas_width);
    }];
    
    [self.countyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.birText.mas_bottom);
        make.left.mas_equalTo(self.cityLabel.mas_left);
        make.height.mas_equalTo(30);
        make.right.equalTo(self.view.mas_right).with.offset(-20);
    }];

    [self.cityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.birText.mas_bottom);
        make.left.mas_equalTo(self.proviceLabel.mas_right);
        make.height.mas_equalTo(30);
        make.right.equalTo(self.countyLabel.mas_left);
    }];
    
    
    [self.secondView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.firstView.mas_bottom).with.offset(20);
        make.left.mas_equalTo(self.view.mas_left).with.offset(5);
        make.right.mas_equalTo(self.view.mas_right).with.offset(-5);
        make.height.mas_equalTo(160);
    }];
    
    [self.phoneLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.secondView.mas_top).with.offset(10);
        make.left.mas_equalTo(10);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(70);
    }];
    
    [self.phoneText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.secondView.mas_top).with.offset(10);
        make.left.mas_equalTo(self.phoneLbl.mas_right);
        make.height.mas_equalTo(30);
        make.right.equalTo(self.view.mas_right).with.offset(-20);
    }];
    
    [self.emailLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.phoneLbl.mas_bottom);
        make.left.mas_equalTo(self.nameLbl.mas_left);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(70);
    }];
    [self.emailText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.phoneLbl.mas_bottom);
        make.left.mas_equalTo(self.nameText.mas_left);
        make.height.mas_equalTo(30);
        make.right.equalTo(self.view.mas_right).with.offset(-20);
    }];
    
    [self.jobLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.emailLbl.mas_bottom);
        make.left.mas_equalTo(self.emailLbl.mas_left);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(70);
    }];
    [self.jobText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.emailText.mas_bottom);
        make.left.mas_equalTo(self.emailLbl.mas_right);
        make.height.mas_equalTo(30);
        make.right.equalTo(self.view.mas_right).with.offset(-20);
    }];
    
    [self.addLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.jobLbl.mas_bottom);
        make.left.mas_equalTo(self.jobLbl.mas_left);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(70);
    }];
    [self.addText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.jobText.mas_bottom);
        make.left.mas_equalTo(self.jobLbl.mas_right);
        make.height.mas_equalTo(30);
        make.right.equalTo(self.view.mas_right).with.offset(-20);
    }];
    
    [self.codeLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.addLbl.mas_bottom);
        make.left.mas_equalTo(self.addLbl.mas_left);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(70);
    }];
    [self.codeText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.addText.mas_bottom);
        make.left.mas_equalTo(self.addLbl.mas_right);
        make.height.mas_equalTo(30);
        make.right.equalTo(self.view.mas_right).with.offset(-20);
    }];
    
}


- (void)showAddressPickView
{
    AddressPickView *addressPickView = [AddressPickView shareInstance];
    [self.view addSubview:addressPickView];
    addressPickView.block = ^(NSString *province,NSString *city,NSString *town){
        _proviceLabel.text = [NSString stringWithFormat:@"%@ %@ %@",province,city,town] ;
        
    };
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [self.nameText resignFirstResponder];
    [self.proviceLabel resignFirstResponder];
    [self.emailText resignFirstResponder];
    [self.jobText resignFirstResponder];
    [self.addText resignFirstResponder];
    [self.codeText resignFirstResponder];
    
}


-(void)mterialClickright{
    
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle: @"真实姓名必须是五个汉字之内的，不能含有其它字符。"
                                                                              message: @""
                                                                       preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
