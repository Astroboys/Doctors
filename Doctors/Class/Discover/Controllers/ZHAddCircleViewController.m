
//
//  ZHAddCircleViewController.m
//  Doctors
//
//  Created by 崔敬轩 on 16/9/25.
//  Copyright © 2016年 XueHuiWang. All rights reserved.
//

#import "ZHAddCircleViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>

@interface ZHAddCircleViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property(nonatomic,strong)UIButton*addBtn;

@property(nonatomic,strong)UITextField*circleName;

@property(nonatomic,strong)UIView*LineView;

@property(nonatomic,strong)UITextField*circleIntroduce;

@property(nonatomic,strong)UIView*LineView2;

@property(nonatomic,strong)UIButton*createBtn;

@property(nonatomic,strong)UIImagePickerController *imagePickerController;

@end

@implementation ZHAddCircleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    
    UIImage* image1 = [UIImage imageNamed:@"navigationbar_back_withtext"];
    image1 = [image1 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    self.navigationItem.title=@"添加健康圈";
    
    UIBarButtonItem* leftItem = [[UIBarButtonItem alloc]initWithImage:image1 style:UIBarButtonItemStylePlain target:self action:@selector(addCircleClickLeft)];

    self.navigationItem.leftBarButtonItem=leftItem;

    [self setupUI];
    [self setupFrame];
    
    
}
-(void)addCircleClickLeft{

    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)setupUI{
    
    _addBtn=[[UIButton alloc]init];
    [_addBtn setImage:[UIImage imageNamed:@"添加头像"] forState:UIControlStateNormal];
    [_addBtn addTarget:self action:@selector(touchbtn1) forControlEvents:UIControlEventTouchUpInside];
    _addBtn.adjustsImageWhenHighlighted=NO;
     [self.view addSubview:_addBtn];
    
    _circleName=[[UITextField alloc]init];
    [self.view addSubview:_circleName];
    _circleName.placeholder=@"请填写健康圈名称(2-10个字)";
    
    _LineView=[[UIView alloc]init];
    _LineView.backgroundColor=[UIColor lightGrayColor];
    [self.view addSubview:_LineView];
    
    
    _circleIntroduce=[[UITextField alloc]init];
    [self.view addSubview:_circleIntroduce];
    _circleIntroduce.placeholder=@"请填写健康圈简介(2-50个字)";
    
    _LineView2=[[UIView alloc]init];
     _LineView2.backgroundColor=[UIColor lightGrayColor];
    [self.view addSubview:_LineView2];
    
    _createBtn=[[UIButton alloc]init];
    _createBtn.backgroundColor=DWColor(40, 128, 194);
    [_createBtn setTitle:@"创建" forState:UIControlStateNormal];
    [_createBtn.layer setCornerRadius:5];
    _createBtn.clipsToBounds=YES;
    [self.view addSubview:_createBtn];
    
    _imagePickerController = [[UIImagePickerController alloc] init];
    _imagePickerController.delegate = self;
    _imagePickerController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    _imagePickerController.allowsEditing = YES;
    
}

-(void)setupFrame{
    
    [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(50);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.height.mas_equalTo(80);
        make.width.mas_equalTo(80);
    }];
    
    [self.circleName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.addBtn.mas_bottom).with.offset(80);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.height.mas_equalTo(40);
        make.right.mas_equalTo(self.view.mas_right).with.offset(-50);
        make.left.mas_equalTo(self.view.mas_left).with.offset(50);
    }];
    
    [self.LineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.circleName.mas_bottom).with.offset(5);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.height.mas_equalTo(1);
        make.right.mas_equalTo(self.view.mas_right).with.offset(-50);
        make.left.mas_equalTo(self.view.mas_left).with.offset(50);
    }];
    
    [self.circleIntroduce mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.LineView.mas_bottom).with.offset(20);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.height.mas_equalTo(40);
        make.right.mas_equalTo(self.view.mas_right).with.offset(-50);
        make.left.mas_equalTo(self.view.mas_left).with.offset(50);
    }];
    
    [self.LineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.circleIntroduce.mas_bottom).with.offset(5);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.height.mas_equalTo(1);
        make.right.mas_equalTo(self.view.mas_right).with.offset(-50);
        make.left.mas_equalTo(self.view.mas_left).with.offset(50);
    }];
    
    [self.createBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.LineView2.mas_bottom).with.offset(20);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.height.mas_equalTo(40);
        make.right.mas_equalTo(self.view.mas_right).with.offset(-30);
        make.left.mas_equalTo(self.view.mas_left).with.offset(30);
    }];
    
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
    _imagePickerController.navigationItem.leftBarButtonItem.tintColor=[UIColor whiteColor];
    _imagePickerController.navigationItem.rightBarButtonItem.tintColor=[UIColor whiteColor];
    
    [self presentViewController:_imagePickerController animated:YES completion:nil];
}


- (void)selectImageFromAlbum
{
    //NSLog(@"相册");
    _imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:_imagePickerController animated:YES completion:nil];
}


-(void)touchbtn1{
    
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle: nil                                                                             message: nil                                                                       preferredStyle:UIAlertControllerStyleActionSheet];
    //添加Button
    [alertController addAction: [UIAlertAction actionWithTitle: @"拍照" style: UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        //处理点击拍照
        
        [self selectImageFromCamera];
    }]];
    [alertController addAction: [UIAlertAction actionWithTitle: @"从相册选取" style: UIAlertActionStyleDefault handler:^(UIAlertAction *action){
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
