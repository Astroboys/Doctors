//
//  DataProvider.m
//  DemoApplication
//
//  Created by chris on 15/10/7.
//  Copyright © 2015年 chris. All rights reserved.
//

#import "DataProvider.h"
#import "NTESChatroomManager.h"

@implementation DataProvider
- (NIMKitInfo *)infoByUser:(NSString *)userId
               withMessage:(NIMMessage *)message{
    if (message.session.sessionType == NIMSessionTypeChatroom)
    {
        NIMKitInfo *info = [[NIMKitInfo alloc] init];
        info.infoId = userId;
        if ([userId isEqualToString:[NIMSDK sharedSDK].loginManager.currentAccount]) {
            NIMChatroomMember *member = [[NTESChatroomManager sharedInstance] myInfo:message.session.sessionId];
            info.showName        = member.roomNickname;
            info.avatarUrlString = member.roomAvatar;
        }else{
            NIMMessageChatroomExtension *ext = [message.messageExt isKindOfClass:[NIMMessageChatroomExtension class]] ?
            (NIMMessageChatroomExtension *)message.messageExt : nil;
            info.showName = ext.roomNickname;
            info.avatarUrlString = ext.roomAvatar;
        }
//        info.avatarImage = self.defaultUserAvatar;
        return info;
    }
    else
    {
        return [self infoByUser:userId
                      inSession:message.session];
    }

}

- (NIMKitInfo *)infoByUser:(NSString *)userId
                 inSession:(NIMSession *)session
{
    BOOL needFetchInfo = NO;
    NIMSessionType sessionType = session.sessionType;
    NIMKitInfo *info = [[NIMKitInfo alloc] init];
    info.infoId = userId;
    info.showName = userId; //默认值
    switch (sessionType) {
        case NIMSessionTypeP2P:
        case NIMSessionTypeTeam:
        {
            NIMUser *user = [[NIMSDK sharedSDK].userManager userInfo:userId];
            NIMUserInfo *userInfo = user.userInfo;
            NIMTeamMember *member = nil;
            if (sessionType == NIMSessionTypeTeam)
            {
                member = [[NIMSDK sharedSDK].teamManager teamMember:userId
                                                             inTeam:session.sessionId];
            }
//            NSString *name = [self nickname:user
//                                 memberInfo:member];
//            if (name)
//            {
//                info.showName = name;
//            }
            info.avatarUrlString = userInfo.thumbAvatarUrl;
//            info.avatarImage = self.defaultUserAvatar;
            
            if (userInfo == nil)
            {
                needFetchInfo = YES;
            }
        }
            break;
        case NIMSessionTypeChatroom:
            NSAssert(0, @"invalid type"); //聊天室的Info不会通过这个回调请求
            break;
        default:
            NSAssert(0, @"invalid type");
            break;
    }
    
    if (needFetchInfo)
    {
        [[NIMSDK sharedSDK].userManager fetchUserInfos:@[userId] completion:^(NSArray<NIMUser *> * _Nullable users, NSError * _Nullable error) {
        NSLog(@"%@",users);
        //创建通知
        NSNotification *notification =[NSNotification notificationWithName:@"listReloadData" object:nil userInfo:nil];
        //通过通知中心发送通知
        [[NSNotificationCenter defaultCenter] postNotification:notification];

    }];

    }
    return info;
}


@end
