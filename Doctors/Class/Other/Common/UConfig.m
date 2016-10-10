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

+(void)setVerifyStatus:(NSInteger)status
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setInteger:status forKey:@"LNVerifyStatus"];
    [userDefault synchronize];

}
+(NSInteger)getVerifyStatus
{
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    NSInteger str = [userDef integerForKey:@"LNVerifyStatus"];
    return str;

}


+(void)setDoctorId:(NSString *)doctorId
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:doctorId forKey:@"LNDoctorId"];
    [userDefault synchronize];
    
}
+(NSString *)getDoctorId
{
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    NSString *str = [NSString stringWithFormat:@"%@",[userDef objectForKey:@"LNDoctorId"]];
    return str;
    
}

+(void)setWelcome:(BOOL)welCome
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setBool:welCome forKey:@"LNWelcome"];
    [userDefault synchronize];
    
}
+(BOOL)getWelcome
{
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    BOOL isWelCome = [userDef boolForKey:@"LNWelcome"];
    return isWelCome;
    
}


+(void)setPhotoUrl:(NSString *)photoStr
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:photoStr forKey:@"LNPhotoUrl"];
    [userDefault synchronize];
    
}
+(NSString *)getPhotoUrl
{
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    NSString *str = [NSString stringWithFormat:@"%@",[userDef objectForKey:@"LNPhotoUrl"]];
    return str;
    
}



+(void)setUnreadCount:(NSInteger)unreadCount
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setInteger:unreadCount forKey:@"LNUnreadCount"];
    [userDefault synchronize];
    
}
+(NSInteger)getUnreadCount
{
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    NSInteger str = [userDef integerForKey:@"LNUnreadCount"];
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
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"LNVerifyStatus"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"LNDoctorId"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"LNPhotoUrl"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"LNPersonInfo"];




}

@end
