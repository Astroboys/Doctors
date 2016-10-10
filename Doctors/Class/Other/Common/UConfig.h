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



+(void)setVerifyStatus:(NSInteger)status;
+(NSInteger)getVerifyStatus;


+(void)setPersonInfo:(NSDictionary *)personInfo;
+(NSDictionary *)getPersonInfo;


+(void)setDoctorId:(NSString *)doctorId;
+(NSString *)getDoctorId;

+(void)logoutInfomation;

+(void)setWelcome:(BOOL)welCome;
+(BOOL)getWelcome;
+(void)setPhotoUrl:(NSString *)photoStr;
+(NSString *)getPhotoUrl;


+(void)setUnreadCount:(NSInteger)unreadCount;
+(NSInteger)getUnreadCount;
@end
