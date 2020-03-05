//
//  FCMDelegate.h
//  OscarSample
//
//  Created by yettie on 19/02/2020.
//  Copyright © 2020 yettie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UserNotifications/UserNotifications.h> //Notification 사용을 위해 헤더 import

@interface FCMDelegate : UIResponder <UIApplicationDelegate,UNUserNotificationCenterDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UIViewController *viewController; //storyBoard 사용하기위해 객체 추가

@end

