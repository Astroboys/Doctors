//
//  AppDelegate.m
//  Doctors
//
//  Created by 崔敬轩 on 16/8/18.
//  Copyright © 2016年 XueHuiWang. All rights reserved.
//

#import "AppDelegate.h"
#import "ZHNavViewController.h"
#import "ZHTabViewController.h"
#import "YCLeftViewController.h"
#import "ZHLoginViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "ZHLoginViewController.h"
#import "ZHNavViewController.h"
#import "MMDrawerController.h"
#import "NIMSDK.h"
#import <IQKeyboardManager.h>
#import "ZHLoginViewController.h"
#import "DataProvider.h"
#import "AttachmentDecoder.h"
#import "UConfig.h"
#import "WelcomeViewController.h"
#import "NIMSystemNotification.h"
#import "ZHTabViewController.h"
#import "NTESNetChatViewController.h"
#import "NTESVideoChatViewController.h"
#import "NTESAudioChatViewController.h"
#import "NTESNetChatViewController.h"
#import <AVFoundation/AVCaptureDevice.h>
#import <AVFoundation/AVMediaFormat.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>
#define NIMSDKAppKey @"d5bec89ed06e23760b46d260f706ddf6"

#define kScreenSize [UIScreen mainScreen].bounds

@interface AppDelegate ()<NIMSystemNotificationManagerDelegate,NIMNetCallManagerDelegate,NIMChatManagerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
     [self registerNIM];
//    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    
    
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.enableAutoToolbar = NO;

    
    if ([UConfig getWelcome] == YES) {
        [self showMainVC];
    }else{
        [self showWelcomeVC];
    }
    
    id<NIMSystemNotificationManager> systemNotificationManager = [[NIMSDK sharedSDK] systemNotificationManager];
    [systemNotificationManager addDelegate:self];
    
    NSArray *notifications = [systemNotificationManager fetchSystemNotifications:NIMSystemNotificationTypeTeamApply
                                                                           limit:20];
    [[NIMSDK sharedSDK].netCallManager addDelegate:self];
    self.window.backgroundColor = [UIColor whiteColor];
    
    [self.window makeKeyAndVisible];
    
    [self getCameraLimit];
    [self getMicLimit];
    [self setAudioPlayer];
    [[NIMSDK sharedSDK].chatManager addDelegate:self];
    [self registerAPNs];
    return YES;
}
#pragma mark - misc
- (void)registerAPNs
{
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerForRemoteNotifications)])
    {
        UIUserNotificationType types = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types
                                                                                 categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }
    else
    {
        UIRemoteNotificationType types = UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeBadge;
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:types];
    }
}
//本地通知
-(void)localNotification:(NSString *)str
{
    
    // 1. 创建一个通知
    UILocalNotification *locN = [[UILocalNotification alloc] init];
    
    // 1.1 设置通知的必须项
    // 设置通知的内容
    locN.alertBody = str;
    
    // 设置通知的发送时间(2秒之后发送)
    locN.fireDate = [NSDate dateWithTimeIntervalSinceNow:5];
    // 设置时区, 一般设置默认的就可以
    locN.timeZone = [NSTimeZone defaultTimeZone];
    
    // 设置弹框的启动图片(无论此处填什么, 都只是读取默认的启动图片)
    // (iOS9.0之后, 就没有效果)
//    locN.alertLaunchImage = @"abc";
    
    // 设置弹框的标题
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.2)
    {
        locN.alertTitle = @"通知";
    }
    // 设置通知的额外参数
    // 最低是每分钟发送一次
    //    locN.repeatInterval = NSCalendarUnitMinute;
    
    // 设置滑动解锁的文字
    locN.hasAction = NO; // 代表下面配置的字符串提醒, 没有效果
    locN.alertAction = @"确定";
    
    // 设置通知接收到时的声音(30s)
    locN.soundName = @"buyao.wav";
    
    NSInteger count = [[[NIMSDK sharedSDK] conversationManager] allUnreadCount];
    
    // 设置通知发送时, 提醒数字(==0, 会自动消失)
    locN.applicationIconBadgeNumber = count;
    
//    // 设置通知的附加数据
//    locN.userInfo = @{
//                      @"name" : @"zhangsan",
//                      @"content" : @"吃饭了没有"
//                      };
    // 2. 发送通知
    // 通知是一个应用程序级别的操作, openURL
    // 立即推送一个通知
    //    [[UIApplication sharedApplication] presentLocalNotificationNow:locN];
    [[UIApplication sharedApplication] scheduleLocalNotification:locN];
}

- (void)onRecvMessages:(NSArray *)messages
{
    
    [self localNotification:@"您有一条新消息"];
    if ([UIApplication sharedApplication].applicationState == UIApplicationStateActive) {
        self.audioPlayer.numberOfLoops = 0;
        [[AppDelegate uApp].audioPlayer play];
    }
    //创建通知
    NSNotification *notification1 =[NSNotification notificationWithName:@"updatePhoto" object:nil userInfo:nil];
    //通过通知中心发送通知
    [[NSNotificationCenter defaultCenter] postNotification:notification1];
   
    
}


//获取appdelegate的实例
+(AppDelegate *)uApp
{
    AppDelegate *uApp = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    return uApp;
}

- (void)setAudioPlayer
{
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback withOptions:AVAudioSessionCategoryOptionInterruptSpokenAudioAndMixWithOthers error:nil];
//    NSDictionary *phoneSoundDic = [UConfig getPhoneRingingDic];
    NSString *soundPath = [[NSBundle mainBundle] pathForResource:@"avchat_ring" ofType:@"mp3"];
    self.audioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:soundPath] error:nil];
    
}

//相机权限
-(void)getCameraLimit
{
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    
    if (authStatus == AVAuthorizationStatusRestricted|| authStatus == AVAuthorizationStatusDenied) {
        
        // 获取摄像头失败
        
    }else{
        
        // 获取摄像头成功
        
    }
    
  
}
//麦克风权限
- (void)getMicLimit
{
    
    [[AVAudioSession sharedInstance] requestRecordPermission:^(BOOL granted) {
        
        if (granted) {
            
            // 用户同意获取麦克风
            
        } else {
            
            // 用户不同意获取麦克风
            
        }
        
    }];
    
}


-(void)showWelcomeVC
{
    self.window.rootViewController=[WelcomeViewController new];

}
-(void)showMainVC
{
    YCLeftViewController*leftVc = [[YCLeftViewController alloc] init];
    ZHNavViewController*leftNav=[[ZHNavViewController alloc]initWithRootViewController:leftVc];
    ZHTabViewController*tabNav=[[ZHTabViewController alloc]init];
    
    MMDrawerController *drawerVc = [[MMDrawerController alloc] initWithCenterViewController:tabNav leftDrawerViewController:leftNav];
    drawerVc.maximumLeftDrawerWidth = kLeftSize;
    drawerVc.showsShadow = YES;
    drawerVc.openDrawerGestureModeMask = MMOpenDrawerGestureModeNone;
    drawerVc.closeDrawerGestureModeMask = MMCloseDrawerGestureModeAll;
    if ([UConfig getLoginNumber].length==0) {
        
        [self setupLoginViewController];
        
    }else{
    
        [[NIMSDK sharedSDK].loginManager login:[NSString stringWithFormat:@"_%@",[UConfig getLoginNumber]] token:[UConfig getLoginToken] completion:^(NSError *error) {
            if (!error) {
                NSLog(@"登录成功");
                
            }else{
                NSLog(@"登录失败");
            }
        }];
        
        self.window.rootViewController=drawerVc;
    }

}
- (BOOL)shouldResponseBusy
{
    ZHTabViewController *tabVC = [[ZHTabViewController alloc] init];
    UINavigationController *nav = tabVC.selectedViewController;
    return [nav.topViewController isKindOfClass:[NTESNetChatViewController class]];
}

#pragma mark - NIMNetCallManagerDelegate
- (void)onReceive:(UInt64)callID from:(NSString *)caller type:(NIMNetCallType)type message:(NSString *)extendMessage{
    [self localNotification:@"您有语音视频来电"];
    ZHTabViewController *tabVC = [ZHTabViewController instance];
    [tabVC.view endEditing:YES];
    UINavigationController *nav = tabVC.selectedViewController;

    if ([self shouldResponseBusy]){
        [[NIMSDK sharedSDK].netCallManager control:callID type:NIMNetCallControlTypeBusyLine];
    }
    else {
        UIViewController *vc;
        switch (type) {
            case NIMNetCallTypeVideo:{
               NTESVideoChatViewController *vc1 = [[NTESVideoChatViewController alloc] initWithCaller:caller callId:callID];
                vc1.isPrentsent = YES;
                vc = vc1;
            }
                break;
            case NIMNetCallTypeAudio:{
                NTESAudioChatViewController *vc2 = [[NTESAudioChatViewController alloc] initWithCaller:caller callId:callID];
                vc2.isPrentsent = YES;
                vc = vc2;
            }
                break;
            default:
                break;
        }
        if (!vc) {
            return;
        }
        
        
        
        CATransition *transition = [CATransition animation];
        transition.duration = 0.25;
        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
        transition.type = kCATransitionPush;
        transition.subtype = kCATransitionFromTop;
        transition.delegate = self;
        [self.window.rootViewController.view.layer addAnimation:transition forKey:nil];
        self.window.rootViewController.navigationController.navigationBarHidden = YES;
        [self.window.rootViewController.navigationController pushViewController:vc animated:NO];

        [self.window.rootViewController presentViewController:vc animated:YES completion:^{             }];
        
        
//        dataArray = [systemNotificationManager fetchSystemNotifications:NIMSystemNotificationTypeTeamApply
//                                                                  limit:20];
              
        
        [AppDelegate uApp].audioPlayer.numberOfLoops = 2;
        [[AppDelegate uApp].audioPlayer play];

       
        
//        [self.window.rootViewController.navigationController pushViewController:vc animated:YES];
    }
    
}

-(void)registerNIM
{
    //注册APP，请将 NIMSDKAppKey 换成您自己申请的App Key
    [[NIMSDK sharedSDK] registerWithAppID:NIMSDKAppKey cerName:nil];
    //注入 NIMKit 内容提供者
    [[NIMKit sharedKit] setProvider:[DataProvider new]];
    //需要自定义消息时使用
    [NIMCustomObject registerCustomDecoder:[[AttachmentDecoder alloc]init]];
}

- (void)setupLoginViewController
{
    ZHLoginViewController*loginController = [[ZHLoginViewController alloc] init];
    ZHNavViewController *nav = [[ZHNavViewController alloc] initWithRootViewController:loginController];
    self.window.rootViewController = nav;
}


-(void)onReceiveSystemNotification:(NIMSystemNotification *)notification
{
    [self localNotification:@"系统提醒"];
    if ([UIApplication sharedApplication].applicationState == UIApplicationStateActive) {
        self.audioPlayer.numberOfLoops = 0;
        [[AppDelegate uApp].audioPlayer play];
    }
   
    id<NIMSystemNotificationManager> systemNotificationManager = [[NIMSDK sharedSDK] systemNotificationManager];

    NSInteger num = [systemNotificationManager allUnreadCount:NIMSystemNotificationTypeTeamApply];
    [UConfig setUnreadCount:num];
    ;
    //创建通知
    NSNotification *notification1 =[NSNotification notificationWithName:@"updatePhoto" object:nil userInfo:nil];
    //通过通知中心发送通知
    [[NSNotificationCenter defaultCenter] postNotification:notification1];
    NSLog(@"%@",notification);
}

- (void)applicationWillResignActive:(UIApplication *)application {
    
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.

}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    
    NSInteger count = [[[NIMSDK sharedSDK] conversationManager] allUnreadCount];
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:count];
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "zhonghe.edu.Doctors" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Doctors" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"Doctors.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
