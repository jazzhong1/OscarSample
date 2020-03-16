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

#define MAX_LENGTH 1;

@implementation PushController{
    OscarLib *oscar;
}
- (void)viewDidLoad {
    self.number1.delegate = self;
    self.number2.delegate = self;
    self.number3.delegate = self;
    self.number4.delegate = self;
    
    oscar = [[OscarLib alloc]init];
    
    [oscar appConnect:@"http://172.16.10.14/oscar/newApp.jsp" withValue:nil  callback:^(void){ //successCallback
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
        
        
        [oscar testRun:@"http://172.16.10.14/oscar/reg_auth.jsp" withValue:value withToken:token
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
                [self showAlert:@"Oscar" withMessage:@"인증번호 일치하지 않습니다."];
                [self clearTextFeld];
            });
        }];
        NSLog(@"value %@",value);
    }
    else{
        [self showAlert:@"Oscar" withMessage:@"4개 숫자를 입력 해 주세요"];
        NSLog(@"4개 이하 의 글자.");
        //alet띄우기
    }
    
}
- (IBAction)cancelbtn:(id)sender {
    [self clearTextFeld];
    [_number1 becomeFirstResponder];
}

-(void)clearTextFeld{
    
    _number1.text=nil;
    _number2.text=nil;
    _number3.text=nil;
    _number4.text=nil;
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

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    static const NSUInteger limit = 1; // we limit to 1 characters
    NSUInteger allowedLength = limit - [textField.text length] + range.length;
    BOOL result = YES;
    UITextField *_code;
    if (string.length > allowedLength) {
        if (string.length > 1) {
            // get at least the part of the new string that fits
            NSString *limitedString = [string substringToIndex:allowedLength];
            NSMutableString *newString = [textField.text mutableCopy];
            [newString replaceCharactersInRange:range withString:limitedString];
            textField.text = newString;
        }
        result= NO;
    } else {
        result= YES;
    }
    
    
    if(result == YES){
        if (textField == _number1) {
            _code = _number2;
        } else if (textField == _number2) {
            _code = _number3;
        } else if (textField == _number3) {
            _code = _number4;
        }
        [_code performSelector:@selector(becomeFirstResponder) withObject:nil afterDelay:0.1];
        
    }
    return result;
    
}
@end
