//
//  UConfig.h
//  LifeNumber
//
//  Created by ZQ on 15/12/4.
//  Copyright © 2015年 leonBreeze. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UConfig : NSObject

//设置登录码
+(void)setLoginNumber:(NSString *)loginNumber;
+(NSString *)getLoginNumber;


+(void)setLoginToken:(NSString *)loginToken;
+(NSString *)getLoginToken;



+(void)setLoginCode:(NSString *)loginCode;
+(NSString *)getLoginCode;

@end
