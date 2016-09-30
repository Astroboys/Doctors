//
//  ZHMterialViewController.m
//  YCSideslip
//
//  Created by 崔敬轩 on 16/8/20.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ZHMterialViewController.h"
#import "Masonry.h"
#import "NetWorkingManager.h"
#import "UConfig.h"

@interface ZHMterialViewController ()

@property(nonatomic,strong)UIScrollView*mterScroView;

@property(nonatomic,strong)UILabel*nameLbl;
@property(nonatomic,strong)UITextField*nameText;

@property(nonatomic,strong)UILabel*nichengLbl;
@property(nonatomic,strong)UILabel*nichengText;
//性别
@property(nonatomic,strong)UILabel*sexLbl;
@property(nonatomic,strong)UISegmentedControl*sexSeg;

@property(nonatomic,strong)UILabel*birLbl;
@property(nonatomic,strong)UILabel*birText;

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

@property(nonatomic,strong)NSDictionary*merdict;

@end

@implementation ZHMterialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   self.view.backgroundColor=DWColor(245, 245, 245);

   _merdict=[UConfig getPersonInfo];
    NSLog(@"%111111111111@",_merdict);

    if (_merdict!=nil) {
        
        _nameText.text=self.merdict[@"name"];
        NSLog(@"%@",self.nameText.text);
        self.phoneText.text=_merdict[@"mobile"];
        self.emailText.text=_merdict[@"email"];
        self.jobText.text=_merdict[@"job"];
        self.addText.text=_merdict[@"code"];
        
    }
    NSLog(@"%@",_merdict);
        self.title = @"基本资料";
        [self.navigationController.navigationBar setTitleTextAttributes:
         @{NSFontAttributeName:[UIFont systemFontOfSize:19],
           NSForegroundColorAttributeName:[UIColor whiteColor]}];
        
        UIImage* image1 = [UIImage imageNamed:@"navigationbar_back_withtext"];
        // 告诉系统以后这张图片不进行默认的渲染
        image1 = [image1 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        UIImage* image2 = [UIImage imageNamed:@"save"];
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
    [self.emailText resignFirstResponder];
    [self.jobText resignFirstResponder];
    [self.addText resignFirstResponder];
    [self.codeText resignFirstResponder];
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)setupUI{
    
    _mterScroView=[[UIScrollView alloc]init];
       //姓名
    _nameLbl=[[UILabel alloc]init];
    [_nameLbl setFont:[UIFont systemFontOfSize:16]];
    _nameLbl.text =@"真实姓名:";
    [_nameLbl setTextAlignment:NSTextAlignmentRight];

    _nameText=[[UITextField alloc]init];
    _nameText.placeholder =@"请输入您的真实姓名（五个汉字之内）";
    [_nameText setFont:[UIFont systemFontOfSize:16]];
    [self.mterScroView addSubview:_nameLbl];
    [self.mterScroView addSubview:_nameText];
    
    //昵称
    _nichengLbl=[[UILabel alloc]init];
    [_nichengLbl setFont:[UIFont systemFontOfSize:16]];
    _nichengLbl.text =@"昵称:";
    [_nichengLbl setTextAlignment:NSTextAlignmentLeft];
    _nichengText=[[UILabel alloc]init];
    [_nichengText setFont:[UIFont systemFontOfSize:16]];
    _nichengText.backgroundColor=DWColor(243, 243, 243);
    _nichengText.text=@"13532238947";
    [self.mterScroView addSubview:_nichengLbl];
    [self.mterScroView addSubview:_nichengText];
    
    //性别
    _sexLbl=[[UILabel alloc]init];
    _sexLbl.text =@"性别:";
    [_sexLbl setTextAlignment:NSTextAlignmentLeft];
    [_sexLbl setFont:[UIFont systemFontOfSize:16]];
    _sexSeg=[[UISegmentedControl alloc]initWithItems:@[@"男",@"女"]];
    _sexSeg.selectedSegmentIndex = 0;
    _sexSeg.tintColor = DWColor(70, 70, 70);
    [_sexSeg addTarget:self action:@selector(segmentedAction:) forControlEvents:UIControlEventValueChanged]; //添加事件
    [self.mterScroView addSubview:_sexSeg];


    [self.mterScroView addSubview:_sexLbl];
    [self.mterScroView addSubview:_sexSeg];
    
    //出生日期
    _birLbl=[[UILabel alloc]init];
    _birLbl.text =@"出生日期:";
    [_birLbl setTextAlignment:NSTextAlignmentRight];
    [_birLbl setFont:[UIFont systemFontOfSize:16]];
    
    _birText=[[UILabel alloc]init];
    _birText.text = @"1990-08-02";
    _birText.backgroundColor=DWColor(243, 243, 243);
    [_birText setFont:[UIFont systemFontOfSize:16]];
    [self.mterScroView addSubview:_birLbl];
    [self.mterScroView addSubview:_birText];
    
    //手机号
    _phoneLbl=[[UILabel alloc]init];
    _phoneLbl.text =@"手机号:";
    [_phoneLbl setTextAlignment:NSTextAlignmentRight];
    [_phoneLbl setFont:[UIFont systemFontOfSize:16]];
    _phoneText=[[UILabel alloc]init];
    _phoneText.text=@"13532238947";
    [_phoneText setFont:[UIFont systemFontOfSize:16]];
    
    [self.mterScroView addSubview:_phoneLbl];
    [self.mterScroView addSubview:_phoneText];
    //电子邮箱
    _emailLbl=[[UILabel alloc]init];
    _emailLbl.text =@"电子邮箱:";
    [_emailLbl setTextAlignment:NSTextAlignmentRight];
    [_emailLbl setFont:[UIFont systemFontOfSize:16]];

    _emailText=[[UITextField alloc]init];
    _emailText.placeholder =@"请输入您的电子邮箱";
    [_emailText setFont:[UIFont systemFontOfSize:16]];

    
    [self.mterScroView addSubview:_emailLbl];
    [self.mterScroView addSubview:_emailText];
    
    //工作单位
    _jobLbl=[[UILabel alloc]init];
    _jobLbl.text =@"工作单位:";
    [_jobLbl setTextAlignment:NSTextAlignmentRight];
    [_jobLbl setFont:[UIFont systemFontOfSize:16]];

    _jobText=[[UITextField alloc]init];
    [_jobText setFont:[UIFont systemFontOfSize:16]];
    _jobText.placeholder =@"请输入您的工作单位";
    [self.mterScroView addSubview:_jobLbl];
    [self.mterScroView addSubview:_jobText];
    
    //通信地址
    _addLbl=[[UILabel alloc]init];
    _addLbl.text =@"通信地址:";
    [_addLbl setTextAlignment:NSTextAlignmentRight];
    [_addLbl setFont:[UIFont systemFontOfSize:16]];
    
    _addText=[[UITextField alloc]init];
    [_addText setFont:[UIFont systemFontOfSize:16]];
    _addText.placeholder =@"请输入您的通信地址";
    [self.mterScroView addSubview:_addLbl];
    [self.mterScroView addSubview:_addText];
    
    //邮编
    _codeLbl=[[UILabel alloc]init];
    _codeLbl.text =@"邮编:";
    [_codeLbl setTextAlignment:NSTextAlignmentRight];
    [_codeLbl setFont:[UIFont systemFontOfSize:16]];
    _codeText=[[UITextField alloc]init];
    [_codeText setFont:[UIFont systemFontOfSize:16]];
    _codeText.placeholder =@"请输入您的邮编";
    [self.mterScroView addSubview:_codeLbl];
    [self.mterScroView addSubview:_codeText];
    
    [self.view addSubview:self.mterScroView];

}

-(void)setupFrame{
    
    [self.mterScroView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.left.mas_equalTo(self.view.mas_left).with.offset(5);
        make.right.mas_equalTo(self.view.mas_right).with.offset(-5);
        make.bottom.mas_equalTo(self.view.mas_bottom);
        
    }];
    
    [self.nameLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mterScroView.mas_top).with.offset(10);
        make.left.mas_equalTo(10);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(70);
    }];
    
    [self.nameText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mterScroView.mas_top).with.offset(10);
        make.left.mas_equalTo(self.nameLbl.mas_right);
        make.height.mas_equalTo(30);
        make.right.equalTo(self.view.mas_right).with.offset(-20);
    }];
    
    [self.nichengLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLbl.mas_bottom).with.offset(10);
        make.left.mas_equalTo(self.nameLbl.mas_left);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(70);
    }];
    [self.nichengText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameText.mas_bottom).with.offset(10);
        make.left.mas_equalTo(self.nameText.mas_left);
        make.height.mas_equalTo(30);
        make.right.equalTo(self.view.mas_right).with.offset(-20);
    }];
    
    [self.sexLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nichengLbl.mas_bottom).with.offset(10);
        make.left.mas_equalTo(self.nichengLbl.mas_left);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(70);
    }];
    [self.sexSeg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nichengText.mas_bottom).with.offset(10);
        make.left.mas_equalTo(self.nichengLbl.mas_right);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(100);
    }];
    
    [self.birLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.sexLbl.mas_bottom).with.offset(10);
        make.left.mas_equalTo(self.sexLbl.mas_left);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(70);
    }];
    [self.birText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.sexSeg.mas_bottom).with.offset(10);
        make.left.mas_equalTo(self.sexLbl.mas_right);
        make.height.mas_equalTo(30);
        make.right.equalTo(self.view.mas_right).with.offset(-20);
    }];
    
    [self.phoneLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.birText.mas_bottom).with.offset(10);
        make.left.mas_equalTo(10);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(70);
    }];
    
    [self.phoneText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.birText.mas_bottom).with.offset(10);
        make.left.mas_equalTo(self.phoneLbl.mas_right);
        make.height.mas_equalTo(30);
        make.right.equalTo(self.view.mas_right).with.offset(-20);
    }];
    
    [self.emailLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.phoneLbl.mas_bottom).with.offset(10);
        make.left.mas_equalTo(self.nameLbl.mas_left);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(70);
    }];
    [self.emailText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.phoneLbl.mas_bottom).with.offset(10);
        make.left.mas_equalTo(self.nameText.mas_left);
        make.height.mas_equalTo(30);
        make.right.equalTo(self.view.mas_right).with.offset(-20);
    }];
    
    [self.jobLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.emailLbl.mas_bottom).with.offset(10);
        make.left.mas_equalTo(self.emailLbl.mas_left);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(70);
    }];
    [self.jobText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.emailText.mas_bottom).with.offset(10);
        make.left.mas_equalTo(self.emailLbl.mas_right);
        make.height.mas_equalTo(30);
        make.right.equalTo(self.view.mas_right).with.offset(-20);
    }];
    
    [self.addLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.jobLbl.mas_bottom).with.offset(10);
        make.left.mas_equalTo(self.jobLbl.mas_left);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(70);
    }];
    [self.addText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.jobText.mas_bottom).with.offset(10);
        make.left.mas_equalTo(self.jobLbl.mas_right);
        make.height.mas_equalTo(30);
        make.right.equalTo(self.view.mas_right).with.offset(-20);
    }];
    
    [self.codeLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.addLbl.mas_bottom).with.offset(10);
        make.left.mas_equalTo(self.addLbl.mas_left);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(70);
    }];
    [self.codeText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.addText.mas_bottom).with.offset(10);
        make.left.mas_equalTo(self.addLbl.mas_right);
        make.height.mas_equalTo(30);
        make.right.equalTo(self.view.mas_right).with.offset(-20);
    }];
    [self.mterScroView.superview layoutIfNeeded];


    CGFloat scroH=CGRectGetMaxY(self.codeText.frame);
       NSLog(@"%f",scroH);
    
    _mterScroView.contentSize=CGSizeMake(kWidth, scroH*1.3);

}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [self.nameText resignFirstResponder];
    [self.emailText resignFirstResponder];
    [self.jobText resignFirstResponder];
    [self.addText resignFirstResponder];
    [self.codeText resignFirstResponder];

}

- (void) segmentedAction:(id)sender {
    if ([sender isKindOfClass:[UISegmentedControl class]]) {
        UISegmentedControl * segment = sender;
        if (segment.selectedSegmentIndex == 0) {
            self.view.backgroundColor = [UIColor redColor];
        }else if (segment.selectedSegmentIndex == 1) {
            self.view.backgroundColor = [UIColor brownColor];
        }
    }
}
-(void)mterialClickright{
    
    //点击保存 储存
    NSDictionary*meteDict= @{@"name":_nameText.text,@"sex":@"1",@"mobile":_phoneText.text,@"email":_emailText.text,@"job":_jobText.text,@"add":_addText.text,@"code":_codeText.text};
    [UConfig setPersonInfo:meteDict];
    
    
    NSDictionary *dic = @{@"name":_nameText.text,@"mobile":_nichengText.text,@"sex":@"1",@"mobile":_phoneText.text,@"email":_emailText.text};

    
    [NetWorkingManager requestGETDataWithPath:@"http://10.1.1.113:8080/newAngel/app/doct/index" withParamters:dic withProgress:nil success:^(BOOL isSuccess, id responseObject) {
        
    } failure:^(NSError *error) {
        
        
    }];

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
