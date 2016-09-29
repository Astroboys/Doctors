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

@interface ZHServerViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView*infotab;

@property(nonatomic,strong)NSMutableArray*dataArr;

@end

@implementation ZHServerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = DWColor(243, 243, 243);
    self.navigationItem.title=@"健康屋";
    
    UIImage* image1 = [UIImage imageNamed:@"navigationbar_pop"];
    image1 = [image1 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIBarButtonItem* item1 = [[UIBarButtonItem alloc]initWithImage:image1 style:UIBarButtonItemStylePlain target:self action:@selector(serverClickleft)];
    
    self.navigationItem.leftBarButtonItem=item1;
    
    
    _infotab=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kWidth, kHeight-44-64) style:UITableViewStylePlain];
    
    _infotab.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
    
    _infotab.delegate=self;
    _infotab.dataSource=self;
    [self.view addSubview:_infotab];
    
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 8;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *ID=@"cell";
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        
    }
    
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
   
    cell.textLabel.textColor = [UIColor colorWithRed:85/255.0 green:85/255.0 blue:85/255.0 alpha:1];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.imageView.image=[UIImage imageNamed:@"healthIcon"];
    int random=arc4random_uniform(3);
    cell.textLabel.text=self.dataArr[random][0];
    cell.detailTextLabel.numberOfLines=0;
    cell.detailTextLabel.textColor = [UIColor colorWithRed:149/255.0 green:149/255.0 blue:149/255.0 alpha:1];
    cell.detailTextLabel.text=self.dataArr[random][1];
    cell.detailTextLabel.numberOfLines = 1;
    cell.detailTextLabel.font = [UIFont systemFontOfSize:13];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
    cell.accessoryView = imageView;
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ZHVipInfoViewController*vipInfoVc=[[ZHVipInfoViewController alloc]init];
    
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

- (NSMutableArray *)dataArr {
    if(_dataArr == nil) {
        _dataArr = [NSMutableArray array];
        NSArray *first=@[@"陈金明",@"先天性心脏病、风湿性心脏病、高血压sadfasdfasdfasdfsdfasdfasdfasdfasdfasd"];
        NSArray *second=@[@"李国庆",@"先心病、冠心病、房颤以及各种心脏病"];
        NSArray *third=@[@"张立群",@"糖尿病1型"];
        [_dataArr addObject:first];
        [_dataArr addObject:second];
        [_dataArr addObject:third];
    }
    return _dataArr;
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
