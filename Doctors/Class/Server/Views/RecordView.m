//
//  RecordView.m
//  Doctors
//
//  Created by 崔敬轩 on 16/9/26.
//  Copyright © 2016年 XueHuiWang. All rights reserved.
//

#import "RecordView.h"
#import "UIView+Frame.h"
#import "RecordViewCell.h"
#import "MoreActionView.h"
static NSString *ID=@"cell";

@interface RecordView()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *dataArray;
}
@property(nonatomic,strong)UITableView*diatabView;

@property(nonatomic,strong)NSArray*dataArr;
@end

@implementation RecordView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self setupUI];
    }
    return self;
}
-(void)setCustomId:(NSString *)customId
{
    _customId = customId;
    if (self.customId.intValue>0) {
        NSDictionary *dic = @{@"customerId":customId,@"doctorId":[UConfig getDoctorId]};
        NSString *url = [NSString stringWithFormat:@"%@%@",BaseUrl,@"app/archives/appindex"];
        
        dispatch_queue_t record = dispatch_queue_create("record", NULL);
        
        dispatch_async(record, ^{
            [NetWorkingManager requestGETDataWithPath:url withParamters:dic withProgress:^(float progress) {
                
            } success:^(BOOL isSuccess, id responseObject) {
                NSLog(@"%@",responseObject);
                if ([responseObject isKindOfClass:[NSDictionary class]]) {
                    NSString *checkCodeStr = responseObject[@"code"];
                    if (checkCodeStr.intValue == 200) {
                        dataArray = responseObject[@"data"];
                        
                        [_diatabView reloadData];
                    }
                    
                }
            } failure:^(NSError *error) {
                NSLog(@"%@",error.userInfo);
                
            }];

        });
        
        

        
    }
    
}

-(void)setupUI{

    self.backgroundColor=[UIColor brownColor];
    
    _diatabView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0 , kWidth, KscViewH-35) style:UITableViewStylePlain];
    
    [_diatabView registerClass:[RecordViewCell class] forCellReuseIdentifier:ID];
    
    _diatabView.delegate=self;
    _diatabView.dataSource=self;
    
    [self addSubview:_diatabView];

}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return dataArray.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    RecordViewCell*cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        
        cell=[[RecordViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    RecordModel*model = [[RecordModel alloc]init];
    NSDictionary *dic = dataArray[indexPath.row];
    NSString *typeStr = dic[@"archivesType"];
    if (typeStr.intValue == 1) {
        model.name= @"电子病历";
        model.recordTime=@"就诊时间";
        model.hospitalName=@"就诊医院";
    }else{
        model.name= @"健康报告";
        model.recordTime=@"测量时间";
        model.hospitalName=@"测量医院";

    }
    
    model.postImageName=dic[@"uploadUrl"];
    
    
    model.hosContentName=dic[@"hospital"];
    model.timeContentName=dic[@"recordTime"];
    
    [cell RecordViewCellWithObject:model];
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 140;
}

- (NSArray *)dataArr {
    if(_dataArr == nil) {
        
        _dataArr=@[@"dd",@"ss",@"ddss",@"dd",@"ss",@"ddss",@"dd",@"ss"];
        
    }
    return _dataArr;
}



@end
