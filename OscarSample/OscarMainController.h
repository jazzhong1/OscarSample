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

-(NSMutableURLRequest *) makeRequest:(NSData *)jsonBodyData withURL:(NSString *)url;
- (void)sendServlet:(NSMutableURLRequest *)urlRequest
           callback:(void (^)(NSError *, NSDictionary *, BOOL))oscarCallback;

-(void)onLoad:(NSString * _Nonnull)ggValue callback:(void (^)(void))onSuccess
     callback:(void (^)(NSInteger code,NSDictionary *info))onError;
-(void)fireLocalNotification;
@end

