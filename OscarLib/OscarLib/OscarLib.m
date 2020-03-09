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

- (void)testRun:(NSDictionary *)value callback:(void (^)(void))onSuccess callback:(void (^)(NSInteger, NSDictionary *))onError{
    [oscarHandler initialize:nil callback:^(NSError *error, NSMutableDictionary *value,BOOL result){
         NSString *url =@"http://172.16.10.14/oscar/newApp.jsp";
        url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        //netWork쏘기...콜백 받고
        NSLog(@"value %@",value);
        if(!result){
            onError([error code],[error userInfo]);
            return;
        }
        else{
            self->dict = value;
            [self->oscarHandler reg_auth:self->dict callback:^(NSError *error, NSMutableDictionary *value,BOOL result){
                NSString *url =@"http://172.16.10.14/oscar/reg_auth.jsp";
                url = [url stringByAppendingString:@"?authcode="];
                url = [url stringByAppendingString:[self->dict objectForKey:@"code"]];
                url = [url stringByAppendingString:@"&appid="];
                url = [url stringByAppendingString:[self->dict objectForKey:@"appid"]];
                url = [url stringByAppendingString:@"&pushtype=fcm"];
                url = [url stringByAppendingString:@"&tokenid="];
                url = [url stringByAppendingString:[self->dict objectForKey:@"tokenid"]];
                url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
                //network쏘기
                    if(!result){
                        onError([error code],[error userInfo]);
                        return;
                    }
                    else{
                        self->onsuccess();
                    }
            }];
            self->onsuccess();
        }
        
    }];
    

}


@end
