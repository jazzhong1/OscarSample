//
//  main.m
//  OscarSample
//
//  Created by yettie on 19/02/2020.
//  Copyright © 2020 yettie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APNSDelegate.h"

int main(int argc, char * argv[]) {
    NSString * appDelegateClassName;
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
        appDelegateClassName = NSStringFromClass([APNSDelegate class]);
    }
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}
