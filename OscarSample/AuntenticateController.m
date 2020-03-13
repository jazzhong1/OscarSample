//
//  AuntenticateController.m
//  OscarSample
//
//  Created by yettie on 11/03/2020.
//  Copyright © 2020 yettie. All rights reserved.
//

#import "AuntenticateController.h"
#import "OscarLib.h"
#import <LocalAuthentication/LocalAuthentication.h>

@implementation AuntenticateController

- (void)viewDidLoad {
    [super viewDidLoad];
    _returnBtn.hidden=YES;
    [self checkBiometric:_checkLogin];
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
                    [oscar sendLoginData:@"http://172.16.10.14/oscar/sendFactor.jsp" withValue:@"sendFactor" callback:^(void){
                        dispatch_async(dispatch_get_main_queue(), ^{
                                              self.messageLabel.text = @"로그인 성공 하셨습니다.";
                            self->_returnBtn.hidden=NO;
                                          });
                        
                    }callback:^(NSInteger code,NSDictionary *info){
                        dispatch_async(dispatch_get_main_queue(), ^{
                                              self.messageLabel.text = @"factor'로그인 실패";
                            self->_returnBtn.hidden=NO;
                                          });
                        
                    }];
                }else{
                    //sendfactor
                    NSLog(@"error %@",error);
                    dispatch_async(dispatch_get_main_queue(), ^{
                        self.messageLabel.text = @"로그인 실패 하셨습니다.";
                        self->_returnBtn.hidden=NO;
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
