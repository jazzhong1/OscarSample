//
//  OscarHandler.h
//  OscarLib
//
//  Created by yettie on 09/03/2020.
//  Copyright © 2020 yettie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OscarNetWork.h"

NS_ASSUME_NONNULL_BEGIN

@interface OscarHandler : NSObject{

    void (^oscarCallback)(NSError *error, NSDictionary *value,BOOL result);
}

- (void)initialize:(NSMutableDictionary *)value callback:ggCallback;
- (void)reg_auth : (NSString *)url callback:oscarCallback;

@end

NS_ASSUME_NONNULL_END
