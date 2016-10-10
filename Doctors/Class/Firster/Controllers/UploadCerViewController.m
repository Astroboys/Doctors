//
//  UploadCerViewController.m
//  Doctors
//
//  Created by zhonghe on 16/9/28.
//  Copyright © 2016年 XueHuiWang. All rights reserved.
//

#import "UploadCerViewController.h"
#import "UploadCerCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"

#define MY_HEADER_LABEL_TAG 1000
#define PHOTO_WIDTH 85.0f
@interface UploadCerViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UINavigationControllerDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate>
{
    UICollectionView *photoUploadCollection;
    NSMutableDictionary *imageDic;
    UIActionSheet *editHeadActionSheet;
    int selectRow;
    
    NSArray *imageArray;
    UILabel *descLabel;
}

@end

@implementation UploadCerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = DWColor(243, 243, 243);
    imageDic = [NSMutableDictionary dictionary];
    [imageDic setObject:@"" forKey:@"0"];
   
//    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    descLabel = [[UILabel alloc] initWithFrame:CGRectMake(36, 0, KDeviceWidth - 72, 60)];
    descLabel.text = @"请如实填写您本人的身份信息和相关证件文件，以认证为实名专家！";
    descLabel.numberOfLines = 0;
    descLabel.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:descLabel];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UICollectionViewFlowLayout *photoFlow = [[UICollectionViewFlowLayout alloc] init];
    [photoFlow setItemSize:CGSizeMake(85, 115)];//设置cell的尺寸
    photoFlow.minimumLineSpacing = 15.0;
    photoFlow.minimumInteritemSpacing = 15.0;
    photoFlow.headerReferenceSize = CGSizeMake(300.0f, 30.0f);
    photoFlow.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    photoUploadCollection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(descLabel.frame)+15, self.view.frame.size.width, KDeviceHeight - 60-64) collectionViewLayout:photoFlow];
    photoUploadCollection.backgroundColor = [UIColor clearColor];
    photoUploadCollection.dataSource = self;
    photoUploadCollection.delegate = self;
//    photoUploadCollection.scrollEnabled = NO;
    photoUploadCollection.showsHorizontalScrollIndicator = NO;
    photoUploadCollection.showsVerticalScrollIndicator = NO;
    photoUploadCollection.alwaysBounceVertical = YES;
    [self.view addSubview:photoUploadCollection];
    [photoUploadCollection registerClass:[UploadCerCollectionViewCell class] forCellWithReuseIdentifier:@"collectionViewCell"];
    
    [photoUploadCollection registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Identifierhead"];
    if (self.isUpload == NO) {
//        [self getCerImage];
        [photoUploadCollection addHeaderWithTarget:self action:@selector(getCerImage)];
        [photoUploadCollection headerBeginRefreshing];

        descLabel.text = @"如您还没有提交任何资质证书，请如实填写您本人的身份信息和相关证件文件，将会增大审核机率！";

    }else{
        self.title = @"资质审核";
        UIBarButtonItem* item2 = [[UIBarButtonItem alloc]initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(clickright)];
        
        self.navigationItem.rightBarButtonItem = item2;

       
    }
    
}


-(void)getCerImage
{
    NSDictionary *dict = @{@"id":[UConfig getDoctorId]};
    [NetWorkingManager requestGETDataWithPath:[NSString stringWithFormat:@"%@app/doct/index",BaseUrl] withParamters:dict withProgress:^(float progress) {
        
    } success:^(BOOL isSuccess, id responseObject) {
        [photoUploadCollection headerEndRefreshing];
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSArray *array = responseObject[@"data"];
            if ([array isKindOfClass:[NSArray class]]) {
                NSDictionary *dic = array.firstObject;
                if ([dic isKindOfClass:[NSDictionary class]]) {
                    NSString *idStr = dic[@"id"];
                    NSString *photoUrl = dic[@"photo"];
                    NSString *tokenStr = dic[@"token"];
                    NSString *status = dic[@"status"];
                    NSString *imageStr = dic[@"physicianQualificationCertificate"];
                    
                    switch (status.intValue) {
                        case 0:
                        {
                            self.title = @"审核中";
                        }
                            break;
                        case 1:
                        {
                            self.title = @"审核成功";
                        }
                            break;
                        case 2:
                        {
                            self.title = @"审核失败";
                        }
                            break;
                        default:
                            break;
                    }
                    if (imageStr.length>0) {
                        imageArray = [imageStr componentsSeparatedByString:@","];
                       
                    }else{
                        [YJProgressHUD showSuccess:@"您还没有提交任何资质证书，请如实填写您本人的身份信息和相关证件文件，将会增大审核机率！" inview:self.view];
                    }
                    if ([UConfig getVerifyStatus] != 1 && status.integerValue == 1 && tokenStr.length>0) {
                        //登录im
                        [[NIMSDK sharedSDK].loginManager login:[NSString stringWithFormat:@"_%@",[UConfig getLoginNumber]] token:tokenStr completion:^(NSError *error) {
                            if (!error) {
                                NSLog(@"登录成功");
                                
                            }else{
                                NSLog(@"登录失败");
                            }
                        }];

                    }
                    if (idStr.intValue>0) {
                        [UConfig setDoctorId:idStr];
                        [UConfig setPersonInfo:dic];
                        [UConfig setPhotoUrl:photoUrl];
                        [UConfig setVerifyStatus:status.integerValue];
                        [UConfig setLoginToken:tokenStr];
                        //创建通知
                        NSNotification *notification =[NSNotification notificationWithName:@"updatePhoto" object:nil userInfo:nil];
                        //通过通知中心发送通知
                        [[NSNotificationCenter defaultCenter] postNotification:notification];
                        [photoUploadCollection reloadData];
                    }
                }
            }
            
        }
        NSLog(@"%@",responseObject);
    } failure:^(NSError *error) {
        [photoUploadCollection headerEndRefreshing];
    }];

}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.isUpload == YES)
        return imageDic.count;
    else
        return imageArray.count;
    
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UploadCerCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionViewCell" forIndexPath:indexPath];
    NSString *urlStr;
    if (self.isUpload == YES) {
        urlStr = imageDic[[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
    }else{
        urlStr = imageArray[indexPath.row];
       
    }
    
    
    
    if (self.isUpload == YES) {
        [cell.photoImgeView sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:@"cer_default_image.png"]];
    }else{
        [cell.photoImgeView sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:@"default_image"]];
    }
    
    cell.imageTitle.text = [NSString stringWithFormat:@"证书%ld",indexPath.row+1];
    
    return cell;
}

//-(void)viewDidAppear:(BOOL)animated
//{
//    [photoUploadCollection reloadData];
//}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
    UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:
                                            UICollectionElementKindSectionHeader withReuseIdentifier:@"Identifierhead" forIndexPath:indexPath];
    UILabel *label = (UILabel *)[headerView viewWithTag:MY_HEADER_LABEL_TAG];
    if (!label) {
        label = [[UILabel alloc] initWithFrame:CGRectInset(headerView.bounds, 10, 10)];
        label.tag = MY_HEADER_LABEL_TAG;
        label.font = [UIFont boldSystemFontOfSize:14];
        label.textColor = [UIColor darkGrayColor];
        [headerView addSubview:label];
    }
    
    return headerView;
    
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    UIEdgeInsets top = {10,10,10,10};
    return top;
}

//设置顶部的大小
//-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
//    CGSize size={0,0};
//    return size;
//}
//设置元素大小
//-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
//
//    //NSLog(@"%f",(kDeviceHeight-88-49)/4.0);
//    return CGSizeMake(240,(kDeviceHeight-kNavHeight*2-kTabBarHeight-20)/4.0);
//}

//点击元素触发事件
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%@",indexPath);
    
    if (self.isUpload == YES) {
        selectRow = indexPath.row;
        NSString *imageStr = [imageDic objectForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
        
        if (imageStr.length>0) {
            [self deletePhotoAction];
        }else{
            [self editPhoto];
        }
    }
    
}

- (void)deletePhotoAction
{
    
        //在这里呼出下方菜单按钮项
        editHeadActionSheet  = [[UIActionSheet alloc]
                                initWithTitle:nil
                                delegate:self
                                cancelButtonTitle:@"取消"
                                destructiveButtonTitle:nil
                                otherButtonTitles: @"打开照相机", @"从手机相册获取",@"删除照片",nil];
        editHeadActionSheet.tag = 10000;
        //该方法解决点击Cancel Button很难响应的问题
        [editHeadActionSheet showInView:[UIApplication sharedApplication].keyWindow];
    
}

-(void)editPhoto
{
    //在这里呼出下方菜单按钮项
    editHeadActionSheet  = [[UIActionSheet alloc]
                            initWithTitle:nil
                            delegate:self
                            cancelButtonTitle:@"取消"
                            destructiveButtonTitle:nil
                            otherButtonTitles: @"打开照相机", @"从手机相册获取",nil];
    editHeadActionSheet.tag = 10001;
    //该方法解决点击Cancel Button很难响应的问题
    [editHeadActionSheet showInView:[UIApplication sharedApplication].keyWindow];

}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 10000) {
        switch (buttonIndex)
        {
            case 0:  //打开照相机拍照
                [self takePhoto];
                break;
            case 1:  //打开本地相册
                [self openPhoLibray];
                break;
            case 2:
            {
            
                [imageDic removeObjectForKey:[NSString stringWithFormat:@"%d",selectRow]];
               
            
                
                
            }
                break;
                
        }
        [photoUploadCollection reloadData];
    }else{
        switch (buttonIndex)
        {
            case 0:  //打开照相机拍照
                [self takePhoto];
                break;
            case 1:  //打开本地相册
                [self openPhoLibray];
                break;
        }
        
    }
}

//开始拍照
-(void)takePhoto
{
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *photoPicker = [[UIImagePickerController alloc] init];
        photoPicker.delegate = self;
        //设置拍照后的图片可被编辑
        photoPicker.allowsEditing = NO;
        photoPicker.sourceType = sourceType;
        
        [self.navigationController presentModalViewController:photoPicker animated:YES];
    }else
    {
        //NSLog(@"模拟其中无法打开照相机,请在真机中使用");
    }
}

-(void)openPhoLibray
{
    //NSLog(@"进入图片库");
    //该方法应返回选中的图片，并作为头像
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.allowsEditing = NO;    //图片可以编辑
    [self.navigationController.topViewController presentModalViewController:imagePicker animated:YES];
    //    [[UAppDelegate uApp].rootNavigationController.topViewController presentModalViewController:imagePicker animated:YES];
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
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
        NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"%d.png", selectRow]];   // 保存文件的名称
        [UIImagePNGRepresentation(image)writeToFile:filePath atomically:YES];
        
        
        
        //        //得到选择后沙盒中图片的完整路径
      
        NSURL *url = [NSURL fileURLWithPath: filePath];
        
        [imageDic setObject:url.absoluteString forKey:[NSString stringWithFormat:@"%lu",(unsigned long)selectRow]];

        if (imageDic.count<6) {
            [imageDic setObject:@"" forKey:[NSString stringWithFormat:@"%lu",(unsigned long)imageDic.count]];
        }
        //关闭相册界面
        [picker dismissModalViewControllerAnimated:YES];
        
        //创建一个选择后图片的小图标放在下方
        //类似微薄选择图后的效果
        [photoUploadCollection reloadData];
        
    } 
    
}





-(void)clickright
{
    
    NSMutableArray *imageArr = [NSMutableArray array];
    for (NSString *str in imageDic.allValues) {
        if (str.length>0) {
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:str]];
            [imageArr addObject:[UIImage imageWithData:data]];
        }
    }
    NSDictionary *dic = @{@"id":[UConfig getDoctorId]};
    [YJProgressHUD showProgress:@"正在提交..." inView:self.view];
    [NetWorkingManager sendPOSTImageWithPath:[NSString stringWithFormat:@"%@%@",BaseUrl,@"app/doct/upload"] withParamters:dic withImageArray:imageArr withtargetWidth:300 withProgress:^(float progress) {
        
    } success:^(BOOL isSuccess, id responseObject) {
        NSLog(@"%@",responseObject);
        [YJProgressHUD hide];
        
        NSString *code = responseObject[@"code"];
        if (code.intValue == 200) {
            [YJProgressHUD showSuccess:@"提交成功" inview:self.view];
            
        }else{
             [YJProgressHUD showSuccess:@"提交失败" inview:self.view];
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        
        [YJProgressHUD hide];
        [YJProgressHUD showSuccess:@"提交失败，请检查网络" inview:self.view];
        
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
