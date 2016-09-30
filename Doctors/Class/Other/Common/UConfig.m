//
//  UConfig.m
//  LifeNumber
//
//  Created by ZQ on 15/12/4.
//  Copyright © 2015年 leonBreeze. All rights reserved.
//

#import "UConfig.h"

@implementation UConfig
+(void)setLoginNumber:(NSString *)loginNumber
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:loginNumber forKey:@"LNLoginNum"];
    [userDefault synchronize];//登录号
}
+(NSString *)getLoginNumber
{
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    NSString *str = [userDef objectForKey:@"LNLoginNum"];
    return str;
}

+(void)setLoginToken:(NSString *)loginToken
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:loginToken forKey:@"LNLoginToken"];
    [userDefault synchronize];
}
+(NSString *)getLoginToken
{
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    NSString *str = [userDef objectForKey:@"LNLoginToken"];
    return str;
}


+(void)setPersonInfo:(NSDictionary *)personInfo
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:personInfo forKey:@"LNPersonInfo"];
    [userDefault synchronize];
}

+(NSDictionary *)getPersonInfo
{
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    NSDictionary *dic = [userDef objectForKey:@"LNPersonInfo"];
    return dic;
}

+(void)setLoginCode:(NSString *)loginCode
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:loginCode forKey:@"LNLoginCode"];
    [userDefault synchronize];

}
+(NSString *)getLoginCode
{
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    NSString *str = [userDef objectForKey:@"LNLoginCode"];
    return str;

}
////IM登录状态
//+(void)setIMLoginState:(BOOL)state
//{
//    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
//    [userDefault setBool:state forKey:@"LN_IMLoginState"];
//    [userDefault synchronize];
//
//}
//+(BOOL)getIMLoginState
//{
//    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
//    return [userDef boolForKey:@"LN_IMLoginState"];
//}









//退出登录
+(void)logoutInfomation
{
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"LNLoginNum"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"LNLoginToken"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"LNLoginCode"];

}

@end
