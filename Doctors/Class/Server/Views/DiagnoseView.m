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

-(void)setupUI{

    self.backgroundColor=[UIColor lightGrayColor];
    
    _diatabView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kWidth, KscViewH) style:UITableViewStylePlain];
    
    [_diatabView registerClass:[DiagnoseTableViewCell class] forCellReuseIdentifier:ID];
    
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
    
    
    DiagnoseTableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        
        cell=[[DiagnoseTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    DiagnoseModel*model = [[DiagnoseModel alloc]init];
    
    model.title = @"已回复";
    model.timeImagename=@"时间";
    model.time=@"12:00";
    model.consultTopic=@"最近腿有点痛，心脏不适，严重";
    model.consult=@"向您咨询:";
    
    [cell DiagnoseTableViewCellWithObject:model];
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (isiPhone4) {
        
        return 40;
        
    }else if (isiPhone5){
        
        return 100;
        
    }else if (isiPhone6){
        
        return 100;
        
    }else{
        
        return 100;
    }
}

- (NSArray *)dataArr {
    if(_dataArr == nil) {
        
        _dataArr=@[@"dd",@"ss",@"ddss",@"dd",@"ss",@"ddss",@"dd",@"ss"];
        
    }
    return _dataArr;
}


@end
