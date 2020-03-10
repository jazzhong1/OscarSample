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

-(void)initialize:(NSString *)url callback:(id)oscarCallback;
- (void)reg_auth : (NSString *)url  withValue:(NSString *)value withDict:(NSDictionary *)dict callback:oscarCallback;
@end

NS_ASSUME_NONNULL_END
