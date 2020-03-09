//
//  OscarMainController.h
//  OscarSample
//
//  Created by yettie on 19/02/2020.
//  Copyright © 2020 yettie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OscarMainController : UIViewController

@property (strong, nonatomic) IBOutlet NSDictionary *sendData; //delegate에서 전달받을 URLScheme

-(NSMutableURLRequest *) makeRequest:(NSData *)jsonBodyData withURL:(NSString *)url;
- (void)sendServlet:(NSMutableURLRequest *)urlRequest
           callback:(void (^)(NSError *, NSDictionary *, BOOL))oscarCallback;

-(void)onLoad:(NSString * _Nonnull)ggValue callback:(void (^)(void))onSuccess
     callback:(void (^)(NSInteger code,NSDictionary *info))onError;
@end

