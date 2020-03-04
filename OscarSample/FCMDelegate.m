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


@protocol FCMDelgate <NSObject>

@end
@interface FCMDelegate ()

@end

@implementation FCMDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [FIRApp configure];
    ///스토리보드 관련  소스
    [self pasteConfiguration];
     self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
     
     UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
     
     self.viewController = [storyboard instantiateViewControllerWithIdentifier:@"mainController"];
     
     self.window.rootViewController = self.viewController;
     [self.window makeKeyAndVisible];
    return YES;
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
