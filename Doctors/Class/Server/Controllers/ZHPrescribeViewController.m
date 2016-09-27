//
//  ZHPrescribeViewController.m
//  Doctors
//
//  Created by 崔敬轩 on 16/9/26.
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

@property(nonatomic,strong)UILabel*contentName;
@property(nonatomic,strong)UILabel*contentSex;
@property(nonatomic,strong)UILabel*contentOffice;
@property(nonatomic,strong)UILabel*contentTime;


@end

@implementation ZHPrescribeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
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
    [self.view addSubview:_infoView];
    
    _customerName=[[UILabel alloc]init];
    [self.view addSubview:_customerName];
    
    _contentSex=[[UILabel alloc]init];
    [self.view addSubview:_contentSex];
    
    _contentOffice=[[UILabel alloc]init];
    [self.view addSubview:_contentOffice];
    
    _contentTime=[[UILabel alloc]init];
    [self.view addSubview:_contentTime];
    
}

-(void)setupFrame{
    
    [self.infoView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.view.mas_top).with.offset(32);
        make.left.mas_equalTo(self.view.mas_left).with.offset(30);
        make.height.mas_equalTo(60);
        make.width.mas_equalTo(60);
        
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
