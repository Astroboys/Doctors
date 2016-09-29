//
//  ZHFeedbackViewController.m
//  Doctors
//
//  Created by 崔敬轩 on 16/9/29.
//  Copyright © 2016年 XueHuiWang. All rights reserved.
//

#import "ZHFeedbackViewController.h"
#import "Masonry.h"
#import "ZHVerifyCodeButton.h"
#import "NetWorkingManager.h"
#import "MethodUtil.h"

@interface ZHFeedbackViewController()

@property(nonatomic,strong)UITextView*feedbackView;
@property(nonatomic,strong)UITextField*phoneText;
@property(nonatomic,strong)UIButton*feedbackBtn;
@end

@implementation ZHFeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=DWColor(245, 245, 245);
    
    self.title = @"意见反馈";
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
    
    [self.feedbackView resignFirstResponder];
    [self.phoneText resignFirstResponder];
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)setupUI{

    _feedbackView=[[UITextView alloc]init];
    [self.view addSubview:_feedbackView];
    
    _phoneText=[[UITextField alloc]init];
    _phoneText.backgroundColor=[UIColor whiteColor];
    _phoneText.placeholder=@"点击输入您的联系方式（必填）";

    [self.view addSubview:_phoneText];
    
    _feedbackBtn=[[UIButton alloc]init];
    [_feedbackBtn setTitle:@"发送" forState:UIControlStateNormal];
    [_feedbackBtn setTintColor:[UIColor whiteColor]];
    _feedbackBtn.backgroundColor=DWColor(80, 198, 238);
    _feedbackBtn.clipsToBounds=YES;
    [_feedbackBtn.layer setCornerRadius:5];
    [self.view addSubview:_feedbackBtn];

}

-(void)setupFrame{
    
    [self.feedbackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.left.mas_equalTo(self.view.mas_left);
        make.height.mas_equalTo(kHeight/3);
        make.right.equalTo(self.view.mas_right);
    }];
    
    [self.phoneText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.feedbackView.mas_bottom).with.offset(10);
        make.left.mas_equalTo(self.view.mas_left);
        make.height.mas_equalTo(40);
        make.right.equalTo(self.view.mas_right);
    }];

    [self.feedbackBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.phoneText.mas_bottom).with.offset(80);
        make.left.mas_equalTo(self.view.mas_left).with.offset(30);
        make.height.mas_equalTo(35);
        make.right.equalTo(self.view.mas_right).with.offset(-30);
    }];

}



@end
