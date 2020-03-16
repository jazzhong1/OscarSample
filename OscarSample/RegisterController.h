//
//  RegisterController.h
//  OscarSample
//
//  Created by yettie on 10/03/2020.
//  Copyright © 2020 yettie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RegisterController : UIViewController<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *number1;
@property (weak, nonatomic) IBOutlet UITextField *number2;
@property (weak, nonatomic) IBOutlet UITextField *number3;
@property (weak, nonatomic) IBOutlet UITextField *number4;
@property (nonatomic) NSArray *fieldArray;

@property (strong, nonatomic) IBOutlet NSString *fcmToken;


@end

NS_ASSUME_NONNULL_END
