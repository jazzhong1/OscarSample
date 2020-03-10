//
//  OscarLib.m
//  OscarLib
//
//  Created by yettie on 09/03/2020.
//  Copyright © 2020 yettie. All rights reserved.
//

#import "OscarLib.h"
#import "OscarHandler.h"

@implementation OscarLib{
    OscarHandler *oscarHandler;
    
    NSURL *url;
    NSMutableDictionary *dict;
    
    void(^oscarCallback)(NSError *error, NSDictionary *value, BOOL result);
    void(^onsuccess)(void);
    void(^onError)(NSInteger code, NSDictionary *value);
    
    
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        oscarHandler= [[OscarHandler alloc]init];
        return self;
    }
    return self;
}

- (void)appConnect:(NSString *)value callback:(void (^)(void))onSuccess callback:(void (^)(NSInteger, NSDictionary *))onError{
    NSString *url =@"http://172.16.10.14/oscar/newApp.jsp";

       [oscarHandler initialize:url callback:^(NSError *error, NSMutableDictionary *oscarValue,BOOL result){
           //netWork쏘기...콜백 받고
           NSLog(@"value %@",value);
           if(!result){
               onError([error code],[error userInfo]);
               return;
           }
           else{
               self->dict = oscarValue;
           }
       }];
       
    
}
- (void)testRun:(NSString *)value withToken:(NSString *)token  callback:(void (^)(void))onSuccess callback:(void (^)(NSInteger, NSDictionary *))onError{
    NSString *url =@"http://172.16.10.14/oscar/reg_auth.jsp";
    [dict setObject:token forKey:@"tokenid"];
              [self->oscarHandler reg_auth:url withValue:value withDict:dict callback:^(NSError *error, NSMutableDictionary *value,BOOL result){
                  //network쏘기
                      if(!result){
                          onError([error code],[error userInfo]);
                          return;
                      }
                      else{
                          self->onsuccess();
                      }
              }];
}



@end
