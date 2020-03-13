//
//  OscarLib.h
//  OscarLib
//
//  Created by yettie on 09/03/2020.
//  Copyright © 2020 yettie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OscarLib : NSObject

//-(instancetype) init:(NSString *)url;
-(void)appConnect:(NSString *)url withValue:(NSString *)value callback:(void (^)(void))onSuccess
         callback:(void (^)(NSInteger code,NSDictionary *info))onError;

- (void)testRun:(NSString *)url withValue:(NSString *)value withToken:(NSString *)token  callback:(void (^)(void))onSuccess callback:(void (^)(NSInteger, NSDictionary *))onError;

- (void)sendLoginData:(NSString *)url withValue:(NSString *)value callback:(void (^)(void))onSuccess callback:(void (^)(NSInteger, NSDictionary *))onError;


@end
