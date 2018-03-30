//
//  UserInfoData.m
//  RepublicShare
//
//  Created by 姜鸥人 on 2017/8/25.
//  Copyright © 2017年 姜鸥人. All rights reserved.
//

#import "UserInfoData.h"

#import <YYModel.h>

#import "NSString+Util.h"

#define kUserInfoDefaultsKey @"userInfo"

@implementation UserInfoData

static dispatch_once_t onceToken;

+ (UserInfoData *)getUserDefault {
    static UserInfoData *userInfoData;
    dispatch_once(&onceToken, ^{
        NSDictionary *userInfoDic = [[NSUserDefaults standardUserDefaults] objectForKey:kUserInfoDefaultsKey];
        userInfoData = [self yy_modelWithDictionary:userInfoDic];
    });
    return userInfoData;
}

+ (void)resetUserDefault {
    UserInfoData *userInfoData = [[UserInfoData alloc] init];
    [[NSUserDefaults standardUserDefaults] setObject:[userInfoData yy_modelToJSONObject] forKey:kUserInfoDefaultsKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    //重置时销毁单例
    onceToken = 0;
}

- (void)setUserDefault {
    self.isLogin=YES;
    if ([NSString isBlankString:self.LoginName]) {
        self.LoginName = [NSString stringWithFormat:@"lxg%@",self.IDNumber];
    }
    if ([NSString isBlankString:self.Signature]) {
        self.Signature = @"这个人很懒，还没写签名~";
    }
    if ([NSString isBlankString:self.Hometown]) {
        self.Hometown = @"北京-朝阳";
    }
    if ([NSString isBlankString:self.Birthday]) {
        self.Birthday = @"2008-08-08";
    }
    [[NSUserDefaults standardUserDefaults] setObject:[self yy_modelToJSONObject] forKey:kUserInfoDefaultsKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    //重置时销毁单例
    onceToken = 0;
}

@end
