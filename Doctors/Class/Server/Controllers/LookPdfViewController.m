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
    [self downloadPdf];
    self.view.backgroundColor = DWColor(243, 243, 243);
    UIWebView *web = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight-64)];
//    web.scalesPageToFit = YES;
//    web.dataDetectorTypes = UIDataDetectorTypeAll; //设置检测网页中的格式类型，all表示检测所有类型包括超链接、电话号码、地址等。
//    web.scrollView.contentInset = UIEdgeInsetsMake(50, 0, 0, 0);
//    
//    
//    
//    /*D*其它知识点-加载本地资源**/
//    NSURL *url = [[NSBundle mainBundle] URLForResource:@"text.html" withExtension:nil];
//    [web loadRequest:[NSURLRequest requestWithURL:url]];
    // Do any additional setup after loading the view.
}

-(void)downloadPdf
{
    //设置下载文件保存的目录
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString* _filePath = [paths objectAtIndex:0];
    
    //File Url
    NSString* fileUrl = self.urlStr;
    
    //Encode Url 如果Url 中含有空格，一定要先 Encode
    fileUrl = [fileUrl stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    
    //创建 Request
    NSString* fileName = @"down_form.pdf";
    NSString* filePath = [_filePath stringByAppendingPathComponent:fileName];
    
    dispatch_queue_t look = dispatch_queue_create("look", NULL);
    
    dispatch_async(look, ^{
        
        [NetWorkingManager requestDownLoadDataWithPath:fileUrl withParamters:nil withSavaPath:filePath withProgress:^(float progress) {
            NSLog(@"%f",progress);
        } success:^(BOOL isSuccess, id responseObject) {
            
        } failure:^(NSError *error) {
            
        }];
    });
    
    
//    //下载进行中的事件
//    AFURLConnectionOperation *operation =   [[AFHTTPRequestOperation alloc] initWithRequest:request];
//    operation.outputStream = [NSOutputStream outputStreamToFileAtPath:filePath append:NO];
//    
//    [operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
//        //下载的进度，如 0.53，就是 53%
//        float progress =   (float)totalBytesRead / totalBytesExpectedToRead;
//        
//        //下载完成
//        //该方法会在下载完成后立即执行
//        if (progress == 1.0) {
//            [downloadsTableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]  withRowAnimation:UITableViewRowAnimationAutomatic];
//        }
//    }];
//    
//    //下载完成的事件
//    //该方法会在下载完成后 延迟 2秒左右执行
//    //根据完成后需要处理的及时性不高，可以采用该方法
//    [operation setCompletionBlock:^{
//        
//    }];
//    
//    [operation start];
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
    
}

//网页加载完毕之后会调用该方法
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    
}

//网页加载失败调用该方法
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    
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
