//
//  PushController.m
//  OscarSample
//
//  Created by yettie on 10/03/2020.
//  Copyright © 2020 yettie. All rights reserved.
//

#import "PushController.h"
#import "AuntenticateController.h"
#import "OscarLib.h"

@implementation PushController{
    OscarLib *oscar;
}
- (void)viewDidLoad {
    self.number1.delegate = self;
    self.number2.delegate = self;
    self.number3.delegate = self;
    self.number4.delegate = self;
    oscar = [[OscarLib alloc]init];
    [oscar appConnect:nil callback:^(void){ //successCallback
        NSLog(@"success");
    }
             callback:^(NSInteger code,NSDictionary *info){ //errorCallback
        NSLog(@"Error :: %ld = %@",(long)code,info);
    }];
    [super viewDidLoad];
}
- (IBAction)before:(id)sender {
    [self clearTextFeld];
}
- (IBAction)submitBtn:(id)sender {
    NSString *value=[_number1 text];
    value = [value stringByAppendingString:[_number2 text]];
    value = [value stringByAppendingString:[_number3 text]];
    value = [value stringByAppendingString:[_number4 text]];
    
    if(value.length == 4){
        UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                             bundle:nil];
        
        NSString *token = [[NSUserDefaults standardUserDefaults]valueForKey:@"fcmToken"];
        [oscar testRun:value withToken:token
              callback:^(void){ //successCallback
            NSLog(@"success");
            dispatch_async(dispatch_get_main_queue(), ^{
                AuntenticateController *auth = [[AuntenticateController alloc]init];
                [auth setCheckLogin:YES];
                auth= [storyboard instantiateViewControllerWithIdentifier:@"auth"];
                [self presentViewController:auth
                                   animated:YES
                                 completion:nil];
                [self clearTextFeld];
            });
        }
              callback:^(NSInteger code,NSDictionary *info){ //errorCallback
            NSLog(@"Error :: %ld = %@",(long)code,info);
            dispatch_async(dispatch_get_main_queue(), ^{
                AuntenticateController *auth = [[AuntenticateController alloc]init];
                [auth setCheckLogin:NO];
                auth= [storyboard instantiateViewControllerWithIdentifier:@"auth"];
                [self presentViewController:auth
                                   animated:YES
                                 completion:nil];
                [self clearTextFeld];
            });
        }];
        NSLog(@"value %@",value);
    }
    else{
        [self showAlert:@"Oscar" :@"4개 숫자를 입력 해 주세요"];
        NSLog(@"4개 이하 의 글자.");
        //alet띄우기
    }
    
}
-(void)clearTextFeld{
    
    _number1.text=nil;
    _number2.text=nil;
    _number3.text=nil;
    _number4.text=nil;
}

-(void)showAlert:(NSString *)title:(NSString *)message{
      //팝업구현을 하는 클래스
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        
        //팝업 버튼 구현하는 클래스
        UIAlertAction *closeAction = [UIAlertAction actionWithTitle:@"닫기" style:UIAlertActionStyleCancel handler:nil];
        
        //팝업 클래스에 버튼을 넣는 메소드 호출
        [alert addAction:closeAction];
        
        //나타나게
        [self presentViewController:alert animated:YES completion:nil];
}
@end
