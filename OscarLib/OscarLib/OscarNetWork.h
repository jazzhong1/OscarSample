//
//  OscarNetWork.h
//  OscarLib
//
//  Created by yettie on 09/03/2020.
//  Copyright © 2020 yettie. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface OscarNetWork : NSObject

-(NSMutableURLRequest *) makeRequest:(NSString *)value;

-(void)sendServlet:(NSMutableURLRequest *)urlRequest
          callback:(void (^)(NSError *error,
                             NSDictionary *value,
                             BOOL result))oscarCallback;
@end


NS_ASSUME_NONNULL_END
