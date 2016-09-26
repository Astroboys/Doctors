//
//  ZHTabViewController.m
//  Doctors
//
//  Created by 崔敬轩 on 16/8/18.
//  Copyright © 2016年 崔敬轩. All rights reserved.
//

#import "ZHTabViewController.h"
#import "ZHTabBar.h"
#import "ZHCustomerViewController.h"
#import "ZHServerViewController.h"
#import "ZHDiscoverViewController.h"
#import "ZHFirstViewController.h"
#import "ZHNavViewController.h"

@interface ZHTabViewController ()<UITabBarDelegate>

@end

@implementation ZHTabViewController

-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    // 设置 TabBarItemTestAttributes 的颜色。tabBarItem 的选中和不选中文字属性
    [self setUpTabBarItemTextAttributes];
    
    // 设置子控制器
    [self setUpChildViewController];
    
    // 处理tabBar，使用自定义 tabBar 添加 发布按钮
    [self setUpTabBar];
    
    [[UITabBar appearance] setBackgroundImage:[self imageWithColor:[UIColor whiteColor]]];
    
    UITabBar*tabs =[[UITabBar alloc]init];
    tabs.delegate=self;
    
    //去除 TabBar 自带的顶部阴影
    [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
    
    //设置导航控制器颜色为蓝色
    [[UINavigationBar appearance] setBackgroundImage:[self imageWithColor:DWColor(40,128, 194)] forBarMetrics:UIBarMetricsDefault];
}

#pragma mark -
#pragma mark - Private Methods

/**
 *  利用 KVC 把 系统的 tabBar 类型改为自定义类型。
 */
- (void)setUpTabBar{
    
    [self setValue:[[ZHTabBar alloc] init] forKey:@"tabBar"];
}


/**
 *  tabBarItem 的选中和不选中文字属性
 */
- (void)setUpTabBarItemTextAttributes{
    
    // 普通状态下的文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    // 选中状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    
    // 设置文字属性
    UITabBarItem *tabBar = [UITabBarItem appearance];
    [tabBar setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [tabBar setTitleTextAttributes:normalAttrs forState:UIControlStateHighlighted];
    
}


/**
 *  添加子控制器，我这里值添加了4个，没有占位自控制器
 */
- (void)setUpChildViewController{
    
    [self addOneChildViewController:[[ZHNavViewController alloc]initWithRootViewController:[[ZHFirstViewController alloc]init]]
                          WithTitle:@"首页"
                          imageName:@"tabbar_home"
                  selectedImageName:@"tabbar_home_selected"];
    
    [self addOneChildViewController:[[ZHNavViewController alloc]initWithRootViewController:[[ZHCustomerViewController alloc]init]]
                          WithTitle:@"客户"
                          imageName:@"tabbar_message_center"
                  selectedImageName:@"tabbar_message_center_selected"];
    
    
    [self addOneChildViewController:[[ZHNavViewController alloc]initWithRootViewController:[[ZHDiscoverViewController alloc] init]]
                          WithTitle:@"健康圈"
                          imageName:@"tabbar_discover"
                  selectedImageName:@"tabbar_discover_selected"];

    [self addOneChildViewController:[[ZHNavViewController alloc]initWithRootViewController:[[ZHServerViewController alloc] init]]
                          WithTitle:@"服务"
                          imageName:@"tabbar_profile"
                  selectedImageName:@"tabbar_profile_selected"];
    
}

/**
 *  添加一个子控制器
 *
 *  @param viewController    控制器
 *  @param title             标题
 *  @param imageName         图片
 *  @param selectedImageName 选中图片
 */

- (void)addOneChildViewController:(UIViewController *)viewController WithTitle:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName{
    
    //viewController.view.backgroundColor     = DWRandomColor;
    viewController.tabBarItem.title         = title;
    viewController.tabBarItem.image         = [UIImage imageNamed:imageName];
    UIImage *image = [UIImage imageNamed:selectedImageName];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    viewController.tabBarItem.selectedImage = image;
    [self addChildViewController:viewController];
    
    
}

//- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
//    
//    //UITabBarItem*items=item;
//    
//    if ([item.title isEqualToString:@"客户"]||[item.title isEqualToString:@"服务"]) {
//        
//        [self alerter];
//    }
//}
//
//-(void)alerter{
//    UIAlertController * alertController = [UIAlertController alertControllerWithTitle: @"请完成资质认证后再做操作"
//                                                                              message: @""
//                                                                       preferredStyle:UIAlertControllerStyleAlert];
//    [alertController addAction:[UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//        
//        
//    }]];
//    [self presentViewController:alertController animated:YES completion:nil];
//    
//}

//这个方法可以抽取到 UIImage 的分类中
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

@end
