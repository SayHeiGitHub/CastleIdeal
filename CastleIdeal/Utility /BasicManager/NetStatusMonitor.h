//
//  NetStatusMonitor.h
//  RepublicShare
//
//  Created by 姜鸥人 on 2017/8/24.
//  Copyright © 2017年 姜鸥人. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, ReachabilityStatus) {
    RealStatusNotReachable = 0,
    RealStatusViaWWAN = 1,
    RealStatusViaWiFi = 2
};

@interface NetStatusMonitor : NSObject

+ (instancetype)monitor;

- (ReachabilityStatus)netWorkStatus;

/**
 *  开启网络状态的监听
 */
- (void)startMonitorNetwork;

- (BOOL)isWiFiEnable;

- (BOOL)isNetworkEnable;

- (BOOL)isWWANEnable;

@end
