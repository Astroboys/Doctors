//
//  ZHNavViewController.m
//  Doctors
//
//  Created by 崔敬轩 on 16/8/18.
//  Copyright © 2016年 崔敬轩. All rights reserved.
//

#import "ZHNavViewController.h"

@interface ZHNavViewController ()

@end

@implementation ZHNavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationBar.backgroundColor = [UIColor colorWithRed:40/255.0 green:128/255.0 blue:194/255.0 alpha:1];
    
    [self.navigationBar setBackgroundImage:[self imageWithColor:DWColor(40, 128, 194)]forBarMetrics:UIBarMetricsDefault];
    
//    =[[UINavigationBar appearance] setBackgroundImage:[self imageWithColor:DWColor(59, 165, 249)] forBarMetrics:UIBarMetricsDefault];
    
        }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIImage *)imageWithColor:(UIColor *)color
{
    NSParameterAssert(color != nil);
    
    CGRect rect = CGRectMake(0, 0, 1, 1);
    // Create a 1 by 1 pixel context
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    [color setFill];
    UIRectFill(rect);   // Fill it with your color
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) { // 如果现在push的不是栈底控制器
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    [super pushViewController:viewController animated:animated];
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    
    
    UIViewController *popVC = [super popViewControllerAnimated:animated];
    
    return popVC;
    
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
