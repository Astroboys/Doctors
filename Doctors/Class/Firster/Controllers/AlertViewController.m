//
//  AlertViewController.m
//  Doctors
//
//  Created by zhonghe on 16/10/2.
//  Copyright © 2016年 XueHuiWang. All rights reserved.
//

#import "AlertViewController.h"
#import "AlertTableViewCell.h"
#import "NIMSystemNotification.h"
@interface AlertViewController()<UITableViewDelegate,UITableViewDataSource,AlertTableViewCellDelegate>
{
    UITableView *_diatabView;
    
    NSArray *dataArray;
}
@property(nonatomic,strong)NSArray *dataArr;
@end

@implementation AlertViewController

-(void)viewDidLoad{
    [super viewDidLoad];
//    dataArray = [NSArray array];
    id<NIMSystemNotificationManager> systemNotificationManager = [[NIMSDK sharedSDK] systemNotificationManager];
    
    dataArray = [systemNotificationManager fetchSystemNotifications:NIMSystemNotificationTypeTeamApply
                                                                                       limit:20];
    [systemNotificationManager markAllNotificationsAsRead];
    [UConfig setUnreadCount:0];
    //创建通知
    NSNotification *notification =[NSNotification notificationWithName:@"updatePhoto" object:nil userInfo:nil];
    //通过通知中心发送通知
    [[NSNotificationCenter defaultCenter] postNotification:notification];
    [self setupUI];
}
-(void)setupUI{
    
    self.view.backgroundColor=DWColor(243, 243, 243);
    
    _diatabView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0 , kWidth, kHeight) style:UITableViewStylePlain];
    
    _diatabView.separatorColor = [UIColor clearColor];
    _diatabView.backgroundColor = [UIColor clearColor];
    _diatabView.delegate=self;
    _diatabView.dataSource=self;
    
    [self.view addSubview:_diatabView];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return dataArray.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString *ID=@"cellIndentfier";
    AlertTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell=[[AlertTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    NIMSystemNotification *notification = dataArray[indexPath.row];
    cell.delegate = self;
    cell.notification = notification;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 70;
}

-(void)clickAgreeBtn:(NIMSystemNotification *)notification
{
    [[NIMSDK sharedSDK].teamManager passApplyToTeam:notification.targetID userId:notification.sourceID completion:^(NSError * _Nullable error, NIMTeamApplyStatus applyStatus) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //回调或者说是通知主线程刷新，
            id<NIMSystemNotificationManager> systemNotificationManager = [[NIMSDK sharedSDK] systemNotificationManager];
            [notification setHandleStatus:1];
        
            dataArray = [systemNotificationManager fetchSystemNotifications:NIMSystemNotificationTypeTeamApply
                                                                      limit:20];
            
            [_diatabView reloadData];
        }); 

        
        
    }];
    
    
 
}


@end
