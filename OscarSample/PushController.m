//
//  PushController.m
//  OscarSample
//
//  Created by yettie on 10/03/2020.
//  Copyright © 2020 yettie. All rights reserved.
//

#import "PushController.h"
#import "LoginController.h"
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
- (IBAction)submitBtn:(id)sender {
    NSString *value=[_number1 text];
    value = [value stringByAppendingString:[_number2 text]];
    value = [value stringByAppendingString:[_number3 text]];
    value = [value stringByAppendingString:[_number4 text]];
   
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                                  bundle:nil];
    [oscar testRun:value withToken:_fcmToken callback:^(void){ //successCallback
        NSLog(@"success");
       
        LoginController *add = [storyboard instantiateViewControllerWithIdentifier:@"loginController"];
           [self presentViewController:add
                              animated:YES
                            completion:nil];
    }
    callback:^(NSInteger code,NSDictionary *info){ //errorCallback
        NSLog(@"Error :: %ld = %@",(long)code,info);
        LoginController *add = [storyboard instantiateViewControllerWithIdentifier:@"loginController"];
                         [self presentViewController:add
                                            animated:YES
                                          completion:nil];
    }];
    NSLog(@"value %@",value);
    
}
@end
