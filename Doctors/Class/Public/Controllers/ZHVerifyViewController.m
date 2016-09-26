//
//  ZHVerifyViewController.m
//  Doctors
//
//  Created by 崔敬轩 on 16/9/23.
//  Copyright © 2016年 XueHuiWang. All rights reserved.
//

#import "ZHVerifyViewController.h"
#import "Masonry.h"

@interface ZHVerifyViewController ()

@property(nonatomic,strong)UIView*coverView;
@property(nonatomic,strong)UILabel*masLbl;

@end

@implementation ZHVerifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor redColor];
    
    [self setupUI];
    [self setupFrame];
    
}

-(void)setupUI{

    _coverView=[[UIView alloc]init];
    [self.view addSubview:_coverView];
    
    _masLbl=[[UILabel alloc]init];
    [self.view addSubview:_masLbl];

}

-(void)setupFrame{

    [self.coverView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(15);
        make.left.mas_equalTo(self.view.mas_left).with.offset(15);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(15);
    }];
    
    [self.masLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(15);
        make.left.mas_equalTo(self.view.mas_left).with.offset(15);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(15);
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
