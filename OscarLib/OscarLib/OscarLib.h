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
-(void)appConnect:(NSString *)value callback:(void (^)(void))onSuccess
         callback:(void (^)(NSInteger code,NSDictionary *info))onError;

- (void)testRun:(NSString *)value withToken:(NSString *)token  callback:(void (^)(void))onSuccess callback:(void (^)(NSInteger, NSDictionary *))onError;



@end
