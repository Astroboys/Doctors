//
//  DiagnoseView.m
//  Doctors
//
//  Created by 崔敬轩 on 16/9/26.
//  Copyright © 2016年 XueHuiWang. All rights reserved.
//

#import "DiagnoseView.h"
#import "DiagnoseTableViewCell.h"
#import "UIView+Frame.h"

static NSString *ID=@"cell";

@interface DiagnoseView()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *dataArray;
}
@property(nonatomic,strong)UITableView*diatabView;

@property(nonatomic,strong)NSArray*dataArr;

@end

@implementation DiagnoseView

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
        NSDictionary *dic = @{@"customerId":customId};
        
        
        dispatch_queue_t diagnose = dispatch_queue_create("diagnose", NULL);

        dispatch_async(diagnose, ^{
            [NetWorkingManager requestGETDataWithPath:[NSString stringWithFormat:@"%@%@",BaseUrl,@"app/consult/allotCustToDoc"] withParamters:dic withProgress:^(float progress) {
                
            } success:^(BOOL isSuccess, id responseObject) {
                
                if ([responseObject isKindOfClass:[NSDictionary class]]) {
                    if ([responseObject[@"data"] isKindOfClass:[NSArray class]]) {
                        dataArray = responseObject[@"data"];
                        [_diatabView reloadData];
                    }
                }
                NSLog(@"%@",responseObject);
            } failure:^(NSError *error) {
                NSLog(@"%@",error);
            }];

        });
        
        
        
    }

}
-(void)setupUI{

    self.backgroundColor=[UIColor lightGrayColor];
    
    _diatabView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kWidth, KscViewH-35) style:UITableViewStylePlain];
    
    [_diatabView registerClass:[DiagnoseTableViewCell class] forCellReuseIdentifier:ID];
    
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
    
    
    DiagnoseTableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        
        cell=[[DiagnoseTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSDictionary *dic = dataArray[indexPath.row];
    
    DiagnoseModel*model = [[DiagnoseModel alloc]init];
    
//    model.title = @"已回复";
    model.timeImagename=@"timeIcon";
    model.time=dic[@"createTime"];
    model.consultTopic=dic[@"question"];
    model.consult=@"向您咨询:";
    
    [cell DiagnoseTableViewCellWithObject:model];
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 100;
    }

- (NSArray *)dataArr {
    if(_dataArr == nil) {
        
        _dataArr=@[@"dd",@"ss",@"ddss",@"dd",@"ss",@"ddss",@"dd",@"ss"];
        
    }
    return _dataArr;
}


@end
