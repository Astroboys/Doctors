
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
#import "Masonry.h"
#import "SVProgressHUD.h"
#import "NTESSessionViewController.h"
#import "UIView+Toast.h"
#import "UIImage+NIM.h"
#import "UIView+NIMKitToast.h"
@interface ZHAddCircleViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
    UIImage *teamImage;
    
}

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
    [_addBtn setImage:[UIImage imageNamed:@"addIcon"] forState:UIControlStateNormal];
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
    _createBtn.userInteractionEnabled = YES;
    [_createBtn addTarget:self action:@selector(createAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_createBtn];
    
    _imagePickerController = [[UIImagePickerController alloc] init];
    _imagePickerController.delegate = self;
    _imagePickerController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    _imagePickerController.allowsEditing = YES;
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [self.circleName resignFirstResponder];
    [self.circleIntroduce resignFirstResponder];
    
}

-(void)createAction
{
    __weak typeof(self) wself = self;

    NSString *currentUserId = [[NIMSDK sharedSDK].loginManager currentAccount];
    NSArray *members = @[currentUserId];
    NIMCreateTeamOption *option = [[NIMCreateTeamOption alloc] init];
    option.name       = _circleName.text;
    option.type       = NIMTeamTypeAdvanced;
    option.joinMode   = NIMTeamJoinModeNoAuth;
    option.intro      = _circleIntroduce.text;
    option.postscript = @"邀请你加入群组";
    [SVProgressHUD show];
//    [[NIMSDK sharedSDK].teamManager updateTeamAvatar:<#(nonnull NSString *)#> teamId:<#(nonnull NSString *)#> completion:^(NSError * _Nullable error) {
//        
//    }];
    [[NIMSDK sharedSDK].teamManager createTeam:option users:members completion:^(NSError *error, NSString *teamId) {
        [SVProgressHUD dismiss];
        if (!error) {
            NIMSession *session = [NIMSession session:teamId type:NIMSessionTypeTeam];
            NTESSessionViewController *vc = [[NTESSessionViewController alloc] initWithSession:session];
            [wself.navigationController pushViewController:vc animated:YES];
            [wself uploadTeamImage:teamId];
            
        }else{
            [wself.view makeToast:@"创建失败" duration:2.0 position:CSToastPositionCenter];
        }
    }];

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
    [self initCamera];
    
    // 跳转到相机或相册页面
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = YES;
    
    
    UIImagePickerControllerSourceType type;
    
    type =  UIImagePickerControllerSourceTypeCamera;
    
    imagePickerController.sourceType = type;
    imagePickerController.mediaTypes = @[(NSString *)kUTTypeImage];
    [self presentViewController:imagePickerController animated:YES completion:nil];}


- (void)selectImageFromAlbum
{
        // 跳转到相机或相册页面
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = YES;
    
    
    UIImagePickerControllerSourceType type;
    
    BOOL isCamraAvailable = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
    if (isCamraAvailable) {
        type =  UIImagePickerControllerSourceTypeCamera;
    }else{
        type =  UIImagePickerControllerSourceTypePhotoLibrary;
    }
    imagePickerController.sourceType = type;
    imagePickerController.mediaTypes = @[(NSString *)kUTTypeImage];
    [self presentViewController:imagePickerController animated:YES completion:nil];
    
}
- (void)initCamera{
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        
//        [UIAlertController alertControllerWithTitle:@"标题" message:@"检测不到相机设备" preferredStyle:UIAlertControllerStyleAlert];
        
        
        
        [[[UIAlertView alloc] initWithTitle:nil
                                    message:@"检测不到相机设备"
                                   delegate:nil
                          cancelButtonTitle:@"确定"
                          otherButtonTitles:nil] show];
        return;
    }
    
    NSString *mediaType = AVMediaTypeVideo;
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){
//        [UIAlertController alertControllerWithTitle:@"标题" message:@"相机权限受限" preferredStyle:UIAlertControllerStyleAlert];

        [[[UIAlertView alloc] initWithTitle:nil
                                    message:@"相机权限受限"
                                   delegate:nil
                          cancelButtonTitle:@"确定"
                          otherButtonTitles:nil] show];
        return;
    }
}

//当选择一张图片后进入这里
-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info

{
    
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    
    //当选择的类型是图片
    if ([type isEqualToString:@"public.image"])
    {
        //先把图片转成NSData
        UIImage* image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        [_addBtn setImage:image forState:UIControlStateNormal];
        teamImage = image;
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
        [fileManager createFileAtPath:[DocumentsPath stringByAppendingString:@"/image.png"] contents:data attributes:nil];
        
//        //得到选择后沙盒中图片的完整路径
//        NSString *filePath = [[NSString alloc]initWithFormat:@"%@%@",DocumentsPath,  @"/image.png"];
//        NSURL *url = [NSURL fileURLWithPath: filePath];
        //关闭相册界面
        [picker dismissModalViewControllerAnimated:YES];
        
        //创建一个选择后图片的小图标放在下方
        //类似微薄选择图后的效果
    } 
    
}
#pragma mark - Private
- (void)uploadTeamImage:(NSString *)teamID{
    UIImage *imageForAvatarUpload = [teamImage nim_imageForAvatarUpload];
    NSString *fileName = [[[[NSUUID UUID] UUIDString] lowercaseString] stringByAppendingPathExtension:@"jpg"];
    NSString *filePath = [NSTemporaryDirectory() stringByAppendingPathComponent:fileName];
    NSData *data = UIImageJPEGRepresentation(imageForAvatarUpload, 1.0);
    BOOL success = data && [data writeToFile:filePath atomically:YES];
    __weak typeof(self) wself = self;
    if (success) {
        [[NIMSDK sharedSDK].resourceManager upload:filePath progress:nil completion:^(NSString *urlString, NSError *error) {
            if (!error && wself) {
                [[NIMSDK sharedSDK].teamManager updateTeamAvatar:urlString teamId:teamID completion:^(NSError *error) {
                    if (!error) {
                        
                    }else{
                        [wself.view nimkit_makeToast:@"设置头像失败，请重试"
                                            duration:2
                                            position:NIMKitToastPositionCenter];
                    }
                }];
                
            }else{
                [wself.view nimkit_makeToast:@"图片上传失败，请重试"
                                    duration:2
                                    position:NIMKitToastPositionCenter];
            }
        }];
    }else{
        [self.view nimkit_makeToast:@"图片保存失败，请重试"
                           duration:2
                           position:NIMKitToastPositionCenter];
    }
}


-(void)touchbtn1{
    
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle: nil                                                                             message: nil                                                                       preferredStyle:UIAlertControllerStyleActionSheet];
    //添加Button
    __weak typeof(self) wself = self;

    [alertController addAction: [UIAlertAction actionWithTitle: @"拍照" style: UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        //处理点击拍照
        
        [wself selectImageFromCamera];
    }]];
    [alertController addAction: [UIAlertAction actionWithTitle: @"从相册选取" style: UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        //处理点击从相册选取
        
        [wself selectImageFromAlbum];
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

@end
