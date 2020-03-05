//
//  AppDelegate.m
//  OscarSample
//
//  Created by yettie on 19/02/2020.
//  Copyright © 2020 yettie. All rights reserved.
//

#import "FCMDelegate.h"
#import "Firebase.h"

#define isOSVersionOver10 ([[[[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."] objectAtIndex:0] integerValue] >= 10) // iOS 버전별로 구현하는 방법이 조금 다르기 때문에 mecro 사용

#define isUsedSence ([[[[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."] objectAtIndex:0] intergerValue] >= 13)


@protocol FCMDelgate <UNUserNotificationCenterDelegate>

@end
@interface FCMDelegate ()

@end

@implementation FCMDelegate

NSString *const kGCMMessageIDKey = @"gcm.message_id";

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
     // [START configure_firebase]
    [FIRApp configure];
    // [END configure_firebase]
    
    // [START set_messaging_delegate]
    [FIRMessaging messaging].delegate = self;
    // [END set_messaging_delegate]
    
    // Register for remote notifications. This shows a permission dialog on first run,to
    // show the dialog at a more appropriate time move this registration accordingly.
    // [START register_for_notifications]
    if(isOSVersionOver10){
        //ios 10 or later
        //For iOS 10 display notification (sent via APNS)
        [UNUserNotificationCenter currentNotificationCenter].delegate = self;
        UNAuthorizationOptions authOptions = (UNAuthorizationOptionAlert |
                                              UNAuthorizationOptionSound |
                                              UNAuthorizationOptionBadge);
        
        [[UNUserNotificationCenter currentNotificationCenter]requestAuthorizationWithOptions:authOptions
                                                                           completionHandler:^(BOOL granted, NSError * _Nullable error){
                 //....check?
        }];
    }
    else{
        UIUserNotificationType allNotificationTypes = (UIUserNotificationTypeSound |
                                                       UIUserNotificationTypeAlert |
                                                       UIUserNotificationTypeBadge);
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:allNotificationTypes
                                                                                 categories:nil];
        [application registerUserNotificationSettings:settings];
    }
    [application registerForRemoteNotifications];
    
    
    ///스토리보드 관련  소스
    [self pasteConfiguration];
     self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
     
     UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
     
     self.viewController = [storyboard instantiateViewControllerWithIdentifier:@"mainController"];
     
     self.window.rootViewController = self.viewController;
     [self.window makeKeyAndVisible];
    return YES;
}

#pragma mark - Recive PushData function
-(void) application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    // if you ar receiving a notification message while your app is in the background
    // this callback will not be fired till the user taps on the notification launching the application
    // TODO: Handle data of notification
    
    // With swizzling disabled you must let Messageing Know about the message, for Analytics
    //[[FIRMessaging messaging] appDidReceiveMessage:userInfo];
    
    // Print message ID
    if(userInfo[kGCMMessageIDKey]){
        NSLog(@"Message ID : %@",userInfo[kGCMMessageIDKey]);
    }
    
    // Print full message.
    NSLog(@"%@",userInfo);
}

#pragma mark - Background Recive PushData function
-(void) application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
                                                        fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler{
    // If you are receiving a notification message while your app is in the background,
     // this callback will not be fired till the user taps on the notification launching the application.
     // TODO: Handle data of notification

     // With swizzling disabled you must let Messaging know about the message, for Analytics
     // [[FIRMessaging messaging] appDidReceiveMessage:userInfo];

     // Print message ID.
     if (userInfo[kGCMMessageIDKey]) {
       NSLog(@"Message ID: %@", userInfo[kGCMMessageIDKey]);
     }

     // Print full message.
     NSLog(@"%@", userInfo);

     completionHandler(UIBackgroundFetchResultNewData);
}
// [END receive_message]

// [START ios_10_message_handling]
#pragma mark - Recive displayed Notification iOS 10
// Recive displayed notification for ios 10 devices
// Handle incoming notification message whill app in the foreground
-(void) userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler{
    NSDictionary *userInfo = response.notification.request.content.userInfo;
    if(userInfo[kGCMMessageIDKey]){
        NSLog(@"Message ID : %@",userInfo[kGCMMessageIDKey]);
    }
    // Print full message.
    NSLog(@"%@",userInfo);
    completionHandler();
}
// [END ios_10_message_handling]

// [START refresh Token]
#pragma mark - Refresh Token
-(void)messaging:(FIRMessaging *)messaging didReceiveRegistrationToken:(nonnull NSString *)fcmToken{
    NSLog(@"FCM registration token : %@",fcmToken);
    // Notify about recived token
    NSDictionary *dataDict = [NSDictionary dictionaryWithObject:fcmToken forKey:@"token"];
    [[NSNotificationCenter defaultCenter] postNotificationName:
        @"FCMToken" object:nil userInfo:dataDict];
       // TODO: If necessary send token to application server.
       // Note: This callback is fired at each app startup and whenever a new token is generated.
}
// [END refresh Token]

// [START ios_10_data_message]
// Receive data messages on iOS 10+ directly from FCM (bypassing APNs) when the app is in the foreground.
// To enable direct data messages, you can set [Messaging messaging].shouldEstablishDirectChannel to YES.
#pragma mark - ios 10 PushData Message
-(void)messaging:(FIRMessaging *)messaging didReceiveMessage:(nonnull FIRMessagingRemoteMessage *)remoteMessage{
    NSLog(@"Recevie data message %@", remoteMessage.appData);
}
// [END ios_10_data_message]

-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    NSLog(@"Unable to register for remote notification %@",error);
}

// This function is added here only for debugging purposes, and can be removed if swizzling is enabled.
// If swizzling is disabled then this function must be implemented so that the APNs device token can be paired to
// the FCM registration token.
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
  NSLog(@"APNs device token retrieved: %@", deviceToken);

  // With swizzling disabled you must set the APNs device token here.
  // [FIRMessaging messaging].APNSToken = deviceToken;
  // [FIRMessaging messaging].APNSToken = deviceToken;
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
