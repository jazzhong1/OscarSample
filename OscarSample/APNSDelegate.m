//
//  AppDelegate.m
//  OscarSample
//
//  Created by yettie on 19/02/2020.
//  Copyright © 2020 yettie. All rights reserved.
//

#import "APNSDelegate.h"


#define isOSVersionOver10 ([[[[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."] objectAtIndex:0] integerValue] >= 10) // iOS 버전별로 구현하는 방법이 조금 다르기 때문에 mecro 사용

#define isUsedSence ([[[[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."] objectAtIndex:0] intergerValue] >= 13)



@interface APNSDelegate ()

@end

@implementation APNSDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    ///스토리보드 관련  소스
    [self pasteConfiguration];
    [self initializeRemoteNotification];
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    self.viewController = [storyboard instantiateViewControllerWithIdentifier:@"mainController"];
    
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    return YES;
}


#pragma mark - Initialize Remote Notification
-(void)initializeRemoteNotification{
    if(isOSVersionOver10){ // ios10 이상
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = self;
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionSound | UNAuthorizationOptionAlert|UNAuthorizationOptionBadge) completionHandler:^(BOOL granted, NSError *_Nullable error){
            if(!error){
                //푸시 서비스 등록 성공
                dispatch_async(dispatch_get_main_queue(), ^{
                    [[UIApplication sharedApplication] registerForRemoteNotifications];
                });
            }
            else{
                NSLog(@"push service error code %ld, reason%@",(long)error.code,error.domain);
            }
        }];
    }
    else{ //iOS10 하위버전
        if([[UIApplication sharedApplication] respondsToSelector:@selector(isRegisteredForRemoteNotifications)]){
            [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UNAuthorizationOptionSound|UNAuthorizationOptionAlert|UNAuthorizationOptionBadge) categories:nil]];
            [[UIApplication sharedApplication] isRegisteredForRemoteNotifications];
        }
        
    }
}

#pragma mark - Get Device Token
//푸시에 사용할 디바이스 토큰 받아옴.
-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    NSString *strDeviceToken = [self stringWithDeviceToken:deviceToken];
    NSLog(@"strDeviceToken %@",strDeviceToken);
}
// iOS9 이하 푸시 Delegate
#pragma mark - Remote Notification Delegate for <= ios 9.x
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings{
    [application registerForRemoteNotifications];
}

//푸시 데이터가 들어노느 함수
#pragma mark - Data in PushData function
-(void) application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    NSLog(@"Remote notification : %@", userInfo);
    
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    self.viewController = [storyboard instantiateViewControllerWithIdentifier:@"loginConroller"];
    
    if([self.viewController respondsToSelector:@selector(setSendData:)]){
        [self.viewController performSelector:@selector(setSendData:) withObject:userInfo];
        [self.viewController viewDidLoad];
    }
    
}

// 푸시 서비스 등록 실패시 호출되는 함수
-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    NSLog(@"register faile notification %ld, reason%@",(long)error.code,error.domain);
}

// iOS10 이상 푸시 Delegate
#pragma mark - UNUserNotificationCenter Delegate for >= iOS 10
// 앱이 실행 되고 있을때 푸시 데이터 처리
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler{
    NSLog(@"Remote notification : %@",notification.request.content.userInfo);
    if([self.viewController respondsToSelector:@selector(setSendData:)]){
        [self.viewController performSelector:@selector(setSendData:) withObject:notification.request.content.userInfo];
        [self.viewController viewDidLoad];
    }
    completionHandler(UNNotificationPresentationOptionAlert | UNNotificationPresentationOptionBadge | UNNotificationPresentationOptionSound);
}

//앱이 백그라운드나 종료되어 있는 상태에서 푸시 데이터 처리
-(void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler{
    NSLog(@"Remote notification : %@",response.notification.request.content.userInfo);
    completionHandler();
}

#pragma mark - Convert DeviceToken To String 
- (NSString *)stringWithDeviceToken:(NSData *)deviceToken {
    const char *data = [deviceToken bytes];
    NSMutableString *token = [NSMutableString string];
    
    for (NSUInteger i = 0; i < [deviceToken length]; i++) {
        [token appendFormat:@"%02.2hhX", data[i]];
    }
    
    return [token copy];
}



#pragma mark - UISceneSession lifecycle
#ifdef isUsedSence
- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}



- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}
#endif

@end
