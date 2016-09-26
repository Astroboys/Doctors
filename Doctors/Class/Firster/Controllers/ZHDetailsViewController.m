//
//  ZHDetailsViewController.m
//  Doctors
//
//  Created by 崔敬轩 on 16/9/18.
//  Copyright © 2016年 XueHuiWang. All rights reserved.
//

#import "ZHDetailsViewController.h"
#import "UIView+Frame.h"

@interface ZHDetailsViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *myTableview;
@property(nonatomic,strong)NSArray *dataArr;

@end

@implementation ZHDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor blueColor];
    
    _myTableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.w, self.view.h-44-64) style:UITableViewStylePlain];
    _myTableview.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    _myTableview.dataSource=self;
    _myTableview.delegate=self;

    [self.view addSubview:self.myTableview];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 7;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (isiPhone6P) {
        
        return 60;
        
    }else if (isiPhone6){
        
        return 50;
        
    }else if (isiPhone5){
        
        return 40;
        
    }else{
        
        return 30;
        
    }
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text=self.dataArr[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}


-(NSArray *)dataArr{
    
    if(_dataArr == nil) {
        _dataArr = @[@"全部课程",@"人力资源",@"心理咨询",@"公共营养",@"金融财会",@"营销经济",@"自考"];
    }
    return _dataArr;
    
}

@end
