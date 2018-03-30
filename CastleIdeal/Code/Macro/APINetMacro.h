//
//  APINetMacro.h
//  RepublicShare
//
//  Created by 姜鸥人 on 2018/3/27.
//  Copyright © 2017年 姜鸥人. All rights reserved.
//

#ifndef APINetMacro_h
#define APINetMacro_h

/**
 *  _APP_ENVIRMENT_为后台环境参数
 *  0为用外网进行测试/用内网测试, 1为阿里云正式服务器, 2为连接后台机器测试
 */
#define _APP_ENVIRMENT_ 1

// 0为测试环境 （内网／外网 咱不区分）
#if ((_APP_ENVIRMENT_) == 0)

#define kHostAddr       @"http://59.110.48.164:9011/api"
#define kHuanXinCerName @"develop"
#define kUserProtocol   @"http://59.110.48.164:9011/protocol.html"
#define kUserConvention @"http://59.110.48.164:9011/Convention.html"

// 1为正式服务器，用于发布
#elif ((_APP_ENVIRMENT_) == 1)

#define kHostAddr       @"http://59.110.48.164:9001/api"
#define kHuanXinCerName @"production"
#define kUserProtocol   @"http://59.110.48.164:9001/protocol.html"
#define kUserConvention @"http://59.110.48.164:9001/Convention.html"

#endif


#endif /* APINetMacro_h */
