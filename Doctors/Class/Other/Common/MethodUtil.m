//
//  MethodUtil.m
//  SMSDistinguishSDK
//
//  Created by ZQ on 16/4/11.
//  Copyright © 2016年 ZQ. All rights reserved.
//

#import "MethodUtil.h"
#include <sys/time.h>
#import "zlib.h"
#import "Reachability.h"
#include <pthread.h>

NSObject* gLogLock=nil;
FILE* ghSMSLog=NULL;
@implementation MethodUtil

+(BOOL)isConnectNetwork
{
    Reachability *r = [Reachability reachabilityWithHostName:@"www.apple.com"];
    if ([r currentReachabilityStatus] == NotReachable) {
        return NO;
    }
    
    return YES;
    
}


//获取时间戳
+(long)getCurrentTime
{
    struct timeval tv;
    gettimeofday(&tv,NULL);
    return tv.tv_sec * 1000 + tv.tv_usec / 1000;
}

+(NSString *)exist:(NSString *)str
{
    NSString *strs = [NSString stringWithFormat:@"%@",str];
    if ([strs isEqualToString:@"<null>"] || !strs ||[strs isEqualToString:@"(null)"])
        return @"";
    else
        return strs;
}


//获取数字
+(NSString *)getNumberWithString:(NSString *)originalString
{
    // Intermediate
    NSMutableString *numberString = [[NSMutableString alloc] init];
    NSString *tempStr;
    NSScanner *scanner = [NSScanner scannerWithString:originalString];
    NSCharacterSet *numbers = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    
    while (![scanner isAtEnd]) {
        // Throw away characters before the first number.
        [scanner scanUpToCharactersFromSet:numbers intoString:NULL];
        
        // Collect numbers.
        [scanner scanCharactersFromSet:numbers intoString:&tempStr];
        [numberString appendString:tempStr];
        tempStr = @"";
    }
    // Result.
    
    
    return  [NSString stringWithFormat:@"%@",numberString];
    
}

+ (NSString *)getCurrentTimestamp
{
    NSDate *date = [NSDate date];
    return [NSString stringWithFormat:@"%f",[date timeIntervalSince1970]];
}
+ (NSString *)getTimestampWithDate:(NSDate *)date
{
    return [NSString stringWithFormat:@"%f",[date timeIntervalSince1970]];
}


+(NSString *)getLocationTime
{
    NSDate *  senddate=[NSDate date];
    
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    
    [dateformatter setDateFormat:@"YYYYMMddHHmmss"];
    
    NSString *  locationString=[dateformatter stringFromDate:senddate];
    
    return locationString;
}

+(NSString *)locationTimeChangeTimeTip:(NSString *)timeStr
{
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setLocale:[NSLocale currentLocale]];
    [outputFormatter setDateFormat:@"YYYYMMddHHmmss"];
    
    NSDate* inputDate = [outputFormatter dateFromString:timeStr];
//    NSString *str = [outputFormatter stringFromDate:inputDate];
    
    NSString *str = [NSString stringWithFormat:@"%ld", (long)[inputDate timeIntervalSince1970]];
    return str;
}

+(NSString *)getNowTime
{
    NSDate *  senddate=[NSDate date];
    
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    
    [dateformatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    
    NSString *  locationString=[dateformatter stringFromDate:senddate];
    
    return locationString;
}



+(BOOL)isMobileNumber:(NSString *)num
{
    
    
    //    电信号段:133/153/180/181/189/177
    //    联通号段:130/131/132/155/156/185/186/145/176
    //    移动号段:134/135/136/137/138/139/150/151/152/157/158/159/182/183/184/187/188/147/178
    //    虚拟运营商:170
    
    NSString *MOBILE = @"^1(3[0-9]|4[579]|5[0-35-9]|8[0-9]|7[0135-8])\\d{8}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    return [regextestmobile evaluateWithObject:num];
}




+(void)cleanUploadedAppLog
{
    if(!gLogLock)
        gLogLock=[NSObject new];
    @synchronized(gLogLock){
        if(ghSMSLog){
            fclose(ghSMSLog);
            ghSMSLog=NULL;
        }
        NSString * todaylog = [MethodUtil logFullNameSinceToday:0];
        NSString * yesterdaylog = [MethodUtil logFullNameSinceToday:-1];
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        [fileManager removeItemAtPath:todaylog error:nil];
        [fileManager removeItemAtPath:yesterdaylog error:nil];
    }
}
+(NSString*) logFullNameSinceToday:(int) days
{
    NSString* dayString = [MethodUtil dayStringSinceToday:days];
    NSString* logDir = [MethodUtil logDir];
    return [logDir stringByAppendingPathComponent:
            [NSString stringWithFormat:@"%@.txt",dayString]];
}
+(NSString*) dayStringSinceToday:(int) days
{
    NSDate* date = [NSDate dateWithTimeIntervalSinceNow:days*86400];
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYYMMdd"];
    return [dateformatter stringFromDate:date];
}

+(NSString*) logDir
{
    return [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject
             stringByAppendingPathComponent:[NSString stringWithFormat:@"SMS_SDK"]] stringByAppendingPathComponent:[NSString stringWithFormat:@"LOG"]];
}


FOUNDATION_EXTERN void SMS_Log(NSString *format, ...)
{
    va_list va;
    va_start(va, format);

    if(!gLogLock){
        gLogLock = [NSObject new];
    }
    @synchronized(gLogLock){
        
        // 文件未打开则打开
        if(!ghSMSLog){
            
            
            // 文件或路径不存在则创建
            NSFileManager *fileManager = [NSFileManager defaultManager];
            NSString * path = [MethodUtil logFullNameSinceToday:0];
            if(![fileManager fileExistsAtPath:path])
            {
                NSString* logDir = [MethodUtil logDir];
                if (![fileManager fileExistsAtPath:logDir]) {
                    [fileManager createDirectoryAtPath:logDir
                           withIntermediateDirectories:YES attributes:nil error:nil];
                }
                [fileManager createFileAtPath:path contents:nil attributes:nil];
            }

            
            // 将log输入到文件
            ghSMSLog = fopen([path cStringUsingEncoding:NSUTF8StringEncoding], "a");

        }
        
        if(ghSMSLog){
            
            //线程id
            mach_port_t machTID = pthread_mach_thread_np(pthread_self());
            NSString* hdr=[NSString stringWithFormat:@"%@|%04x|",[MethodUtil getNowTime],machTID];
            
            NSData *hdrdata=[hdr dataUsingEncoding:NSUTF8StringEncoding];
            fwrite(hdrdata.bytes, 1, hdrdata.length, ghSMSLog);
            
            NSString* body=[[NSString alloc]initWithFormat:format arguments:va];
            NSData *bodydata=[body dataUsingEncoding:NSUTF8StringEncoding];
            fwrite(bodydata.bytes,1,bodydata.length,ghSMSLog);
            
            if([format hasSuffix:@"\n"]==NO)
                fwrite("\n", 1, 1, ghSMSLog);
            fflush(ghSMSLog);
        }
    }
}

//合并日志
+(NSString*) mergeLog
{
    [MethodUtil cleanExpiredLog];

    NSString *todayLogFile = [MethodUtil logFullNameSinceToday:0];
    NSString *yesterdayLogFile = [MethodUtil logFullNameSinceToday:-1];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    BOOL isYesterdayExist = [fileManager fileExistsAtPath:yesterdayLogFile];
    BOOL isTodayExist = [fileManager fileExistsAtPath:todayLogFile];
    
    if(isTodayExist) {
        //规避日志最后一行上传不全，丢失12个字符的bug
        
        if(isYesterdayExist) {
            NSFileHandle * infile, *outfile;
            infile = [NSFileHandle fileHandleForWritingAtPath:yesterdayLogFile];
            outfile = [NSFileHandle fileHandleForReadingAtPath:todayLogFile];
            //日志存在的情况下，将日志合并
            [infile seekToEndOfFile];
            NSData *buffer;
            buffer = [outfile readDataToEndOfFile];
            [infile writeData:buffer];
            [infile  closeFile];
            [outfile closeFile];
            [fileManager removeItemAtPath:todayLogFile error:nil];
            [fileManager moveItemAtPath:yesterdayLogFile toPath:todayLogFile error:nil];
        }
        return todayLogFile;
    }
    else if(isYesterdayExist) {
        return yesterdayLogFile;
    }
    else {
        return  nil;
    }
}
//退出登录的时候删除两天外log
+(void)cleanExpiredLog
{
    if(!gLogLock)
        gLogLock = [NSObject new];
    
    @synchronized(gLogLock) {
        
        NSString * today = [MethodUtil dayStringSinceToday:0];
        NSString * yesterday = [MethodUtil dayStringSinceToday:-1];
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSString *logDir = [MethodUtil logDir];
        NSArray *array = [fileManager contentsOfDirectoryAtPath:logDir error:nil];
        for(NSString *p in array) {
            NSString * filepath = [logDir stringByAppendingPathComponent:p];
            BOOL isDic = NO;
            if([fileManager fileExistsAtPath:filepath isDirectory:&isDic]) {
                if(!isDic) {
                    NSString* name = [p substringToIndex:8];
                    if ([name isEqualToString:today] ||[name isEqualToString:yesterday]) {
                        continue;
                    }
                    else {
                        // 名称和最近两天不符的删除
                        [fileManager removeItemAtPath:filepath error:nil];
                    }
                }
            }
        }
    }
    
}

+(BOOL)isCorrect:(NSString *)IDNumber
{
    NSMutableArray *IDArray = [NSMutableArray array];
    // 遍历身份证字符串,存入数组中
    for (int i = 0; i < 18; i++) {
        NSRange range = NSMakeRange(i, 1);
        NSString *subString = [IDNumber substringWithRange:range];
        [IDArray addObject:subString];
    }
    // 系数数组
    NSArray *coefficientArray = [NSArray arrayWithObjects:@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2", nil];
    // 余数数组
    NSArray *remainderArray = [NSArray arrayWithObjects:@"1", @"0", @"X", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2", nil];
    // 每一位身份证号码和对应系数相乘之后相加所得的和
    int sum = 0;
    for (int i = 0; i < 17; i++) {
        int coefficient = [coefficientArray[i] intValue];
        int ID = [IDArray[i] intValue];
        sum += coefficient * ID;
    }
    // 这个和除以11的余数对应的数
    NSString *str = remainderArray[(sum % 11)];
    // 身份证号码最后一位
    NSString *string = [IDNumber substringFromIndex:17];
    // 如果这个数字和身份证最后一位相同,则符合国家标准,返回YES
    if ([str isEqualToString:string]) {
        return YES;
    } else {
        return NO;
    }
}

@end
