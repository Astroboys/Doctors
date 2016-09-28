//
//  MethodUtil.h
//  SMSDistinguishSDK
//
//  Created by ZQ on 16/4/11.
//  Copyright © 2016年 ZQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MethodUtil : NSObject
//获取时间戳
+(long)getCurrentTime;

+(BOOL)isConnectNetwork;

+(NSString *)exist:(NSString *)str;

+(NSString *)getNumberWithString:(NSString *)originalString;

+(BOOL)isCorrect:(NSString *)IDNumber;//身份证号是否合法


//获取时间戳的方法
+ (NSString *)getCurrentTimestamp;
+ (NSString *)getTimestampWithDate:(NSDate *)date;

+(BOOL)isMobileNumber:(NSString *)num;


+(NSString *)getLocationTime;//获取当前时间

+(NSString *)locationTimeChangeTimeTip:(NSString *)timeStr;//获取时间差

//log存储
void SMS_Log(NSString *format, ...);


+(void)cleanUploadedAppLog;
//合并日志
+(NSString*) mergeLog;

@end
