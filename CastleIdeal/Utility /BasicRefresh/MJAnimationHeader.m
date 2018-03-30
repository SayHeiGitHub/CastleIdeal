//
//  MJAnimationHeader.m
//  RepublicShare
//
//  Created by 姜鸥人 on 2018/3/27.
//  Copyright © 2017年 姜鸥人. All rights reserved.
//

#import "MJAnimationHeader.h"

@implementation MJAnimationHeader

#pragma mark - 重写方法
#pragma mark 基本设置
- (void)prepare
{
    [super prepare];
    
    // 设置普通状态的动画图片
    NSMutableArray *idleImages = [NSMutableArray array];
    for (NSUInteger i = 1; i <= 32; i ++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%zd_03", i]];
        [idleImages addObject:image];
    }
    [self setImages:idleImages forState:MJRefreshStateIdle];
    [self setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 1; i <= 32; i ++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%zd_03", i]];
        [refreshingImages addObject:image];
    }
    [self setImages:refreshingImages duration:3 forState:MJRefreshStatePulling];
    [self setTitle:@"释放刷新" forState:MJRefreshStatePulling];
    
    // 设置正在刷新状态的动画图片
    [self setImages:refreshingImages duration:3 forState:MJRefreshStateRefreshing];
    [self setTitle:@"加载中..." forState:MJRefreshStateRefreshing];
    self.stateLabel.textColor = kRGB16(0x919192);
    self.stateLabel.font = kTextSize13;
    self.lastUpdatedTimeLabel.hidden=YES;
}

- (void)placeSubviews
{
    [super placeSubviews];
//    self.mj_h = 65;
//       // self.gifView.contentMode = UIViewContentModeCenter;
//       // self.gifView.mj_w = self.mj_w * 0.5 - 20;
//    self.stateLabel.mj_x=self.stateLabel.mj_x+20;
}


@end
