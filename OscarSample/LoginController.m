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
   // [self checkBiometric:_checkLogin];
    self.definesPresentationContext = YES;
    [super viewDidLoad];
}
-(void)loadView
{
    UIView *view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];

    [view setBackgroundColor:[UIColor whiteColor]];

    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(10, 50, 100, 100)];

    [label setText:@"HAI"];

    [view addSubview:label];

    self.view = view;
}

-(void)checkBiometric:(BOOL)flag{
    //지문 인증하고 실패하면
    //label 바꾸기..
   
    if([NSNumber numberWithBool:_checkLogin]){
        LAContext *context = [[LAContext alloc]init];
        NSError *error;
        if([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]){
            [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:@"지문을 입력해주세요" reply:^(BOOL success, NSError *error){
                 OscarLib *oscar = [[OscarLib alloc]init];
                if(success){
                    NSLog(@"@@@@성공"); // 지문 인증 성공했을때
                    [oscar sendLoginData:@"testFactor" callback:^(void){
                        dispatch_async(dispatch_get_main_queue(), ^{
                                              self.messageLabel.text = @"로그인 성공 하셨습니다.";
                                          });
                        
                    }callback:^(NSInteger code,NSDictionary *info){
                        dispatch_async(dispatch_get_main_queue(), ^{
                                              self.messageLabel.text = @"factor'로그인 실패";
                                          });
                        
                    }];
                  
                }else{
                    //sendfactor
                    NSLog(@"error %@",error);
                    dispatch_async(dispatch_get_main_queue(), ^{
                        self.messageLabel.text = @"로그인 실패 하셨습니다.";
                    });
                }
            }];
        }else{
            NSLog(@"Touch 지원하지 않음");
        }
    }
    else{
        dispatch_async(dispatch_get_main_queue(), ^{
                               self.messageLabel.text = @"로그인 실패 하셨습니다.";
                           });
                           NSLog(@"bool 못받음");
    }
}

@end
