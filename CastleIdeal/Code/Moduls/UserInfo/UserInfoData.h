//
//  UserInfoData.h
//  RepublicShare
//
//  Created by 姜鸥人 on 2017/8/25.
//  Copyright © 2017年 姜鸥人. All rights reserved.
//

#import <Foundation/Foundation.h>

/***
   *  用户信息
   *
   */
@interface UserInfoData : NSObject


@property(nonatomic, copy)   NSString *SessionKey; //登陆会话
@property(nonatomic, assign) NSInteger MemberID;   //用户id (环信账户)
@property(nonatomic, assign) NSInteger Gender;     //男女
@property(nonatomic, copy)   NSString *LoginName;  //昵称
@property(nonatomic, copy)   NSString *HeadImgUrl; //头像地址
@property(nonatomic, copy)   NSString *Name;       //姓名
@property(nonatomic, copy)   NSString *Mobile;     //手机号
@property(nonatomic, copy)   NSString *LicenceNo;  //身份证号码
@property(nonatomic, copy)   NSString *QQNumber;   //QQ号
@property(nonatomic, copy)   NSString *WXID;       //微信号
@property(nonatomic, copy)   NSString *BlogID;     //微博号
@property(nonatomic, assign) NSInteger Grade;      //等级
@property(nonatomic, assign) NSInteger Age;

@property(nonatomic, copy) NSString *Account;    //账户金额
@property(nonatomic, copy) NSString *QRCodeUrl;  //邀请二维码地址
@property(nonatomic, copy) NSString *IDNumber;   //个人ID
@property(nonatomic, copy) NSString *Signature;  //个人签名

@property(nonatomic, copy) NSString *SkillsTag;  //个人标签
@property(nonatomic, copy) NSString *Birthday;   //生日
@property(nonatomic, copy) NSString *Hometown;   //家乡

@property(nonatomic, assign) NSInteger ConcernTimes;//关注数量
@property(nonatomic, assign) NSInteger FansTimes;   //粉丝数量
@property(nonatomic, assign) NSInteger  VideoTimes; //视频数量
@property(nonatomic, copy)  NSString * IMPassWord; //环信密码

@property(nonatomic, assign) BOOL isLogin;

/**
 *  创建单例，并且从NSUserDefaults获取UserInfoData
 *
 *  @return UserInfoData
 */
+ (UserInfoData *)getUserDefault;

/**
 *  将userInfoData存入NSUserDefaults，会自动将isLogin状态重置为YES（会销毁并重建单例）
 */
- (void)setUserDefault;

/**
 *  清空NSUserDefaults里的UserInfoData（会销毁并重建单例）
 */
+ (void)resetUserDefault;

@end
