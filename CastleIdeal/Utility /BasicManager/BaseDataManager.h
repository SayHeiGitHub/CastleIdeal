//
//  BaseDataManager.h
//  RepublicShare
//
//  Created by 姜鸥人 on 2018/3/27.
//  Copyright © 2017年 姜鸥人. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kTitleKey @"title"
#define kImageKey @"image"

@interface BaseDataManager : NSObject

+ (instancetype)sharedBaseDataManager;

// mineBase数据
- (NSMutableArray *)getMineBaseData;

// 搜索前界面的推荐数据
- (void)getSearchBefData;
@property(nonatomic, strong) NSMutableArray *homeSearchBefDataArray;

// 设置页列表
- (NSMutableArray *)setMineBaseData;

// 用户信息表
- (NSMutableArray *)setUserMessageData;

@end
