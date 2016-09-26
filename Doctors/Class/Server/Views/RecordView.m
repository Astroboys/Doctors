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

static NSString *ID=@"cell";

@interface RecordView()<UITableViewDelegate,UITableViewDataSource>

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
    
    return 8;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    RecordViewCell*cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        
        cell=[[RecordViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    RecordModel*model = [[RecordModel alloc]init];
    
    model.name= @"电子病历";
    model.postImageName=@"时间";
    model.recordTime=@"测量时间";
    model.hospitalName=@"就诊医院";
    model.hosContentName=@"海淀医院";
    model.timeContentName=@"2013-10-1 10:00";
    
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
