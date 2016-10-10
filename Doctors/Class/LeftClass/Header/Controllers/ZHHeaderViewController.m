//
//  ZHHeaderViewController.m
//  YCSideslip
//
//  Created by 崔敬轩 on 16/8/20.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ZHHeaderViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "UIImageView+WebCache.h"
#import "NIMWebImageManager.h"
#import "UIImage+NTES.h"
@interface ZHHeaderViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{

    NSString *urlStr;
    NSString*openStr;
    NSString *photoFilePath;
}

@property(nonatomic,strong)UIImagePickerController *imagePickerController;

@end

@implementation ZHHeaderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    openStr=[UConfig getPhotoUrl];
   
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:19],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
   self.view.backgroundColor=DWColor(245, 245, 245);
    self.title = @"修改头像";
    
    UIImage* image1 = [UIImage imageNamed:@"navigationbar_back_withtext"];
    // 告诉系统以后这张图片不进行默认的渲染
    image1 = [image1 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    // 创建活动的按钮
    UIBarButtonItem* item1 = [[UIBarButtonItem alloc]initWithImage:image1 style:UIBarButtonItemStylePlain target:self action:@selector(headerClickleft)];
    self.navigationItem.leftBarButtonItem = item1;
    
    _imagePickerController = [[UIImagePickerController alloc] init];
    _imagePickerController.delegate = self;
    _imagePickerController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    _imagePickerController.allowsEditing = YES;
    
    [self setupUI];
}

-(void)headerClickleft{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)selectImageFromCamera
{
    _imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    //录制视频时长，默认10s
    _imagePickerController.videoMaximumDuration = 15;
    
    //相机类型（拍照、录像...）字符串需要做相应的类型转换
    _imagePickerController.mediaTypes = @[(NSString *)kUTTypeMovie,(NSString *)kUTTypeImage];
    
    //视频上传质量
    //UIImagePickerControllerQualityTypeHigh高清
    //UIImagePickerControllerQualityTypeMedium中等质量
    //UIImagePickerControllerQualityTypeLow低质量
    //UIImagePickerControllerQualityType640x480
    _imagePickerController.videoQuality = UIImagePickerControllerQualityTypeHigh;
    
    //设置摄像头模式（拍照，录制视频）为录像模式
    _imagePickerController.cameraCaptureMode = UIImagePickerControllerCameraCaptureModeVideo;
    [self presentViewController:_imagePickerController animated:YES completion:nil];
}


- (void)selectImageFromAlbum
{
    //NSLog(@"相册");
    _imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:_imagePickerController animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    
    //当选择的类型是图片
    if ([type isEqualToString:@"public.image"])
    {
        //先把图片转成NSData
        UIImage* image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        self.iconView.image = image;
        
        NSData *data;
        if (UIImagePNGRepresentation(image) == nil)
        {
            data = UIImageJPEGRepresentation(image, 1.0);
        }
        else
        {
            data = UIImagePNGRepresentation(image);
        }
        
        //图片保存的路径
        //这里将图片放在沙盒的documents文件夹中
        NSString * DocumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        
        //文件管理器
        NSFileManager *fileManager = [NSFileManager defaultManager];
        //把刚刚图片转换的data对象拷贝至沙盒中 并保存为image.png
        [fileManager createDirectoryAtPath:DocumentsPath withIntermediateDirectories:YES attributes:nil error:nil];
        [fileManager createFileAtPath:[DocumentsPath stringByAppendingString:@"/doctorPhoto.png"] contents:data attributes:nil];
        
        //得到选择后沙盒中图片的完整路径
        NSString *filePath = [[NSString alloc]initWithFormat:@"%@%@",DocumentsPath,  @"/doctorPhoto.png"];
        photoFilePath = filePath;
        NSURL *url = [NSURL fileURLWithPath: filePath];
        urlStr = [url absoluteString];
        
//        [UConfig setPhotoUrl:urlStr];
        
    }
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}


-(void)setupUI{

    _iconView=[[UIImageView alloc]initWithFrame:CGRectMake((kWidth-100)*0.5, 40, 100, 100)];
    [_iconView.layer setCornerRadius:50];
    [_iconView.layer setMasksToBounds:YES];
    [_iconView sd_setImageWithURL:[NSURL URLWithString:openStr] placeholderImage:[UIImage imageNamed:@"changeIcons"]];

    UIButton*iconBtn=[[UIButton alloc]initWithFrame:CGRectMake((kWidth-100)*0.5, 40, 100, 100)];
    iconBtn.backgroundColor=[UIColor clearColor];
    [iconBtn.layer setCornerRadius:50];
    [iconBtn.layer setMasksToBounds:YES];
    [self.view  addSubview:_iconView];
    [self.view addSubview:iconBtn];
    
    UIButton*tixingBtn=[[UIButton alloc]initWithFrame:CGRectMake(30, 200, kWidth-60, 35)];
    
    tixingBtn.backgroundColor=[UIColor colorWithRed:100/255.0 green:178/255.0 blue:241/255.0 alpha:1] ;
    [tixingBtn setTitle:@"修改头像" forState:UIControlStateNormal];
    [tixingBtn.layer setCornerRadius:5];
    [tixingBtn.layer setMasksToBounds:YES];
    [self.view addSubview:tixingBtn];

    [iconBtn addTarget:self action:@selector(touchbtn1) forControlEvents:UIControlEventTouchUpInside];
    
    [tixingBtn addTarget:self action:@selector(touchbtn2) forControlEvents:UIControlEventTouchUpInside];
}


-(void)touchbtn2{
    if (photoFilePath.length<1) {
        UIAlertController * alertController = [UIAlertController alertControllerWithTitle: @"请您点击头像选择图片"
                                                                                  message: @""
                                                                           preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
        }]];
        [self presentViewController:alertController animated:YES completion:nil];
        return;
    }
    __weak typeof(self) wself = self;
    
    
    
    [YJProgressHUD showProgress:@"加载中..." inView:self.view];
    NSDictionary *dic = @{@"id":[UConfig getDoctorId]};
    NSArray *imageArray = @[_iconView.image];
    [NetWorkingManager sendPOSTImageWithPath:[NSString stringWithFormat:@"%@%@",BaseUrl,@"app/doct/edit"] withParamters:dic withImageArray:imageArray withtargetWidth:200 withProgress:^(float progress) {
        
    } success:^(BOOL isSuccess, id responseObject) {
        NSString *code = responseObject[@"code"];
        [YJProgressHUD hide];
        if (code.intValue == 200) {
            [YJProgressHUD showSuccess:@"头像设置成功" inview:self.view];
            NSDictionary *dic = responseObject[@"data"];
            NSString *urlString = dic[@"photo"];
            [_iconView sd_setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:[UIImage imageNamed:@"changeIcons"]];
            [UConfig setPhotoUrl:urlString];
            //创建通知
            NSNotification *notification =[NSNotification notificationWithName:@"updatePhoto" object:nil userInfo:nil];
            //通过通知中心发送通知
            [[NSNotificationCenter defaultCenter] postNotification:notification];

            
            
        }else{
            [YJProgressHUD showSuccess:@"头像设置失败" inview:self.view];
        }
        
    } failure:^(NSError *error) {
        [YJProgressHUD hide];
        [YJProgressHUD showSuccess:@"头像设置失败,请检查网络设置" inview:self.view];
    }];
    
    //上传到云信
    NSInteger status = [UConfig getVerifyStatus];
    UIImage *imageForAvatarUpload = [_iconView.image imageForAvatarUpload];

    if (status == 200) {
        [[NIMSDK sharedSDK].resourceManager upload:photoFilePath progress:nil completion:^(NSString *urlString, NSError *error) {
            if (!error && wself) {
                [[NIMSDK sharedSDK].userManager updateMyUserInfo:@{@(NIMUserInfoUpdateTagAvatar):urlString} completion:^(NSError *error) {
                    if (!error) {
                        [[NIMWebImageManager sharedManager] saveImageToCache:imageForAvatarUpload forURL:[NSURL URLWithString:urlString]];
                      
                    }else{
                        
                    }
                }];
            }else{
            }
        }];

    }
    
    
    
    
    
}



-(void)touchbtn1{
    
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle: nil                                                                             message: nil                                                                       preferredStyle:UIAlertControllerStyleActionSheet];
    //添加Button
    [alertController addAction: [UIAlertAction actionWithTitle: @"拍照" style: UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        //处理点击拍照
        
        [self selectImageFromCamera];
    }]];
    [alertController addAction: [UIAlertAction actionWithTitle: @"相册选取" style: UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        //处理点击从相册选取
        
        [self selectImageFromAlbum];
    }]];
    [alertController addAction: [UIAlertAction actionWithTitle: @"取消" style: UIAlertActionStyleCancel handler:nil]];
    
    [self presentViewController: alertController animated: YES completion: nil];


}
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    UIImage* image1 = [UIImage imageNamed:@"navigationbar_back_withtext"];
    image1 = [image1 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIBarButtonItem* leftItem = [[UIBarButtonItem alloc]initWithImage:image1 style:UIBarButtonItemStylePlain target:self action:@selector(addCirclepop)];
    viewController.navigationItem.leftBarButtonItem=leftItem;
    viewController.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
}

-(void)addCirclepop{
    
    [self dismissViewControllerAnimated:YES completion:nil];
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
