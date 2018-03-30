//
//  NetStatusMonitor.m
//  RepublicShare
//
//  Created by 姜鸥人 on 2017/8/24.
//  Copyright © 2017年 姜鸥人. All rights reserved.
//

#import "NetStatusMonitor.h"

#import <Reachability.h>

@interface NetStatusMonitor () {
    
    Reachability * _reachability;
}

@end

@implementation NetStatusMonitor

+ (instancetype)monitor {
    
    static NetStatusMonitor * monitor;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        monitor = [[NetStatusMonitor alloc]init];
    });
    return monitor;
}

/**
 *  开启网络状态的监听
 */
- (void)startMonitorNetwork {
    
    RegisterNotify(kReachabilityChangedNotification, @selector(reachabilityChanged:))
    _reachability = [Reachability reachabilityForInternetConnection];
    [_reachability startNotifier];
    //    [AppDelegate delegate].networkStatus = _reachability.currentReachabilityStatus;
}


- (void)reachabilityChanged:(NSNotification *)notice {
    
    NetworkStatus status = _reachability.currentReachabilityStatus;
    switch (status) {
        case NotReachable:
            RSLog(@"无连接");
            break;
        case ReachableViaWiFi:
            RSLog(@"WiFi连接");
            break;
        case ReachableViaWWAN:
            RSLog(@"数据网络");
            break;
        default:
            break;
    }
    SendNotify(NETWORKSTATUSCHANGE, nil)
}

- (ReachabilityStatus)netWorkStatus {
    NetworkStatus reachabilityStatus = [_reachability currentReachabilityStatus];
    ReachabilityStatus status;
    if (reachabilityStatus == ReachableViaWiFi) {
        status = RealStatusViaWiFi;
    } else if (reachabilityStatus == ReachableViaWWAN) {
        status = RealStatusViaWWAN;
    } else {
        status = RealStatusNotReachable;
    }
    
    return status;
}

- (BOOL)isReachable {
    return [self netWorkStatus] == RealStatusViaWWAN || [self netWorkStatus] == RealStatusViaWiFi;
}

- (BOOL)isWiFiEnable {
    
    return [self netWorkStatus]  == ReachableViaWiFi;
}

- (BOOL)isNetworkEnable {
    
    return [self netWorkStatus]  != NotReachable;
}

- (BOOL)isWWANEnable {
    
    return [self netWorkStatus]  == ReachableViaWWAN;
}

@end
