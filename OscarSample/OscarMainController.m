//
//  OscarMainController.m
//  OscarSample
//
//  Created by yettie on 19/02/2020.
//  Copyright © 2020 yettie. All rights reserved.
//

#import "OscarMainController.h"
#import "RegisterController.h"
#import "OscarLib.h"

@interface OscarMainController ()
@property (weak, nonatomic) IBOutlet UIImageView *pushIcon;
@property (weak, nonatomic) IBOutlet UIImageView *qrIcon;
@property (weak, nonatomic) IBOutlet UIImageView *registerIcon;

@end

@implementation OscarMainController{
    RegisterController *add;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _pushIcon.userInteractionEnabled = YES;
    _qrIcon.userInteractionEnabled = YES;
    _registerIcon.userInteractionEnabled = YES;
   
    UITapGestureRecognizer *regTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(registerTapped:)];
    
    UITapGestureRecognizer *qrTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(qrTapped:)];
    
    UITapGestureRecognizer *pushTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pushTapped:)];
    
    [_pushIcon addGestureRecognizer:pushTap];
    [_qrIcon addGestureRecognizer:qrTap];
    [_registerIcon addGestureRecognizer:regTap];
    
    
    
    
}
- (void)registerTapped:(UITapGestureRecognizer*)tap
{
    NSLog(@"tapView%@", tap.view);
    //callback 함수로 받기
    
    add = [[RegisterController alloc]init];
    [add setFcmToken:[[NSUserDefaults standardUserDefaults]valueForKey:@"fcmToken"]];
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                         bundle:nil];
    add =[storyboard instantiateViewControllerWithIdentifier:@"RegisterController"];
    [self presentViewController:add
                       animated:YES 
                     completion:nil];    
}
-(void)qrTapped:(UITapGestureRecognizer *)tap{
    [self showAlert:@"OscarSample" withMessage:@"미구현...입니다"];
}
-(void)pushTapped:(UITapGestureRecognizer *)tap{
    [self fireLocalNotification];
}


-(void)showAlert:(NSString *)title withMessage:(NSString *)message{
    //팝업구현을 하는 클래스
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    //팝업 버튼 구현하는 클래스
    UIAlertAction *closeAction = [UIAlertAction actionWithTitle:@"닫기" style:UIAlertActionStyleCancel handler:nil];
    
    //팝업 클래스에 버튼을 넣는 메소드 호출
    [alert addAction:closeAction];
    
    //나타나게
    [self presentViewController:alert animated:YES completion:nil];
}


-(void)fireLocalNotification{
    
    // UILocalNotification 객체 생성
    UILocalNotification *noti = [[UILocalNotification alloc]init];
    
    // 알람 발생 시각 설정. 5초후로 설정. NSDate 타입.
    noti.fireDate = [NSDate dateWithTimeIntervalSinceNow:1];
    
    // timeZone 설정.
    noti.timeZone = [NSTimeZone systemTimeZone];
    
    noti.alertTitle= @"Oscar";
    
    // 알림 메시지 설정
    noti.alertBody = @"LocalNotification Test입니다.";
    
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
