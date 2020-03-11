//
//  OscarHandler.m
//  OscarLib
//
//  Created by yettie on 09/03/2020.
//  Copyright © 2020 yettie. All rights reserved.
//

#import "OscarHandler.h"
#import "OscarNetWork.h"

@implementation OscarHandler{
    OscarNetWork *oscarNetWork;
    
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        oscarNetWork = [[OscarNetWork alloc]init];
    }
    return self;
}
-(void)initialize:(NSString *)url callback:(id)oscarCallback{
    url = [url stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    
    //url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    url = [url stringByAppendingFormat:@"?os=ios"];
    NSMutableURLRequest *request=[oscarNetWork makeRequest:url];
    [oscarNetWork sendServlet:request callback:oscarCallback];
}

- (void)reg_auth : (NSString *)url  withValue:(NSString *)value withDict:(NSDictionary *)dict callback:oscarCallback{
    url = [url stringByAppendingString:@"?authcode="];
    url = [url stringByAppendingString:value];
    url = [url stringByAppendingString:@"&appid="];
    url = [url stringByAppendingString:[dict objectForKey:@"appid"]];
    url = [url stringByAppendingString:@"&pushtype=fcm"];
    url = [url stringByAppendingString:@"&tokenid="];
    url = [url stringByAppendingString:[dict objectForKey:@"tokenid"]];
    url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSMutableURLRequest *request=[oscarNetWork makeRequest:url];
    [oscarNetWork sendServlet:request callback:oscarCallback];
}
- (void)sendFactor:(NSString *)url withValue:(NSString *)value withDict:(NSDictionary *)dict callback:(id)oscarCallback{
    url = [url stringByAppendingFormat:@"?factor="];
    url = [url stringByAppendingString: value];
    url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
       NSMutableURLRequest *request=[oscarNetWork makeRequest:url];
       [oscarNetWork sendServlet:request callback:oscarCallback];
    
}
@end
