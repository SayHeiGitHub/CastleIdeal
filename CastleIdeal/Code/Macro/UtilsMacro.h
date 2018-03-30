//
//  UtilsMacro.h
//  RepublicShare
//
//  Created by 姜鸥人 on 2018/3/27.
//  Copyright © 2017年 姜鸥人. All rights reserved.
//

#ifndef UtilsMacro_h
#define UtilsMacro_h


// 系统参数
#define kCURRENT_UUID        [[UIDevice currentDevice].identifierForVendor UUIDString]
#define kCURRENT_SYS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
#define kCURRENT_APP_VERSION [[[NSBundle mainBundle] infoDictionary] valueForKey:@"CFBundleShortVersionString"]

// 全局打印方法 & 全局显示方法
#define RSLog(FORMAT, ...) fprintf(stderr,"[%s:%d行] %s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#define SDShow(FORMAT, ...) UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"温馨提示" message:[NSString stringWithFormat:FORMAT,##__VA_ARGS__] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil]; [alert show];

// 默认pageSize
#define kDefaultRequestPageSize 20

// json返回结果正确
#define kResOK    0

// 默认图片
#define kImageDefault   [UIImage imageNamed:@"default"]

// block self
#define WEAKSELF typeof(self) __weak weakSelf = self;
#define STRONGSELF typeof(weakSelf) __strong strongSelf = weakSelf;

// 消息通知
#define RegisterNotify(_name, _selector)                    \
[[NSNotificationCenter defaultCenter] addObserver:self  \
selector:_selector name:_name object:nil];

#define RemoveNofify            \
[[NSNotificationCenter defaultCenter] removeObserver:self];

#define SendNotify(_name, _object)  \
[[NSNotificationCenter defaultCenter] postNotificationName:_name object:_object];

#define NETWORKSTATUSCHANGE @"NetworkStatusChange"

#endif /* UtilsMacro_h */
