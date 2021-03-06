//
//  ZHFirstViewController.m
//  Doctors
//
//  Created by 崔敬轩 on 16/8/22.
//  Copyright © 2016年 崔敬轩. All rights reserved.

#import "ZHFirstViewController.h"
#import "YCLeftViewController.h"
#import "UIButton+ImageTitleSpacing.h"
#import "UIView+Frame.h"
#import "Masonry.h"
#import "ChangeBtn.h"
#import "ZHDetailsViewController.h"
#import "UIViewController+MMDrawerController.h"
#import "UploadCerViewController.h"
#import "AlertViewController.h"
#import "UIImageView+WebCache.h"
#import "ZHFirstTableViewCell.h"
#import "ZHMterialViewController.h"
@interface ZHFirstViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UILabel *labelCount;
    UILabel *tabarCount;
}
@property(nonatomic,strong)UIImageView*imageView;
@property(nonatomic,strong)UILabel*idNum;
@property(nonatomic,strong)UIView*doctorView;

@property(nonatomic,strong)UIButton*zizhiButton;
@property(nonatomic,strong)UIButton*shenheButton;
@property(nonatomic,strong)UIButton*shimingButton;

@property(nonatomic,strong)UILabel*zonghelab;
@property(nonatomic,strong)UILabel*zixunlab;
@property(nonatomic,strong)UILabel*guanzhulab;

@property(nonatomic,strong)UILabel*zonghela;
@property(nonatomic,strong)UILabel*zixunla;
@property(nonatomic,strong)UILabel*guanzhula;

@property(nonatomic,strong)UIView*midView;
@property(nonatomic,strong)UIView*lastView;

@property(nonatomic,strong)UILabel*detailLbl;

@property(nonatomic,strong)UITableView*detailtab;

@property(nonatomic,strong)NSArray*dataArr;

@property(nonatomic,strong)NSArray*dataImageArr;

@end

@implementation ZHFirstViewController

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    
    NSDictionary *dic = @{@"doctorId":[UConfig getDoctorId]};
    
    [NetWorkingManager requestGETDataWithPath:[NSString stringWithFormat:@"%@%@",BaseUrl,@"app/consult/findDoctorConsultAtten"] withParamters:dic withProgress:nil success:^(BOOL isSuccess, id responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSString *code = responseObject[@"code"];
            if (code.intValue == 200) {
                if ([responseObject[@"data"] isKindOfClass:[NSArray class]]) {
                    NSArray *array = responseObject[@"data"];

                    NSDictionary *dict = array.firstObject;
                    NSString *zonghe = [MethodUtil exist:dict[@"comprehensive"]];
                    NSString *zixun = [MethodUtil exist:dict[@"advisoryNumber"]];
                    NSString *guanzhu = [MethodUtil exist:dict[@"atteNum"]];
                    _zonghela.text = zonghe.length>0?zonghe:@"0";
                    _zixunla.text =  zixun.length>0?zixun:@"0";
                    _guanzhula.text = guanzhu.length>0?guanzhu:@"0";
                }
            }else{
            }
            NSLog(@"%@",responseObject);

        }
        
    } failure:^(NSError *error) {
    }];
    [_detailtab reloadData];
    
    
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

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = DWColor(243, 243, 243);
   
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    
    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updatePhoto) name:@"updatePhoto" object:nil];
    
    UIImage* image1 = [UIImage imageNamed:@"navigationbar_pop"];
    // 告诉系统以后这张图片不进行默认的渲染
    image1 = [image1 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIImage* image2 = [UIImage imageNamed:@"navigationbar_news"];
    // 告诉系统以后这张图片不进行默认的渲染
    image2 = [image2 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIBarButtonItem* item1 = [[UIBarButtonItem alloc]initWithImage:image1 style:UIBarButtonItemStylePlain target:self action:@selector(firstClickleft)];
    
    self.navigationItem.title=@"";
    
    
    
    UIButton*rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,30,30)];
    [rightButton setImage:image2 forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(firstClickright)forControlEvents:UIControlEventTouchUpInside];
    
    
    // 创建活动的按钮
    UIBarButtonItem* item2 = [[UIBarButtonItem alloc]initWithImage:image2 style:UIBarButtonItemStylePlain target:self action:@selector(firstClickright)];
    
    labelCount = [[UILabel alloc] initWithFrame:CGRectMake(17, 6, 8, 8)];
    labelCount.backgroundColor = [UIColor redColor];
//    labelCount.textColor = [UIColor redColor];
    labelCount.font = [UIFont systemFontOfSize:10];
    labelCount.layer.masksToBounds = YES;
    labelCount.layer.cornerRadius = 4;
    if ([UConfig getUnreadCount]==0) {
        labelCount.hidden = YES;
    }else{
        labelCount.hidden = NO;
    }

//    labelCount.text = [NSString stringWithFormat:@"%ld",(long)[UConfig getUnreadCount]];
    [rightButton addSubview:labelCount];

    
    
    tabarCount = [[UILabel alloc] initWithFrame:CGRectMake((kWidth/8)+8, 6, 8, 8)];
    tabarCount.backgroundColor = [UIColor redColor];
    //    labelCount.textColor = [UIColor redColor];
    tabarCount.font = [UIFont systemFontOfSize:10];
    tabarCount.layer.masksToBounds = YES;
    tabarCount.layer.cornerRadius = 4;
    if ([UConfig getUnreadCount]==0) {
        tabarCount.hidden = YES;
    }else{
        tabarCount.hidden = NO;
    }
    [self.tabBarController.tabBar addSubview:tabarCount];
    

    
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    
    self.navigationItem.leftBarButtonItem = item1;
//    self.navigationItem.rightBarButtonItem = item2;
    
    self.view.backgroundColor=[UIColor colorWithRed:40/255.0 green:128/255.0 blue:194/255.0 alpha:1];
    
   
    
    
    
    
    
    _dataImageArr=@[@"briefly",@"cure",@"hospital",@"briefly"];
    _dataArr = @[@"所在医院:",@"所在科室:",@"擅长主治:",@"医师职称:"];
    
    [self setupUI];
    [self setupFrame];
}
-(void)updatePhoto
{
    [_imageView sd_setImageWithURL:[NSURL URLWithString:[UConfig getPhotoUrl]] placeholderImage:[UIImage imageNamed:@"mineIcon"]];
    if ([UConfig getUnreadCount]==0) {
        labelCount.hidden = YES;
        tabarCount.hidden = YES;
    }else{
        labelCount.hidden = NO;
        tabarCount.hidden = NO;
    }
//    labelCount.text = [NSString stringWithFormat:@"%ld",(long)[UConfig getUnreadCount]];
}

-(void)setupUI{

    //头像按钮
    _imageView =[[UIImageView alloc]init];
    [_imageView sd_setImageWithURL:[NSURL URLWithString:[UConfig getPhotoUrl]] placeholderImage:[UIImage imageNamed:@"indexIcon"]];
    [_imageView.layer setMasksToBounds:YES];
    [_imageView.layer setCornerRadius:40.0];
    [self.view addSubview:self.imageView];
    
    //号码
    _idNum =[[UILabel alloc]init];
    [_idNum setTextAlignment:NSTextAlignmentCenter];
    _idNum.textColor=[UIColor whiteColor];
    _idNum.text =[UConfig getLoginNumber];
    [self.view addSubview:self.idNum];
    
    //中间
    _doctorView =[[UIView alloc]init];
    _doctorView =[[UIView alloc]init];
    
    _zizhiButton =[[ChangeBtn alloc]init];
    [_zizhiButton setImage:[UIImage imageNamed:@"credentials"] forState:UIControlStateNormal];
    [_zizhiButton setTitle:@"资质认证" forState:UIControlStateNormal];
    _zizhiButton.backgroundColor = [UIColor clearColor];
    [_zizhiButton addTarget:self action:@selector(zizhiAction) forControlEvents:UIControlEventTouchUpInside];
//    _zizhiButton.userInteractionEnabled=NO;
    
    _shenheButton =[[ChangeBtn alloc]init];
    [_shenheButton setImage:[UIImage imageNamed:@"check"] forState:UIControlStateNormal];
    [_shenheButton setTitle:@"认证审核" forState:UIControlStateNormal];
    [_shenheButton addTarget:self action:@selector(shenheAction) forControlEvents:UIControlEventTouchUpInside];
    _shenheButton.backgroundColor = [UIColor clearColor];
//    _shenheButton.userInteractionEnabled=NO;
    
    
    
    _shimingButton =[[ChangeBtn alloc]init];
    [_shimingButton setImage:[UIImage imageNamed:@"realName"] forState:UIControlStateNormal];
    [_shimingButton setTitle:@"实名认证" forState:UIControlStateNormal];
    [_shimingButton addTarget:self action:@selector(shimingAction) forControlEvents:UIControlEventTouchUpInside];

    _shimingButton.backgroundColor = [UIColor clearColor];
//    _shimingButton.userInteractionEnabled=NO;
    
    [_doctorView addSubview:_shimingButton];
    [_doctorView addSubview:_shenheButton];
    [_doctorView addSubview:_zizhiButton];
    
    _midView=[[UIView alloc]init];
    _midView.backgroundColor = DWColor(243, 243, 243);
    
    _zonghelab=[[UILabel alloc]init];
    _zonghelab.text=@"综合好评";
    _zonghelab.backgroundColor=[UIColor whiteColor];
    _zonghelab.textColor = DWColor(149, 149, 149);
    [_zonghelab setFont:[UIFont systemFontOfSize:12]];
    [_zonghelab setTextAlignment:NSTextAlignmentCenter];
    
    _zonghela=[[UILabel alloc]init];
    _zonghela.text=@"0";
    _zonghela.backgroundColor=[UIColor whiteColor];
    _zonghela.textColor = DWColor(253, 94, 94);
    [_zonghela setFont:[UIFont systemFontOfSize:12]];
    [_zonghela setTextAlignment:NSTextAlignmentCenter];
    
    _zixunlab=[[UILabel alloc]init];
    _zixunlab.text=@"咨询人数";
    _zixunlab.textColor = DWColor(149, 149, 149);

    _zixunlab.backgroundColor=[UIColor whiteColor];
    [_zixunlab setFont:[UIFont systemFontOfSize:12]];
    [_zixunlab setTextAlignment:NSTextAlignmentCenter];
    
    _zixunla=[[UILabel alloc]init];
    _zixunla.text=@"0";
    _zixunla.textColor = DWColor(253, 94, 94);
    _zixunla.backgroundColor=[UIColor whiteColor];
    [_zixunla setFont:[UIFont systemFontOfSize:12]];
    [_zixunla setTextAlignment:NSTextAlignmentCenter];
    

    _guanzhulab=[[UILabel alloc]init];
    _guanzhulab.text=@"已关注数";
    _guanzhulab.textColor = DWColor(149, 149, 149);

    _guanzhulab.backgroundColor=[UIColor whiteColor];
    [_guanzhulab setFont:[UIFont systemFontOfSize:12]];
    [_guanzhulab setTextAlignment:NSTextAlignmentCenter];
    
    _guanzhula=[[UILabel alloc]init];
    _guanzhula.text=@"0";
    _guanzhula.textColor = DWColor(253, 94, 94);

    _guanzhula.backgroundColor=[UIColor whiteColor];
    [_guanzhula setFont:[UIFont systemFontOfSize:12]];
    [_guanzhula setTextAlignment:NSTextAlignmentCenter];
    
    [_midView addSubview:self.zonghela];
    [_midView addSubview:self.guanzhula];
    [_midView addSubview:self.zixunla];
    [_midView addSubview:self.zixunlab];
    [_midView addSubview:self.guanzhulab];
    [_midView addSubview:self.zonghelab];
    
    _lastView=[[UIView alloc]init];
    _lastView.backgroundColor=[UIColor whiteColor];
    
    _detailLbl=[[UILabel alloc]init];
    [_detailLbl setFont:[UIFont systemFontOfSize:14]];
    _detailLbl.text=@"详情介绍:";
    _detailLbl.textColor=DWColor(24, 144, 203);
    
    _detailtab=[[UITableView alloc]init];
    [_lastView addSubview:self.detailLbl];
    [_lastView addSubview:self.detailtab];
    _detailtab.delegate=self;
    _detailtab.dataSource=self;
    _detailtab.tableFooterView = [[UIView alloc]init];

    
    [_doctorView addSubview:self.midView];
    [_midView addSubview:self.lastView];
    [self.view addSubview:_doctorView];

}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArr.count;
}



-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *ID=@"cell";
    ZHFirstTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell=[[ZHFirstTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.titleLab.text=_dataArr[indexPath.row];
    cell.detailText.textColor = DWColor(85, 85, 85);
    
    NSDictionary *dict = [UConfig getPersonInfo];
    switch (indexPath.row) {
        case 0:
        {
            cell.detailText.text = dict[@"hospital"];

        }
            break;
        case 1:
        {
            cell.detailText.text = dict[@"department"];
        }
            break;
        case 2:
        {
            cell.detailText.text = dict[@"goodAt"];
        }
            break;
        case 3:
        {
            NSArray *professionArray = @[@"住院医师",@"主治医师",@"副主任医师",@"主任医师"];
            if (dict.count>0) {
                NSString *professionStr = dict[@"profession"];
               
                if (professionStr.length>0&&professionStr.intValue>0 && professionStr.intValue<professionArray.count) {
                    cell.detailText.text = professionArray[professionStr.intValue-1];
                }

            }
            
        }
            break;

        default:
            break;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.photoView.image=[UIImage imageNamed:_dataImageArr[indexPath.row]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return 45;
        
}

-(void)setupFrame{

//    if(isiPhone6P){
//        
//        //头像
//        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.view.mas_top).with.offset(30);
//            make.left.mas_equalTo(self.view.mas_left).with.offset((kWidth-80)*0.5);
//            make.height.mas_equalTo(80);
//            make.width.mas_equalTo(80);
//        }];
//        //号码
//        [self.idNum mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.imageView.mas_bottom).with.offset(5);
//            make.left.mas_equalTo(self.view.mas_left).with.offset((kWidth-100)*0.5);
//            make.height.mas_equalTo(30);
//            make.width.mas_equalTo(200);
//            
//        }];
//        //总布局
//        [self.doctorView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(self.idNum.mas_bottom).with.offset(50);
//            make.left.equalTo(self.view.mas_left).with.offset(0);
//            make.width.mas_equalTo(kWidth);
//            make.bottom.mas_equalTo(self.view.mas_bottom);
//        }];
//        
//        //资质认证
//        [self.zizhiButton mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(self.doctorView.mas_top);
//            make.left.mas_equalTo(self.view.mas_left).with.offset(20);
//            make.width.mas_equalTo(80);
//            make.height.mas_equalTo(80);
//        }];
//        
//        [self.shenheButton mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(self.doctorView.mas_top);
//            make.left.mas_equalTo(self.zizhiButton.mas_right).with.offset((kWidth-80*3-40)/2);
//            make.width.mas_equalTo(80);
//            make.height.mas_equalTo(80);
//        }];
//        
//        [self.shimingButton mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(self.doctorView.mas_top);
//            make.left.mas_equalTo(self.shenheButton.mas_right).with.offset((kWidth-80*3-40)/2);
//            make.width.mas_equalTo(80);
//            make.height.mas_equalTo(80);
//        }];
//        
//        [self.midView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(self.zizhiButton.mas_bottom);
//            make.left.mas_equalTo(self.doctorView.mas_left);
//            make.width.mas_equalTo(kWidth);
//            make.bottom.mas_equalTo(self.view.mas_bottom);
//        }];
//        
//        [self.zonghelab mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(self.zizhiButton.mas_bottom);
//            make.left.mas_equalTo(self.doctorView.mas_left);
//            make.width.mas_equalTo(kWidth/3);
//            make.height.mas_equalTo(30);
//            
//        }];
//        
//        [self.zonghela mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(self.zonghelab.mas_bottom);
//            make.left.mas_equalTo(self.doctorView.mas_left);
//            make.width.mas_equalTo(kWidth/3);
//            make.height.mas_equalTo(15);
//            
//        }];
//        
//        [self.zixunlab mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(self.shenheButton.mas_bottom);
//            make.left.mas_equalTo(self.zonghelab.mas_right);
//            make.width.mas_equalTo(kWidth/3);
//            make.height.mas_equalTo(30);
//            
//        }];
//        
//        [self.zixunla mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(self.zixunlab.mas_bottom);
//            make.left.mas_equalTo(self.zonghelab.mas_right);
//            make.width.mas_equalTo(kWidth/3);
//            make.height.mas_equalTo(15);
//        }];
//
//        
//        [self.guanzhulab mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(self.shimingButton.mas_bottom);
//            make.left.mas_equalTo(self.zixunlab.mas_right);
//            make.width.mas_equalTo(kWidth/3);
//            make.height.mas_equalTo(30);
//            
//        }];
//        
//        [self.guanzhula mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(self.guanzhulab.mas_bottom);
//            make.left.mas_equalTo(self.zixunla.mas_right);
//            make.width.mas_equalTo(kWidth/3);
//            make.height.mas_equalTo(15);
//        }];
//        
//        [self.lastView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(self.zonghela.mas_bottom).with.offset(8);
//            make.left.mas_equalTo(self.doctorView.mas_left);
//            make.width.mas_equalTo(kWidth);
//            make.bottom.mas_equalTo(self.view.mas_bottom);
//        }];
//        
//        [self.detailLbl mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(self.lastView.mas_top);
//            make.left.mas_equalTo(self.doctorView.mas_left).with.offset(10);
//            make.width.mas_equalTo(80);
//            make.height.mas_equalTo(30);
//        }];
//        
//        [self.detailtab mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(self.detailLbl.mas_bottom);
//            make.left.mas_equalTo(self.doctorView.mas_left);
//            make.width.mas_equalTo(kWidth);
//            make.bottom.mas_equalTo(self.doctorView.mas_bottom);
//        }];
//
//    }else if (isiPhone6){
    
//        //头像
//        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.view.mas_top).with.offset(10);
//            make.left.mas_equalTo(self.view.mas_left).with.offset((kWidth-80)*0.5);
//            make.height.mas_equalTo(80);
//            make.width.mas_equalTo(80);
//        }];
//        //号码
//        [self.idNum mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.imageView.mas_bottom).with.offset(5);
//            make.left.mas_equalTo(self.view.mas_left).with.offset((kWidth-200)*0.5);
//            make.height.mas_equalTo(30);
//            make.width.mas_equalTo(200);
//        
//        }];
//        //总布局
//        [self.doctorView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(self.idNum.mas_bottom).with.offset(60);
//            make.left.equalTo(self.view.mas_left).with.offset(0);
//            make.width.mas_equalTo(kWidth);
//            make.bottom.mas_equalTo(self.view.mas_bottom);
//        }];
//        
//        //资质认证
//        [self.zizhiButton mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(self.doctorView.mas_top);
//            make.left.mas_equalTo(self.view.mas_left).with.offset(20);
//            make.width.mas_equalTo(80);
//            make.height.mas_equalTo(80);
//        }];
//        
//        [self.shenheButton mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(self.doctorView.mas_top);
//            make.left.mas_equalTo(self.zizhiButton.mas_right).with.offset((kWidth-80*3-40)/2);
//            make.width.mas_equalTo(80);
//            make.height.mas_equalTo(80);
//        }];
//        
//        [self.shimingButton mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(self.doctorView.mas_top);
//            make.left.mas_equalTo(self.shenheButton.mas_right).with.offset((kWidth-80*3-40)/2);
//            make.width.mas_equalTo(80);
//            make.height.mas_equalTo(80);
//        }];
//        
//        [self.midView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(self.zizhiButton.mas_bottom);
//            make.left.mas_equalTo(self.doctorView.mas_left);
//            make.width.mas_equalTo(kWidth);
//            make.bottom.mas_equalTo(self.view.mas_bottom);
//        }];
//        
//        [self.zonghelab mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(self.zizhiButton.mas_bottom);
//            make.left.mas_equalTo(self.doctorView.mas_left);
//            make.width.mas_equalTo(kWidth/3);
//            make.height.mas_equalTo(30);
//            
//        }];
//        
//        [self.zonghela mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(self.zonghelab.mas_bottom);
//            make.left.mas_equalTo(self.doctorView.mas_left);
//            make.width.mas_equalTo(kWidth/3);
//            make.height.mas_equalTo(15);
//            
//        }];
//        
//        [self.zixunlab mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(self.shenheButton.mas_bottom);
//            make.left.mas_equalTo(self.zonghelab.mas_right);
//            make.width.mas_equalTo(kWidth/3);
//            make.height.mas_equalTo(30);
//            
//        }];
//        
//        [self.zixunla mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(self.zixunlab.mas_bottom);
//            make.left.mas_equalTo(self.zonghelab.mas_right);
//            make.width.mas_equalTo(kWidth/3);
//            make.height.mas_equalTo(15);
//        }]; 
//        
//        [self.guanzhulab mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(self.shimingButton.mas_bottom);
//            make.left.mas_equalTo(self.zixunlab.mas_right);
//            make.width.mas_equalTo(kWidth/3);
//            make.height.mas_equalTo(30);
//        }];
//        
//        [self.guanzhula mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(self.guanzhulab.mas_bottom);
//            make.left.mas_equalTo(self.zixunla.mas_right);
//            make.width.mas_equalTo(kWidth/3);
//            make.height.mas_equalTo(15);
//        }];
//
//        
//        [self.lastView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(self.zonghela.mas_bottom).with.offset(8);
//            make.left.mas_equalTo(self.doctorView.mas_left);
//            make.width.mas_equalTo(kWidth);
//            make.bottom.mas_equalTo(self.view.mas_bottom);
//            
//        }];
//        
//        [self.detailLbl mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(self.lastView.mas_top);
//            make.left.mas_equalTo(self.doctorView.mas_left).with.offset(10);
//            make.width.mas_equalTo(80);
//            make.height.mas_equalTo(30);
//        }];
//        
//        [self.detailtab mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(self.detailLbl.mas_bottom);
//            make.left.mas_equalTo(self.doctorView.mas_left);
//            make.width.mas_equalTo(kWidth);
//            make.bottom.mas_equalTo(self.doctorView.mas_bottom);
//        }];
//

        
//    }else if(isiPhone5){
//        
        //头像
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view.mas_top).with.offset(10);
            make.left.mas_equalTo(self.view.mas_left).with.offset((kWidth-80)*0.5);
            make.height.mas_equalTo(80);
            make.width.mas_equalTo(80);
        }];
        //号码
        [self.idNum mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.imageView.mas_bottom).with.offset(5);
            make.left.mas_equalTo(self.view.mas_left).with.offset((kWidth-200)*0.5);
            make.height.mas_equalTo(30);
            make.width.mas_equalTo(200);
            
        }];
        //总布局
        [self.doctorView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.idNum.mas_bottom).with.offset(20);
            make.left.equalTo(self.view.mas_left).with.offset(0);
            make.width.mas_equalTo(kWidth);
            make.bottom.mas_equalTo(self.view.mas_bottom);
        }];
        
        //资质认证
        [self.zizhiButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.doctorView.mas_top);
            make.left.mas_equalTo(self.view.mas_left).with.offset(20);
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(80);
        }];
        
        [self.shenheButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.doctorView.mas_top);
            make.left.mas_equalTo(self.zizhiButton.mas_right).with.offset((kWidth-80*3-40)/2);
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(80);
        }];
        
        [self.shimingButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.doctorView.mas_top);
            make.left.mas_equalTo(self.shenheButton.mas_right).with.offset((kWidth-80*3-40)/2);
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(80);
        }];
        
        [self.midView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.zizhiButton.mas_bottom);
            make.left.mas_equalTo(self.doctorView.mas_left);
            make.width.mas_equalTo(kWidth);
            make.bottom.mas_equalTo(self.view.mas_bottom);
        }];
        
        [self.zonghelab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.zizhiButton.mas_bottom);
            make.left.mas_equalTo(self.doctorView.mas_left);
            make.width.mas_equalTo(kWidth/3);
            make.height.mas_equalTo(30);
            
        }];
        
        [self.zonghela mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.zonghelab.mas_bottom);
            make.left.mas_equalTo(self.doctorView.mas_left);
            make.width.mas_equalTo(kWidth/3);
            make.height.mas_equalTo(15);
            
        }];
        
        [self.zixunlab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.shenheButton.mas_bottom);
            make.left.mas_equalTo(self.zonghelab.mas_right);
            make.width.mas_equalTo(kWidth/3);
            make.height.mas_equalTo(30);
            
        }];
        
        [self.zixunla mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.zixunlab.mas_bottom);
            make.left.mas_equalTo(self.zonghelab.mas_right);
            make.width.mas_equalTo(kWidth/3);
            make.height.mas_equalTo(15);
        }];

        
        [self.guanzhulab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.shimingButton.mas_bottom);
            make.left.mas_equalTo(self.zixunlab.mas_right);
            make.width.mas_equalTo(kWidth/3);
            make.height.mas_equalTo(30);
            
        }];
        
        
        [self.guanzhula mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.guanzhulab.mas_bottom);
            make.left.mas_equalTo(self.zixunla.mas_right);
            make.width.mas_equalTo(kWidth/3);
            make.height.mas_equalTo(15);
        }];

        
        [self.lastView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.zonghela.mas_bottom).with.offset(8);
            make.left.mas_equalTo(self.doctorView.mas_left);
            make.width.mas_equalTo(kWidth);
            make.bottom.mas_equalTo(self.view.mas_bottom);
            
        }];
        
        [self.detailLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.lastView.mas_top);
            make.left.mas_equalTo(self.doctorView.mas_left).with.offset(10);
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(30);
        }];
        
        [self.detailtab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.detailLbl.mas_bottom);
            make.left.mas_equalTo(self.doctorView.mas_left);
            make.width.mas_equalTo(kWidth);
            make.bottom.mas_equalTo(self.doctorView.mas_bottom);
        }];
//
//
//        
//    }else if (isiPhone4){
//        
//        //头像
//        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.view.mas_top).with.offset(10);
//            make.left.mas_equalTo(self.view.mas_left).with.offset((kWidth-80)*0.5);
//            make.height.mas_equalTo(80);
//            make.width.mas_equalTo(80);
//        }];
//        //号码
//        [self.idNum mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.imageView.mas_bottom).with.offset(5);
//            make.left.mas_equalTo(self.view.mas_left).with.offset((kWidth-100)*0.5);
//            make.height.mas_equalTo(30);
//            make.width.mas_equalTo(200);
//            
//        }];
//        //总布局
//        [self.doctorView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(self.idNum.mas_bottom).with.offset(5);
//            make.left.equalTo(self.view.mas_left).with.offset(0);
//            make.width.mas_equalTo(kWidth);
//            make.bottom.mas_equalTo(self.view.mas_bottom);
//        }];
//        
//        //资质认证
//        [self.zizhiButton mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(self.doctorView.mas_top);
//            make.left.mas_equalTo(self.view.mas_left).with.offset(20);
//            make.width.mas_equalTo(80);
//            make.height.mas_equalTo(80);
//        }];
//        
//        [self.shenheButton mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(self.doctorView.mas_top);
//            make.left.mas_equalTo(self.zizhiButton.mas_right).with.offset((kWidth-80*3-40)/2);
//            make.width.mas_equalTo(80);
//            make.height.mas_equalTo(80);
//        }];
//        
//        [self.shimingButton mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(self.doctorView.mas_top);
//            make.left.mas_equalTo(self.shenheButton.mas_right).with.offset((kWidth-80*3-40)/2);
//            make.width.mas_equalTo(80);
//            make.height.mas_equalTo(80);
//        }];
//        
//        [self.midView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(self.zizhiButton.mas_bottom);
//            make.left.mas_equalTo(self.doctorView.mas_left);
//            make.width.mas_equalTo(kWidth);
//            make.bottom.mas_equalTo(self.view.mas_bottom);
//
//        }];
//        
//        [self.zonghelab mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(self.zizhiButton.mas_bottom);
//            make.left.mas_equalTo(self.doctorView.mas_left);
//            make.width.mas_equalTo(kWidth/3);
//            make.height.mas_equalTo(30);
//            
//        }];
//        
//        [self.zonghela mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(self.zonghelab.mas_bottom);
//            make.left.mas_equalTo(self.doctorView.mas_left);
//            make.width.mas_equalTo(kWidth/3);
//            make.height.mas_equalTo(15);
//        }];
//        
//        [self.zixunlab mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(self.shenheButton.mas_bottom);
//            make.left.mas_equalTo(self.zonghelab.mas_right);
//            make.width.mas_equalTo(kWidth/3);
//            make.height.mas_equalTo(30);
//            
//        }];
//        
//        [self.zixunla mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(self.zixunlab.mas_bottom);
//            make.left.mas_equalTo(self.zonghelab.mas_right);
//            make.width.mas_equalTo(kWidth/3);
//            make.height.mas_equalTo(15);
//        }];
//
//        
//        [self.guanzhulab mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(self.shimingButton.mas_bottom);
//            make.left.mas_equalTo(self.zixunlab.mas_right);
//            make.width.mas_equalTo(kWidth/3);
//            make.height.mas_equalTo(30);
//            
//        }];
//        [self.guanzhula mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(self.guanzhulab.mas_bottom);
//            make.left.mas_equalTo(self.zixunla.mas_right);
//            make.width.mas_equalTo(kWidth/3);
//            make.height.mas_equalTo(15);
//        }];
//
//        
//        [self.lastView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(self.zonghela.mas_bottom).with.offset(8);
//            make.left.mas_equalTo(self.doctorView.mas_left);
//            make.width.mas_equalTo(kWidth);
//            make.bottom.mas_equalTo(self.view.mas_bottom);
//            
//        }];
//        
//        [self.detailLbl mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(self.lastView.mas_top);
//            make.left.mas_equalTo(self.doctorView.mas_left).with.offset(10);
//            make.width.mas_equalTo(80);
//            make.height.mas_equalTo(30);
//        }];
//        
//        [self.detailtab mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(self.detailLbl.mas_bottom);
//            make.left.mas_equalTo(self.doctorView.mas_left);
//            make.width.mas_equalTo(kWidth);
//            make.bottom.mas_equalTo(self.doctorView.mas_bottom);
//        }];
//
//    }
    
}



-(void)zizhiAction
{
    UploadCerViewController *vc = [[UploadCerViewController alloc] init];
    vc.isUpload = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
}

-(void)shenheAction
{
    UploadCerViewController *vc = [[UploadCerViewController alloc] init];
    vc.isUpload = NO;
    [self.navigationController pushViewController:vc animated:YES];

}
-(void)shimingAction
{
    ZHMterialViewController *vc = [[ZHMterialViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}

-(void)firstClickleft{

    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];

}

-(void)firstClickright{
    
//    UIAlertController * alertController = [UIAlertController alertControllerWithTitle: @"请完成资质认证后再做操作"
//                                                                              message: @""
//                                                                       preferredStyle:UIAlertControllerStyleAlert];
//    [alertController addAction:[UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//        
//        
//    }]];
//    [self presentViewController:alertController animated:YES completion:nil];
    if ([MethodUtil isIdentification]==NO) {
        [YJProgressHUD showSuccess:@"请完成资质认证后再做操作" inview:self.view];
        return;
    }
    AlertViewController *vc = [[AlertViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





@end
