//
//  JudgeView.m
//  Doctors
//
//  Created by 崔敬轩 on 16/9/26.
//  Copyright © 2016年 XueHuiWang. All rights reserved.
//

#import "JudgeView.h"
#import "UIImageView+WebCache.h"
#import "JudgeTableViewCell.h"
@interface JudgeView()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_diatabView;
    NSArray *dataArr;
}
@end

@implementation JudgeView

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
        NSDictionary *dic = @{@"doctorId":[UConfig getDoctorId],@"customerId":self.customId};
        NSString *url = [NSString stringWithFormat:@"%@%@",BaseUrl,@"app/consult/findDoctorCustomerConsults"];
        
        
        dispatch_queue_t judge = dispatch_queue_create("judge", NULL);

        dispatch_async(judge, ^{
            [NetWorkingManager requestGETDataWithPath:url withParamters:dic withProgress:^(float progress) {
                
            } success:^(BOOL isSuccess, id responseObject) {
                NSLog(@"%@",responseObject);
                if ([responseObject isKindOfClass:[NSDictionary class]]) {
                    NSString *checkCodeStr = responseObject[@"code"];
                    if (checkCodeStr.intValue == 200) {
                        dataArr = responseObject[@"data"];
                        
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
     _diatabView.tableFooterView = [[UIView alloc]init];
    
    _diatabView.delegate=self;
    _diatabView.dataSource=self;
    
    [self addSubview:_diatabView];
    
    
    
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return dataArr.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString *ID=@"cell";
    JudgeTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell=[[JudgeTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    
    [cell.photoView sd_setImageWithURL:[NSURL URLWithString:dataArr[indexPath.row][@"portraitUrl"]] placeholderImage:[UIImage imageNamed:@"healthIcon"]];
    cell.titleLab.text = dataArr[indexPath.row][@"customerName"];
   cell.detailLab.text = dataArr[indexPath.row][@"evaluation"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
     
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 70;
}



@end
