//
//  UrlParamManager.m
//  CastleIdeal
//
//  Created by 姜鸥人 on 2018/3/27.
//  Copyright © 2018年 HeiCoder_OR. All rights reserved.
//

#import "UrlParamManager.h"

@implementation UrlParamManager
#pragma mark ============= 公共方法 ==============

/**
 *  获取url地址
 *
 *  @param methodName 方法名
 *  @param param  上传的参数, 如果param为空，则传 @{}
 *
 *  @return url地址
 */
+ (NSDictionary *)GetURLWithMethodName:(NSString *)methodName param:(NSDictionary *)param {
    NSString *urlStr =[NSString stringWithFormat:@"%@/%@",kHostAddr,methodName];
    NSDictionary *urlDic = @{@"url":urlStr,@"param":param};
    return urlDic;
}

//+ (NSNumber *)getUserIdWithLoginStatus {
//    UserInfoData *userInfoData=[UserInfoData getUserDefault];
//    if (userInfoData.isLogin) {
//        return [NSNumber numberWithInteger:userInfoData.MemberID];
//    }
//    return @0;
//}
@end
