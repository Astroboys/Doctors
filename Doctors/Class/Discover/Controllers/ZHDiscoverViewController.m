//
//  ZHDiscoverViewController.m
//  Doctors
//
//  Created by 崔敬轩 on 16/8/22.
//  Copyright © 2016年 崔敬轩. All rights reserved.
//

#import "ZHDiscoverViewController.h"
#import "UIViewController+MMDrawerController.h"
#import "HealthycircleCell.h"
#import "ZHAddCircleViewController.h"
static NSString *ID=@"cell";

@interface ZHDiscoverViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic)UITableView*circleTabView;
@property(nonatomic,strong)NSMutableArray*dataArr;
@property(nonatomic,strong)NSMutableArray*dataTopicArr;
@property(nonatomic,strong)NSMutableArray*dataTimeArr;
@property(nonatomic,strong)UISearchBar*searchCircle;

@end

@implementation ZHDiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor redColor];
    
    self.navigationItem.title=@"健康圈";
    UIImage* image1 = [UIImage imageNamed:@"navigationbar_pop"];
    image1 = [image1 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIImage* image2 = [UIImage imageNamed:@"添加"];
    image2 = [image2 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIBarButtonItem* leftItem = [[UIBarButtonItem alloc]initWithImage:image1 style:UIBarButtonItemStylePlain target:self action:@selector(discoverClickLeft)];
    
    self.navigationItem.leftBarButtonItem=leftItem;

    UIBarButtonItem*rightItem=[[UIBarButtonItem alloc]initWithImage:image2 style:UIBarButtonItemStylePlain target:self action:@selector(discoverClickRight)];

    self.navigationItem.rightBarButtonItem=rightItem;
    
     [self setupUI];
    
}


-(void)discoverClickLeft{
    
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];

}
//添加圈子
-(void)discoverClickRight{

    ZHAddCircleViewController*addVc=[[ZHAddCircleViewController alloc]init];
    
    [self.navigationController pushViewController:addVc animated:YES];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}
-(void)setupUI{
    
    _searchCircle=[[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, kWidth, 40)];
    [self.view addSubview:_searchCircle];

    _circleTabView=[[UITableView alloc]initWithFrame:CGRectMake(0, 40, kWidth, kHeight-44-64) style:UITableViewStylePlain];
    _circleTabView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
    [_circleTabView registerClass:[HealthycircleCell class] forCellReuseIdentifier:ID];
    [self.view addSubview:_circleTabView];
    
    _circleTabView.delegate=self;
    _circleTabView.dataSource=self;

}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.dataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
     HealthycircleCell*cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        
        cell=[[HealthycircleCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    
    }
    HealthycircleModel*model=[[HealthycircleModel alloc]init];
    
    model.circleImage=@"健康圈默认";
    model.name=self.dataArr[indexPath.row];
    model.time=self.dataTimeArr[indexPath.row];
    model.topic=self.dataTopicArr[indexPath.row];
   
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    [cell HealthycircleCellWithObject:model];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (isiPhone4) {
        
        return 50;
    }else if (isiPhone5){
        
        return 70;
    }else if (isiPhone6){
        
        return 70;
        
    }else{
        
        return 70;
    }
}

- (NSMutableArray *)dataArr {
    if(_dataArr == nil) {
        _dataArr = [NSMutableArray array];
        _dataArr =[NSMutableArray arrayWithObjects:@"张鸣的健康圈",@"李文琦的健康圈",@"李菊的健康圈",@"张米七的朋友圈",@"李克勤的健康圈",@"鹿鹿的健康圈",@"赵南起的健康圈",@"美琳的健康圈",@"张泽的健康圈", nil];
    }
    return _dataArr;
}

- (NSMutableArray *)dataTopicArr {
    if(_dataTopicArr == nil) {
        _dataTopicArr = [NSMutableArray array];
        _dataTopicArr =[NSMutableArray arrayWithObjects:@"治疗中风引起的头痛",@"希望大家踊跃加入",@"类风湿、关节痛",@"四肢麻木、心血管疾病",@"还没有发表内容",@"类风湿、关节痛",@"四肢功能性恢复",@"治疗耳聋耳鸣",@"内科疾病", nil];
    }
    return _dataTopicArr;
}

- (NSMutableArray *)dataTimeArr {
    if(_dataTimeArr == nil) {
        _dataTimeArr = [NSMutableArray array];
        _dataTimeArr =[NSMutableArray arrayWithObjects:@"2012-09-09 ",@"2012-02-05",@"2012-10-25",@"2012-10-22",@"2012-10-15",@"2012-10-13",@"2012-10-16",@"2012-10-11",@"2012-10-14", nil];
    }
    return _dataTimeArr;
}


@end

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


