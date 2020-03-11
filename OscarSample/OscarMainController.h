//
//  OscarMainController.h
//  OscarSample
//
//  Created by yettie on 19/02/2020.
//  Copyright © 2020 yettie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UserNotifications/UserNotifications.h> //Notification 사용을 위해 헤더 import

@interface OscarMainController : UIViewController<UNUserNotificationCenterDelegate>

@property (strong, nonatomic) IBOutlet NSDictionary *sendData; //delegate에서 전달받을 URLSchemefcmToken
@property (strong, nonatomic) IBOutlet NSString *fcmToken;

@end

