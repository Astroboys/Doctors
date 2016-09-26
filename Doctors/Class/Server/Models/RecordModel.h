//
//  RecordModel.h
//  Doctors
//
//  Created by 崔敬轩 on 16/9/25.
//  Copyright © 2016年 XueHuiWang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecordModel : NSObject

@property(nonatomic,strong) NSString*name;
@property(nonatomic,strong)NSString*postImageName;
@property (nonatomic, strong) NSString *hospitalName;
@property (nonatomic, strong) NSString *hosContentName;
@property(nonatomic,strong)NSString*recordTime;
@property (nonatomic, strong) NSString *timeContentName;


@end
