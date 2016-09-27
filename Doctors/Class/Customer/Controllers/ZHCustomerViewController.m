
//
//  ZHCustomerViewController.m
//  Doctors
//
//  Created by 崔敬轩 on 16/8/18.
//  Copyright © 2016年 崔敬轩. All rights reserved.
//

#import "ZHCustomerViewController.h"
#import "UIViewController+MMDrawerController.h"
#import "CustomerViewCell.h"
#import "SessionViewController.h"
#import "NTESSessionViewController.h"

#define NIMMyAccount   @"lilei"
#define NIMMyToken     @"123456"
#define NIMChatTarget  @"hanmeimei"
static NSString *ID=@"cell";

@interface ZHCustomerViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView*customerView;
@property(nonatomic,strong)NSMutableArray*dataArr;
@property(nonatomic,strong)NSMutableArray*dataTopicArr;
@property(nonatomic,strong)NSMutableArray*dataTimeArr;

@end

@implementation ZHCustomerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=DWColor(243, 243, 243);
    self.navigationItem.title=@"客户";
    
    UIImage* image1 = [UIImage imageNamed:@"navigationbar_pop"];
    image1 = [image1 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIBarButtonItem* leftItem = [[UIBarButtonItem alloc]initWithImage:image1 style:UIBarButtonItemStylePlain target:self action:@selector(customerClickLeft)];
    
    self.navigationItem.leftBarButtonItem=leftItem;

    [self setupUI];
    
    }

-(void)customerClickLeft{

    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];

}

-(void)setupUI{

    _customerView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kWidth, kHeight-44-64) style:UITableViewStylePlain];
    _customerView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
    
    [_customerView registerClass:[CustomerViewCell class] forCellReuseIdentifier:ID];
    [self.view addSubview:_customerView];
    
    _customerView.delegate=self;
    _customerView.dataSource=self;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArr.count;
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    
    CustomerViewCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        
        cell=[[CustomerViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        
    }
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    
    CustomerModel*model=[[CustomerModel alloc]init];
    
    model.circleImage=@"healthIcon";
    model.name=self.dataArr[indexPath.row];
    model.time=self.dataTimeArr[indexPath.row];
    model.topic=self.dataTopicArr[indexPath.row];
    [cell CustomerViewCellWithObject:model];
    
    return cell;
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return YES;
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //更新数据
        [self.dataArr removeObjectAtIndex:indexPath.row];

        //更新UI
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    }else if (editingStyle == UITableViewCellEditingStyleInsert) {
        
        [self.dataArr addObject:@"123"];
        
        [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 80;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //跳转聊天页面
    //请将 NIMMyAccount 以及 NIMMyToken 替换成您自己提交到此App下的账号和密码
    [[NIMSDK sharedSDK].loginManager login:NIMMyAccount token:NIMMyToken completion:^(NSError *error) {
        if (!error) {
            NSLog(@"登录成功");
            //创建session,这里聊天对象预设为韩梅梅，此账号也是事先提交到此App下的
            NIMSession *session = [NIMSession session:NIMChatTarget type:NIMSessionTypeP2P];
            //创建聊天页，这个页面继承自 NIMKit 中的组件 NIMSessionViewController
            NTESSessionViewController *vc = [[NTESSessionViewController alloc] initWithSession:session];
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            NSLog(@"登录失败");
        }
    }];

    
}


- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}


- (NSMutableArray *)dataArr {
    if(_dataArr == nil) {
        _dataArr = [NSMutableArray array];
        _dataArr =[NSMutableArray arrayWithObjects:@"张鸣",@"李文琦",@"李菊",@"张米七",@"李克勤",@"鹿鹿",@"赵南起",@"美琳",@"张泽", nil];

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

- (void)didReceiveMemoryWarning {

    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
