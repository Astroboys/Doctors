//
//  WelcomeViewController.m
//  familyTest
//
//  Created by jinbangtiming on 15/1/28.
//  Copyright (c) 2015年 huangxiaoya. All rights reserved.
//

#import "WelcomeViewController.h"
#import "AppDelegate.h"
#import "UConfig.h"
@interface WelcomeViewController ()
{
    UIButton * button;
}
@end

@implementation WelcomeViewController
//禁止横屏
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(BOOL)shouldAutorotate
{
    return NO;
}

-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    _scrollView.contentSize = CGSizeMake(self.view.bounds.size.width*4,self.view.bounds.size.height );
    _scrollView.showsHorizontalScrollIndicator =NO;
    _scrollView.pagingEnabled =YES;
    _scrollView.bounces =NO;
    [self.view addSubview:_scrollView];
    
    for (int i=0;i<4;i++)
        
    {
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i*self.view.bounds.size.width, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
        imageView.clipsToBounds=YES;
        imageView.contentMode=UIViewContentModeScaleAspectFill;
        UIImage * img = [UIImage imageNamed:[NSString stringWithFormat:@"Guide%d",i+1]];
        imageView.image = img;
        [_scrollView addSubview:imageView];
        
    }
    
    button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(20+self.view.bounds.size.width*3, self.view.bounds.size.height-200, self.view.bounds.size.width-40,100);
    
    //圆弧半径
    
    button.layer.cornerRadius = 8.0f;
    [button.layer setMasksToBounds:YES];
    [button addTarget:self action:@selector(enter) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:button];
    
}
-(void)enter
{
    [UConfig setWelcome:YES];
   AppDelegate*app=(AppDelegate*)[UIApplication sharedApplication].delegate;
    [app showMainVC];
    
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
