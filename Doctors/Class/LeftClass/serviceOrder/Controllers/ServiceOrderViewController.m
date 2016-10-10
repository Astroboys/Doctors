//
//  ServiceOrderViewController.m
//  Doctors
//
//  Created by zhonghe on 16/10/2.
//  Copyright © 2016年 XueHuiWang. All rights reserved.
//

#import "ServiceOrderViewController.h"
#import "ServiceOrderTableViewCell.h"
#import "NTESSessionViewController.h"
#import "MJRefresh.h"

@interface ServiceOrderViewController ()<UITableViewDelegate,UITableViewDataSource,ServiceOrderCellDelegate>
{
    UITableView *serviceTab;
    NSArray *serviceArray;
}
@end

@implementation ServiceOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = DWColor(243, 243, 243);
    
    
    self.title = @"服务订单";
    
    

    
    // Do any additional setup after loading the view.
    serviceTab=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kWidth, kHeight-64)];
    serviceTab.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
    serviceTab.separatorColor = [UIColor clearColor];
    serviceTab.backgroundColor = [UIColor clearColor];
    [self.view addSubview:serviceTab];
    
    serviceTab.delegate=self;
    serviceTab.dataSource=self;
    
    
    [serviceTab addHeaderWithTarget:self action:@selector(loadData)];
    [serviceTab headerBeginRefreshing];

}

-(void)loadData
{
    NSDictionary *dic = @{@"doctorId":[UConfig getDoctorId]};
    [NetWorkingManager requestGETDataWithPath:[NSString stringWithFormat:@"%@%@",BaseUrl,@"app/reserve/index"] withParamters:dic withProgress:nil success:^(BOOL isSuccess, id responseObject) {
        //200登陆成功，201登陆成功未认证
        [serviceTab headerEndRefreshing];
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSString *code = responseObject[@"code"];
            if (code.intValue == 200) {
                if ([responseObject[@"data"] isKindOfClass:[NSArray class]]) {
                    serviceArray = responseObject[@"data"];
                    [serviceTab reloadData];
                }
            }else if (code.intValue == 201){
                
                
            }else{
            }
            NSLog(@"%@",responseObject);
            
        }
        
    } failure:^(NSError *error) {
        [serviceTab headerEndRefreshing];
    }];

}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return serviceArray.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString *ID=@"serviceOrderCell";
    ServiceOrderTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell=[[ServiceOrderTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    cell.delegate =self;
    cell.backgroundColor = [UIColor clearColor];

    cell.dic = serviceArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 194;
}

-(void)clickCheckBtn:(NSDictionary *)dict
{
    //创建session,这里聊天对象预设为韩梅梅，此账号也是事先提交到此App下的
    NIMSession *session = [NIMSession session:dict[@"memPhone"] type:NIMSessionTypeP2P];
    //创建聊天页，这个页面继承自 NIMKit 中的组件 NIMSessionViewController
    NTESSessionViewController *vc = [[NTESSessionViewController alloc] initWithSession:session];
    [self.navigationController pushViewController:vc animated:YES];
   
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
