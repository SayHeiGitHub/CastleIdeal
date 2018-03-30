//
//  NetManager.m
//  CastleIdeal
//
//  Created by 姜鸥人 on 2018/3/27.
//  Copyright © 2018年 HeiCoder_OR. All rights reserved.
//

#import "NetManager.h"

#import <AFNetworking.h>

#import "NSString+Util.h"
#import "NSDictionary+Util.h"

@implementation NetManager


+(void)getUnsignRequestWithURL:(NSString *)urlString finished :(RequestFinishedBlock)finishedBlock failed:(RequestFailedBlock)failedBlock
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 30.f;
    [manager.responseSerializer setAcceptableContentTypes: [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil]];
    urlString=[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [manager GET:urlString parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        //[operation.responseData writeToFile:newpath atomically:YES];
        finishedBlock(responseObject);
    }
         failure:^(NSURLSessionTask *task, NSError *error)
     {
         failedBlock(error.localizedDescription);
     }];
}

+ (void)postUnsignRequestWithUrlParam:(NSDictionary *)urlParam finished:(RequestFinishedBlock)finishedBlock failed:(RequestFailedBlock)failedBlock {
    AFHTTPSessionManager *manager =[AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", @"text/plain",nil];
    NSString *urlString = urlParam[@"url"];
    NSDictionary *param = urlParam[@"param"];
    [manager POST:urlString parameters:param progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        //        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        finishedBlock(responseObject);
    } failure:^(NSURLSessionTask *task, NSError *error) {
        failedBlock(error.localizedDescription);
    }];
    
}
+(void)PostRequestWithUrlString:(NSString *)urlString parms:(NSDictionary *)dic finished:(RequestFinishedBlock)finishedBlock failed:(RequestFailedBlock)failedBlock{
    
    AFHTTPSessionManager *manager =[AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    [manager POST:urlString parameters:dic progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        finishedBlock(responseObject);
    } failure:^(NSURLSessionTask *task, NSError *error) {
        failedBlock(error.localizedDescription);
    }];
}

@end
