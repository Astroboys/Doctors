//
//  YCLeftViewController.m
//  YCW
//
//  Created by apple on 15/12/17.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "YCLeftViewController.h"
#import "ZHMterialViewController.h"
#import "ZHHeaderViewController.h"
#import "ZHFeedbackViewController.h"
#import "ZHAboutViewController.h"
#import "ZHPasswordViewController.h"
#import "ZHNavViewController.h"
#import "ZHLoginViewController.h"
#import "UIViewController+MMDrawerController.h"
#import "UIImage+Extension.h"
#import "Doctors-Prefix.pch"
#import "ZHTabViewController.h"


static NSString * const kYCLeftViewControllerCellReuseId = @"kYCLeftViewControllerCellReuseId";

@interface YCLeftViewController ()<UITableViewDataSource, UITableViewDelegate,UINavigationControllerDelegate>

@property (nonatomic, strong) NSArray *lefs;
@property (nonatomic, assign) NSInteger previousRow;
@property(nonatomic,strong)UIView*totalView;
@property(nonatomic,strong)UIView*messagesView;
@property(nonatomic,strong)UIButton*loginout;
@property(nonatomic,strong)UIImageView*imageView;
@property(nonatomic,strong)UILabel*telLabel;
@property(nonatomic,strong)UILabel*idNum;

@property (nonatomic, weak) UIImageView *coverImageView;
@property(nonatomic,strong)NSArray*lefsImageArr;

@end

@implementation YCLeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationController.delegate=self;
    
    
    _totalView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    self.totalView.backgroundColor
    =[UIColor colorWithRed:40/255.0 green:128/255.0 blue:194/255.0 alpha:1];

    UILabel*doctortext=[[UILabel alloc]initWithFrame:CGRectMake((kLeftSize-30)/2, 20, 100, 30)];
    doctortext.text =@"医生账户";
    doctortext.backgroundColor=[UIColor colorWithRed:40/255.0 green:128/255.0 blue:194/255.0 alpha:1];
    doctortext.textColor=[UIColor whiteColor];
    [doctortext setFont:[UIFont systemFontOfSize:16]];
    [self.totalView addSubview:doctortext];
    [self.view addSubview:self.totalView];
    
    _messagesView=[[UIView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 80)];
    self.messagesView.backgroundColor=[UIColor whiteColor];
    //头像按钮
    _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 10, 60, 60)];
    _imageView.image=[UIImage imageNamed:@"mineIcon"];
    [_imageView.layer setMasksToBounds:YES];
    [_imageView.layer setCornerRadius:30.0];
    //[_imageView addTarget:self action:@selector(clickLig) forControlEvents:UIControlEventTouchUpInside];
    [self.messagesView addSubview:self.imageView];
    
    //电话
    _telLabel =[[UILabel alloc]initWithFrame:CGRectMake(70, 15, 130, 20)];
    [_telLabel setFont:[UIFont systemFontOfSize:14]];
    _telLabel.text =@"13193203294";
    [self.messagesView addSubview:self.telLabel];
    
    UILabel*myid = [[UILabel alloc]initWithFrame:CGRectMake(70, 45, 40, 20)];
    [myid setFont:[UIFont systemFontOfSize:14]];
    myid.text =@"ID号:";
    [self.messagesView addSubview:myid];
    
    _idNum =[[UILabel alloc]initWithFrame:CGRectMake(110, 45, 130, 20)];
    [_idNum setFont:[UIFont systemFontOfSize:14]];
    [_idNum setTextAlignment:NSTextAlignmentLeft];
    _idNum.text =@"11034";
    [self.messagesView addSubview:self.idNum];

    [self.view addSubview:self.messagesView];
    
    _loginout = [[UIButton alloc]initWithFrame:CGRectMake((kLeftSize-150)/2, self.view.frame.size.height-60, 150, 40)];
    
    _loginout.backgroundColor =[UIColor colorWithRed:40/255.0 green:128/255.0 blue:194/255.0 alpha:1];
    
    _loginout.titleLabel.font = [UIFont systemFontOfSize: 14.0];
    
    [_loginout setTitle:@"退出登录" forState:UIControlStateNormal];
    
    [_loginout addTarget:self action:@selector(clickLig) forControlEvents:UIControlEventTouchUpInside];
    
    [_loginout setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
    [_loginout.layer setMasksToBounds:YES];
    [_loginout.layer setCornerRadius:5.0];
    
    [self.view addSubview:self.loginout];
   
    
    _lefs = @[@"基本资料", @"修改头像", @"修改密码", @"服务订单",@"我的咨询记录",@"意见反馈",@"关于"];
    _lefsImageArr= @[@"basicMaterial", @"changeIcon", @"changePassword",  @"serviceOrder", @"consult", @"changeEmail",@"aboutImg"];
    _tableView = [[UITableView alloc] init];
    _tableView.frame = CGRectMake(0, 144, self.view.frame.size.width, self.view.frame.size.height - 144-70);
    _tableView.dataSource = self;
    _tableView.delegate = self;
    
    self.tableView.scrollEnabled = NO;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kYCLeftViewControllerCellReuseId];
    //self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];

    self.tableView.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:self.tableView];
}

//设置状态栏
- (BOOL)prefersStatusBarHidden
{
    return NO;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.lefs.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kYCLeftViewControllerCellReuseId forIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kYCLeftViewControllerCellReuseId];
    }
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = self.lefs[indexPath.row];
    cell.textLabel.highlightedTextColor = [UIColor grayColor];
    cell.selectedBackgroundView = [[UIView alloc] init];
    cell.backgroundColor = [UIColor clearColor];
    cell.imageView.image =[UIImage imageNamed:self.lefsImageArr[indexPath.row]];
    return cell;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self settingDrawerWhenPop];
}

#pragma mark - Private

/// 添加当前页面的截屏
- (void)addCurrentPageScreenshot {
    
    UIImage *screenImage = [UIImage screenshot];
    UIImageView *imgView = [[UIImageView alloc] initWithImage:screenImage];
    imgView.image = screenImage;
    [self.view addSubview:imgView];
    self.coverImageView = imgView;
    
}

/// 设置抽屉视图pop后的状态
- (void)settingDrawerWhenPop {
    
    self.mm_drawerController.maximumLeftDrawerWidth = [UIScreen mainScreen].bounds.size.width - 80;
    self.mm_drawerController.showsShadow = YES;
    self.mm_drawerController.closeDrawerGestureModeMask = MMCloseDrawerGestureModeAll;
    [self.coverImageView removeFromSuperview];
    self.coverImageView = nil;
}

/// 设置抽屉视图push后的状态
- (void)settingDrawerWhenPush {
    
    [self.mm_drawerController setMaximumLeftDrawerWidth:[UIScreen mainScreen].bounds.size.width];
    self.mm_drawerController.showsShadow = NO;
    // 这里一定要关闭手势，否则隐藏在屏幕右侧的drawer可以被拖拽出来
    self.mm_drawerController.closeDrawerGestureModeMask = MMCloseDrawerGestureModeNone;
    
}

#pragma mark - UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if ([viewController isKindOfClass:[YCLeftViewController class]]) {
        [navigationController setNavigationBarHidden:YES animated:YES];
    } else {
        [navigationController setNavigationBarHidden:NO animated:YES];
    }
    
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.row == 0) {
        ZHMterialViewController*mterial = [[ZHMterialViewController alloc ] init];
        [self addCurrentPageScreenshot];
        [self settingDrawerWhenPush];
        //ZHTabViewController*tabVc=[[ZHTabViewController alloc]init];
        [self.navigationController pushViewController:mterial animated:YES];
        
    }else if(indexPath.row == 1){
        
        
        ZHHeaderViewController *header = [[ZHHeaderViewController alloc ] init];
        [self addCurrentPageScreenshot];
        [self settingDrawerWhenPush];
        [self.navigationController pushViewController:header animated:YES];
        
    }else if(indexPath.row == 2){
        
        ZHPasswordViewController *password = [[ZHPasswordViewController alloc ] init];
        [self addCurrentPageScreenshot];
        [self settingDrawerWhenPush];
        [self.navigationController pushViewController:password animated:YES];
        
    }else if(indexPath.row == 5){
        
        ZHFeedbackViewController *email = [[ZHFeedbackViewController alloc ] init];
        [self addCurrentPageScreenshot];
        [self settingDrawerWhenPush];
        [self.navigationController pushViewController:email animated:YES];

        
    }else if(indexPath.row == 6){
        
        ZHAboutViewController *about = [[ZHAboutViewController alloc ] init];
        [self addCurrentPageScreenshot];
        [self settingDrawerWhenPush];
        [self.navigationController pushViewController:about animated:YES];

        
        
    }else{
        
        UIAlertController * alertController = [UIAlertController alertControllerWithTitle: @"请完成资质认证后再做操作"
                                                                                  message: @""
                                                                           preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
        }]];
        
        [self presentViewController:alertController animated:YES completion:nil];
    
    }
    
//    [self.sideMenuViewController setContentViewController:center animated:YES];
    //[self.sideMenuViewController hideMenuViewController];
    
    self.previousRow = indexPath.row;

}

-(void)clickLig{
    
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle: @"您确定要退出吗"
                                                                              message: @""
                                                                       preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"退出" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        ZHLoginViewController*loginVc=[[ZHLoginViewController alloc]init];
        
        ZHNavViewController*nav=[[ZHNavViewController alloc]initWithRootViewController:loginVc];
        
        [nav setModalTransitionStyle: UIModalTransitionStyleCrossDissolve];

        [self presentViewController:nav animated:YES completion:nil];
        
        [self removeFromParentViewController];

        //[self.sideMenuViewController removeFromParentViewController];
        
//        ZHPhoneViewController *about = [[ZHPhoneViewController alloc ] init];
//        [about setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
//        [self presentViewController:about animated:YES completion:nil];
        
        
    }]];


    [self presentViewController:alertController animated:YES completion:nil];
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (isiPhone6P) {
        
        return 60;
        
    }else if (isiPhone6){
        
        return 50;
        
    }else if (isiPhone5){
        
        return 40;
        
    }else{
        
        return 35;
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
