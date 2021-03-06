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
#import "NTESSessionViewController.h"
#import "UIImageView+WebCache.h"
static NSString *ID=@"cell";

@interface ZHDiscoverViewController ()<UITableViewDataSource,UITableViewDelegate,NIMTeamManagerDelegate>

@property(nonatomic)UITableView*circleTabView;
@property (strong, nonatomic) NSMutableArray *myTeams;

@property(nonatomic,strong)NSMutableArray*dataArr;
@property(nonatomic,strong)NSMutableArray*dataTopicArr;
@property(nonatomic,strong)NSMutableArray*dataTimeArr;
//@property(nonatomic,strong)UISearchBar*searchCircle;

@end

@implementation ZHDiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=DWColor(243, 243, 243);
    
    self.navigationItem.title=@"健康圈";
    UIImage* image1 = [UIImage imageNamed:@"navigationbar_pop"];
    image1 = [image1 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIImage* image2 = [UIImage imageNamed:@"addcircle"];
    image2 = [image2 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIBarButtonItem* leftItem = [[UIBarButtonItem alloc]initWithImage:image1 style:UIBarButtonItemStylePlain target:self action:@selector(discoverClickLeft)];
    
    self.navigationItem.leftBarButtonItem=leftItem;

    UIBarButtonItem*rightItem=[[UIBarButtonItem alloc]initWithImage:image2 style:UIBarButtonItemStylePlain target:self action:@selector(discoverClickRight)];

    self.navigationItem.rightBarButtonItem=rightItem;
//    self.myTeams = [self fetchTeams];
    [self requestCircleData];
    [[NIMSDK sharedSDK].teamManager addDelegate:self];

     [self setupUI];
    
}
-(void)requestCircleData
{
    NSDictionary *dict = @{@"doctorId":[UConfig getDoctorId]};
    [NetWorkingManager requestGETDataWithPath:[NSString stringWithFormat:@"%@app/circle/index",BaseUrl] withParamters:dict withProgress:^(float progress){
        
    } success:^(BOOL isSuccess, id responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSString *codeStr = responseObject[@"code"];
            if (codeStr.intValue == 200) {
                if ([responseObject[@"data"] isKindOfClass:[NSArray class]]) {
                    self.myTeams = responseObject[@"data"];
                    [_circleTabView reloadData];

                }
               
            }
        }
    } failure:^(NSError *error) {
        
    }];
}
//- (NSMutableArray *)fetchTeams{
//    NSMutableArray *myTeams = [[NSMutableArray alloc]init];
//    for (NIMTeam *team in [NIMSDK sharedSDK].teamManager.allMyTeams) {
//        if (team.type == NIMTeamTypeAdvanced) {
//            [myTeams addObject:team];
//        }
//    }
//    return myTeams;
//}
- (void)onTeamAdded:(NIMTeam *)team{
//    if (team.type == NIMTeamTypeAdvanced) {
//        self.myTeams = [self fetchTeams];
//    }
//    [_circleTabView reloadData];
    
    
    [self requestCircleData];
}

- (void)onTeamUpdated:(NIMTeam *)team{
//    if (team.type == NIMTeamTypeAdvanced) {
//        self.myTeams = [self fetchTeams];
//    }
//    [_circleTabView reloadData];
    
    [self requestCircleData];
}


- (void)onTeamRemoved:(NIMTeam *)team{
//    if (team.type == NIMTeamTypeAdvanced) {
//        self.myTeams = [self fetchTeams];
//    }
//    [_circleTabView reloadData];
    [self requestCircleData];
}

-(void)discoverClickLeft{
    
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];

}
//添加圈子
-(void)discoverClickRight{

    if ([MethodUtil isIdentification]==NO) {
        [YJProgressHUD showSuccess:@"请完成资质认证后再做操作" inview:self.view];
        return;
    }
    ZHAddCircleViewController*addVc=[[ZHAddCircleViewController alloc]init];
    
    [self.navigationController pushViewController:addVc animated:YES];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}
-(void)setupUI{
    
//    _searchCircle=[[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, kWidth, 40)];
//    [self.view addSubview:_searchCircle];

    _circleTabView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kWidth, kHeight-44-64) style:UITableViewStylePlain];
    _circleTabView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
    [_circleTabView registerClass:[HealthycircleCell class] forCellReuseIdentifier:ID];
    _circleTabView.separatorColor = [UIColor clearColor];
    _circleTabView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_circleTabView];
    
    _circleTabView.delegate=self;
    _circleTabView.dataSource=self;

}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return _myTeams.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
     HealthycircleCell*cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        
        cell=[[HealthycircleCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    
    }
//    HealthycircleModel*model=[[HealthycircleModel alloc]init];
    
    
    NSDictionary *team = [_myTeams objectAtIndex:indexPath.row];
    cell.nameLabel.text = team[@"tname"];
    cell.topicLabel.text = team[@"intro"];
    cell.backgroundColor = [UIColor clearColor];
//    NSInteger timeValue = team.createTime;
//    cell.timeLabel.text = [MethodUtil timeWithTimeIntervalString:[NSString stringWithFormat:@"%ld",timeValue]];
    
    cell.timeLabel.text = team[@"createTime"];
    [cell.circleImage sd_setImageWithURL:[NSURL URLWithString:team[@"icon"]] placeholderImage:[UIImage imageNamed:@"indexIcon"]];
   
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    
//}

//- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return @"删除";
//}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 70;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSDictionary *team = [_myTeams objectAtIndex:indexPath.row];
    NIMSession *session = [NIMSession session:team[@"tid"] type:NIMSessionTypeTeam];
    NTESSessionViewController *vc = [[NTESSessionViewController alloc] initWithSession:session];
    [self.navigationController pushViewController:vc animated:YES];
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


