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
    
    
    
    
    
    NSDictionary *dic = @{@"goodAt":@"高血压"};
    
//    
//    [NetWorkingManager sendPOSTDataWithPath:[NSString stringWithFormat:@"%@%@",BaseUrl,@"app/consult/allotCustToDoc"] withParamters:dic withProgress:^(float progress) {
//        
//    } success:^(BOOL isSuccess, id responseObject) {
//        NSLog(@"%@",responseObject);
//
//    } failure:^(NSError *error) {
//        
//    }];
    
    
    [NetWorkingManager requestGETDataWithPath:[NSString stringWithFormat:@"%@%@",BaseUrl,@"app/consult/allotCustToDoc"] withParamters:dic withProgress:^(float progress) {
        
    } success:^(BOOL isSuccess, id responseObject) {

        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            if ([responseObject[@"data"] isKindOfClass:[NSArray class]]) {
                dataArray = responseObject[@"data"];
                [_infotab reloadData];
            }
        }
        NSLog(@"%@",responseObject);
    } failure:^(NSError *error) {
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
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        
    }
    
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSDictionary *dic = dataArray[indexPath.row];
    cell.textLabel.textColor = [UIColor colorWithRed:85/255.0 green:85/255.0 blue:85/255.0 alpha:1];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:dic[@"portraitUrl"]] placeholderImage:[UIImage imageNamed:@"healthIcon"]];
    cell.textLabel.text=dic[@"name"];
    cell.detailTextLabel.numberOfLines=0;
    cell.detailTextLabel.textColor = [UIColor colorWithRed:149/255.0 green:149/255.0 blue:149/255.0 alpha:1];
    cell.detailTextLabel.text=dic[@"question"];
    cell.detailTextLabel.numberOfLines = 1;
    cell.detailTextLabel.font = [UIFont systemFontOfSize:13];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
    cell.accessoryView = imageView;
    
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
