//
//  LookPdfViewController.m
//  Doctors
//
//  Created by zhonghe on 16/10/4.
//  Copyright © 2016年 XueHuiWang. All rights reserved.
//

#import "LookPdfViewController.h"
#import "NetWorkingManager.h"
@interface LookPdfViewController ()<UIWebViewDelegate>

@end

@implementation LookPdfViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"PDF";
    self.view.backgroundColor = DWColor(243, 243, 243);
    UIWebView *web = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight-64)];
    web.scalesPageToFit = YES;
    web.dataDetectorTypes = UIDataDetectorTypeAll; //设置检测网页中的格式类型，all表示检测所有类型包括超链接、电话号码、地址等。
    web.scrollView.contentInset = UIEdgeInsetsMake(50, 0, 0, 0);
    [self.view addSubview:web];

    /*D*其它知识点-加载本地资源**/
    NSURL *url = [NSURL URLWithString:self.urlStr];//[[NSBundle mainBundle] URLForResource:@"text.html" withExtension:nil];
    [web loadRequest:[NSURLRequest requestWithURL:url]];
    // Do any additional setup after loading the view.
}

//每当将加载请求的时候调用该方法，返回YES 表示加载该请求，返回NO 表示不加载该请求
//可以在该方法中拦截请求
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return ![request.URL.absoluteString containsString:@"dushu"];
}

//开始加载网页，不仅监听我们指定的请求，还会监听内部发送的请求
-(void)webViewDidStartLoad:(UIWebView *)webView
{
    [YJProgressHUD showProgress:@"加载中..." inView:self.view];

    NSLog(@"开始加载");
}

//网页加载完毕之后会调用该方法
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [YJProgressHUD hide];

    NSLog(@"加载完成");
}

//网页加载失败调用该方法
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [YJProgressHUD showSuccess:@"加载失败" inview:self.view];

    NSLog(@"加载失败%@",error);
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
