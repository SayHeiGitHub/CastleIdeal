//
//  BaseDataManager.m
//  RepublicShare
//
//  Created by 姜鸥人 on 2018/3/27.
//  Copyright © 2017年 姜鸥人. All rights reserved.
//

#import "BaseDataManager.h"

@implementation BaseDataManager

+ (instancetype)sharedBaseDataManager {
    
    static BaseDataManager *baseDataManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        baseDataManager = [[BaseDataManager alloc] init];
    });
    
    return baseDataManager;
}

- (NSMutableArray *)getMineBaseData {
    NSMutableArray *mineArray = [[NSMutableArray alloc] initWithCapacity:1];
    [mineArray addObject:@[ @{kTitleKey:@"我的直播", kImageKey:@"mine_zhibo"},
                            @{kTitleKey:@"我的关注", kImageKey:@"mine_guanzhu"} ]];
    [mineArray addObject:@[ @{kTitleKey:@"我的提问", kImageKey:@"mine_tiwen"},
                            @{kTitleKey:@"我的回答", kImageKey:@"mine_huida"},
                            @{kTitleKey:@"我的收藏", kImageKey:@"mine_shoucang"},
                            @{kTitleKey:@"我的偷听", kImageKey:@"mine_touting"} ]];
    [mineArray addObject:@[ @{kTitleKey:@"我的钱包", kImageKey:@"mine_qianbao"} ]];
    [mineArray addObject:@[ @{kTitleKey:@"消息中心", kImageKey:@"mine_xiaoxi"} ]];
    return mineArray;
}

//- (void)getSearchBefData {
//    NSMutableArray *searchBeforTagsArray = [[NSMutableArray alloc] init];
////    NSDictionary *urlParam = [UrlParamManager skillTabListWithTypeId:@"3"];
//    [NetManager postUnsignRequestWithUrlParam:urlParam finished:^(id responseObj) {
//        if ([responseObj[@"Result"] integerValue] == kResOK) {
//            NSArray *tempArray = responseObj[@"Data"];
//            if (tempArray.count > 0) {
//                [tempArray enumerateObjectsUsingBlock:^(NSDictionary *subdic, NSUInteger idx, BOOL * _Nonnull stop) {
//                    [searchBeforTagsArray addObject:subdic[@"Name"]];
//                }];
//            }
//            if (tempArray.count == 0) {
//                [searchBeforTagsArray addObject:@"圆圆"];
//            }
//            self.homeSearchBefDataArray = searchBeforTagsArray;
//        }
//    } failed:^(NSString *errorMsg) {
//        RSLog(@"error:%@",errorMsg);
//    }];
//}

- (NSMutableArray *)setMineBaseData{
    NSMutableArray *mineArray = [[NSMutableArray alloc] initWithCapacity:1];
    [mineArray addObject:@[ @{kTitleKey:@"视频播放设置", kImageKey:@""},
                            @{kTitleKey:@"不看谁的动态", kImageKey:@""},
                            @{kTitleKey:@"黑名单",      kImageKey:@""} ]];
    
    [mineArray addObject:@[ @{kTitleKey:@"用户协议",    kImageKey:@""},
                            @{kTitleKey:@"平台行为规范", kImageKey:@""},
                            @{kTitleKey:@"清理缓存",    kImageKey:@""}]];
    
    [mineArray addObject:@[ @{kTitleKey:@"检查新版本", kImageKey:@""},
                            @{kTitleKey:@"软件评分",  kImageKey:@""}]];
    return mineArray;
}

- (NSMutableArray *)setUserMessageData{
    NSMutableArray *mineArray = [[NSMutableArray alloc] initWithCapacity:1];
    [mineArray addObject:@[ @{kTitleKey:@"头像", kImageKey:@""},
                            @{kTitleKey:@"昵称", kImageKey:@""},
                            @{kTitleKey:@"性别", kImageKey:@""},
                            @{kTitleKey:@"生日", kImageKey:@""},
                            @{kTitleKey:@"家乡", kImageKey:@""}]];
    [mineArray addObject:@[ @{kTitleKey:@"修改密码", kImageKey:@""},
                            @{kTitleKey:@"绑定手机", kImageKey:@""}
                            ]];
    return mineArray;
}


@end
