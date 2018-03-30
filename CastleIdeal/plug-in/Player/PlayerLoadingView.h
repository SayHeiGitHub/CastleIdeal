//
// Created by imooc on 16/5/5.
// Copyright (c) 2016 SunYuanYang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PlayerLoadingRotateView;

@interface PlayerLoadingView : UIView {
    UIImageView *_loadingImageView;         ///< loading 图
    PlayerLoadingRotateView *_rotateView;     ///< 旋转loading
}

@property (nonatomic, copy) void (^ _Nullable tapLoadingViewBlock) (void);

- (void)releaseSpace;

/** loading有背景图 */
- (void)startRotatingAndDefaultBg;

/** loading无背景图 */
- (void)startRotatingNoDefaultBg;

- (void)endRotating;

@end


@interface PlayerLoadingRotateView : UIView {
    UIImageView *_rotateImageView;
    UILabel *_downloadRateLabel;
    BOOL _isLoading;
}

- (void)releaseSpace;

- (void)startRotating;

- (void)endRotating;

- (void)updateNetRate:(nonnull NSString *)netRate;

- (void)roadomShowRate;

@end
