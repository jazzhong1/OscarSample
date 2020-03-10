//
//  LoginController.m
//  OscarSample
//
//  Created by yettie on 10/03/2020.
//  Copyright © 2020 yettie. All rights reserved.
//

#import "LoginController.h"
#import "OscarLib.h"
#import <LocalAuthentication/LocalAuthentication.h>

@implementation LoginController

- (void)viewDidLoad {
    OscarLib *oscar = [[OscarLib alloc]init];
    //지문 인증하고 실패하면
    //label 바꾸기..
    LAContext *context = [[LAContext alloc]init];
    NSError *error;
    if([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]){
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:@"지문을 입력해주세요" reply:^(BOOL success, NSError *error){
            if(success){
                NSLog(@"@@@@성공"); // 지문 인증 성공했을때
                self.messageLabel.text = @"로그인 성공 하셨습니다.";
                [super viewDidLoad];
            }else{
                self.messageLabel.text = @"로그인 실패 하셨습니다.";
                NSLog(@"@@@@실패");
            }
        }];
    }else{
        NSLog(@"Touch 지원하지 않음");
    }
    
   
}

@end
