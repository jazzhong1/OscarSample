//
//  OscarMainController.m
//  OscarSample
//
//  Created by yettie on 19/02/2020.
//  Copyright © 2020 yettie. All rights reserved.
//

#import "OscarMainController.h"
#import "PushController.h"
#import "OscarLib.h"

@interface OscarMainController ()
@property (weak, nonatomic) IBOutlet UIImageView *pushIcon;

@end

@implementation OscarMainController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _pushIcon.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapped:)];
    [_pushIcon addGestureRecognizer:tap];
    
    
    
    NSLog(@"check sendData %@",self.sendData);
}

- (void)tapped:(UITapGestureRecognizer*)tap
{
    NSLog(@"%@", tap.view);
    //callback 함수로 받기
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                         bundle:nil];
    PushController *add =
               [storyboard instantiateViewControllerWithIdentifier:@"pushController"];

    [add setFcmToken:self.fcmToken];
    [self presentViewController:add
                       animated:YES 
                     completion:nil];
    
}


-(void)fireLocalNotification{
 
    // UILocalNotification 객체 생성
    UILocalNotification *noti = [[UILocalNotification alloc]init];
 
    // 알람 발생 시각 설정. 5초후로 설정. NSDate 타입.
    noti.fireDate = [NSDate dateWithTimeIntervalSinceNow:5];
 
    // timeZone 설정.
    noti.timeZone = [NSTimeZone systemTimeZone];
 
    // 알림 메시지 설정
    noti.alertBody = @"Just Do It";
 
    // 알림 액션 설정
    noti.alertAction = @"GOGO";
 
    // 아이콘 뱃지 넘버 설정. 임의로 1 입력
    noti.applicationIconBadgeNumber = 1;
 
    // 알림 사운드 설정. 자체 제작 사운드도 가능. (if nil = no sound)
    noti.soundName = UILocalNotificationDefaultSoundName;
 
    // 임의의 사용자 정보 설정. 알림 화면엔 나타나지 않음
    noti.userInfo = [NSDictionary dictionaryWithObject:@"My User Info" forKey:@"User Info"];
 
    // UIApplication을 이용하여 알림을 등록.
    [[UIApplication sharedApplication] scheduleLocalNotification:noti];
}



@end
