//
//  AuntenticateController.h
//  OscarSample
//
//  Created by yettie on 11/03/2020.
//  Copyright © 2020 yettie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AuntenticateController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property BOOL checkLogin;

@end

NS_ASSUME_NONNULL_END
