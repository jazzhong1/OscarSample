//
//  OscarNetWork.m
//  OscarLib
//
//  Created by yettie on 09/03/2020.
//  Copyright © 2020 yettie. All rights reserved.
//

#import "OscarNetWork.h"

@implementation OscarNetWork

-(NSMutableURLRequest *) makeRequest:(NSString *)value{
    
    NSURL *servletURL=[NSURL URLWithString:value];
    NSMutableURLRequest *request=[[NSMutableURLRequest alloc]init];
    
    NSDictionary *cookieProperties=[NSDictionary dictionaryWithObjectsAndKeys:
                                    servletURL.host,NSHTTPCookieDomain,
                                    servletURL.path,NSHTTPCookiePath,
                                    nil];
    
    NSHTTPCookie *cookie=[NSHTTPCookie cookieWithProperties:cookieProperties];
    NSArray* cookieArray=[NSArray arrayWithObjects:cookie,nil];
    NSDictionary *header=[NSHTTPCookie requestHeaderFieldsWithCookies:cookieArray];
    
    [request setHTTPMethod:@"GET"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setURL:servletURL];
    [request setAllHTTPHeaderFields:header];
    return request;
}

- (void)sendServlet:(NSMutableURLRequest *)urlRequest callback:(void (^)(NSError * _Nonnull, NSDictionary * _Nonnull, BOOL))oscarCallback{
    
    NSURLSession *session=[NSURLSession sharedSession];
    
    NSURLSessionDataTask *dataTask=[session dataTaskWithRequest:urlRequest
                                              completionHandler:^(NSData *data,
                                                                  NSURLResponse *response,
                                                                  NSError *error){
        NSDictionary *responseDictonary=nil;
        NSError *ggError=nil;
        NSData *ggValue=nil;
        BOOL callbackResult=NO;
        
        
        NSHTTPURLResponse *httpResponse=(NSHTTPURLResponse *)response;
        if(httpResponse.statusCode==200){
            
            responseDictonary=[NSJSONSerialization JSONObjectWithData:data
                                                              options:0
                                                                error:&ggError];
            NSLog(@"responseDictonary %@",responseDictonary);
        }
        else if(httpResponse.statusCode == 401){
            // origin not matched
            NSLog(@"error %@",error);
            
        }
        else{
            ///...안 맞았을때...
            NSLog(@"error %@",error);
        }
        
        oscarCallback(error,responseDictonary,error!=nil?callbackResult:true);
        return ;
    }];
    
    [dataTask resume];
}

@end
