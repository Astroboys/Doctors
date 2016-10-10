//
//  ZHServerViewController.m
//  Doctors
//
//  Created by 崔敬轩 on 16/8/18.
//  Copyright © 2016年 崔敬轩. All rights reserved.
//

#import "ZHServerViewController.h"
#import "UIViewController+MMDrawerController.h"
#import "Masonry.h"
#import "ZHVipInfoViewController.h"
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"
#import "JudgeTableViewCell.h"
@interface ZHServerViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *dataArray;
}
@property(nonatomic,strong)UITableView*infotab;


@end

@implementation ZHServerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = DWColor(243, 243, 243);
    self.navigationItem.title=@"健康屋";
    
    
   //    [NetWorkingManager requestGETDataWithPath:[NSString stringWithFormat:@"%@%@",BaseUrl,@"app/consult/allotCustToDoc"] withParamters:dic withProgress:nil success:^(BOOL isSuccess, id responseObject) {
//        //200登陆成功，201登陆成功未认证
//        if ([responseObject isKindOfClass:[NSDictionary class]]) {
//            NSString *code = responseObject[@"code"];
//            if (code.intValue == 200) {
//                if ([responseObject[@"data"] isKindOfClass:[NSArray class]]) {
//                   
//                }
//            }else if (code.intValue == 201){
//                
//                
//            }else{
//            }
//            NSLog(@"%@",responseObject);
//            
//        }
//        
//    } failure:^(NSError *error) {
//    }];

    
    
    
    UIImage* image1 = [UIImage imageNamed:@"navigationbar_pop"];
    image1 = [image1 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIBarButtonItem* item1 = [[UIBarButtonItem alloc]initWithImage:image1 style:UIBarButtonItemStylePlain target:self action:@selector(serverClickleft)];
    
    self.navigationItem.leftBarButtonItem=item1;
    
    
    _infotab=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kWidth, kHeight-44-64) style:UITableViewStylePlain];
    
    _infotab.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
    
    _infotab.delegate=self;
    _infotab.dataSource=self;
    [self.view addSubview:_infotab];
    
    
    [_infotab addHeaderWithTarget:self action:@selector(loadData)];
    [_infotab headerBeginRefreshing];
    
//    
//    [NetWorkingManager sendPOSTDataWithPath:[NSString stringWithFormat:@"%@%@",BaseUrl,@"app/consult/allotCustToDoc"] withParamters:dic withProgress:^(float progress) {
//        
//    } success:^(BOOL isSuccess, id responseObject) {
//        NSLog(@"%@",responseObject);
//
//    } failure:^(NSError *error) {
//        
//    }];
    
    
    
    
    
    
}

-(void)loadData
{
    if ([MethodUtil isIdentification]==NO) {
        [YJProgressHUD showSuccess:@"请完成资质认证后再做操作" inview:self.view];
        [_infotab headerEndRefreshing];
        return;
    }
    NSDictionary *dic = @{@"goodAt":@"高血压"};

    [NetWorkingManager requestGETDataWithPath:[NSString stringWithFormat:@"%@%@",BaseUrl,@"app/consult/allotCustToDoc"] withParamters:dic withProgress:^(float progress) {
        
    } success:^(BOOL isSuccess, id responseObject) {
        [_infotab headerEndRefreshing];
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            if ([responseObject[@"data"] isKindOfClass:[NSArray class]]) {
                dataArray = responseObject[@"data"];
                [_infotab reloadData];
            }
        }
        NSLog(@"%@",responseObject);
    } failure:^(NSError *error) {
        [_infotab headerEndRefreshing];
        NSLog(@"%@",error);
    }];

}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *ID=@"cell";
    
    JudgeTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        
        cell=[[JudgeTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        
    }
    
    
     NSDictionary *dic = dataArray[indexPath.row];
    [cell.photoView sd_setImageWithURL:[NSURL URLWithString:dic[@"portraitUrl"]] placeholderImage:[UIImage imageNamed:@"healthIcon"]];
    cell.titleLab.text = dic[@"name"];
    cell.detailLab.text = dic[@"question"];
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
   
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ZHVipInfoViewController*vipInfoVc=[[ZHVipInfoViewController alloc]init];
    vipInfoVc.dataDic = dataArray[indexPath.row];
    [self.navigationController pushViewController:vipInfoVc animated:YES];

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (isiPhone4) {
        
        return 60;
    }else if (isiPhone5){
        
        return 70;
    }else if (isiPhone6){
        
        return 70;
        
    }else{
        
        return 80;
    }
}




-(void)serverClickleft{

    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
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
