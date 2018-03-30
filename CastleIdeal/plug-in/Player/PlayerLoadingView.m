//
// Created by imooc on 16/5/5.
// Copyright (c) 2016 SunYuanYang. All rights reserved.
//


#import "PlayerLoadingView.h"

#import <Masonry.h>

#import "NetStatusMonitor.h"

@implementation PlayerLoadingView

- (void)dealloc {
    [self releaseSpace];
}

- (void)releaseSpace {
    [_rotateView releaseSpace];
    
    [_loadingImageView removeFromSuperview];
    _loadingImageView = nil;
    
    [_rotateView removeFromSuperview];
    _rotateView = nil;
}

- (instancetype)init {
    if (self = [super init]) {
        self.userInteractionEnabled = YES;
//        _loadingImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"default"]];
        _loadingImageView = [[UIImageView alloc] init];
        _loadingImageView.backgroundColor = kRGB16(0x1f1f1f);
        _loadingImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick)];
        [_loadingImageView addGestureRecognizer:tap];
        _rotateView = [[PlayerLoadingRotateView alloc] init];

        [self addSubview:_loadingImageView];
        [self addSubview:_rotateView];
        self.hidden = YES;
    }
    return self;
}

- (void)tapClick {
    if (self.tapLoadingViewBlock) {
        self.tapLoadingViewBlock();
    }
}

- (void)updateConstraints {

    [_loadingImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(self);
    }];

    [_rotateView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.centerY.mas_equalTo(self);
        make.width.height.mas_equalTo(52);
    }];

    [super updateConstraints];
}

/** loading有背景图 */
- (void)startRotatingAndDefaultBg {
    self.hidden = NO;
    _loadingImageView.hidden = NO;
    [_rotateView startRotating];
}

/** loading无背景图 */
- (void)startRotatingNoDefaultBg {
    self.hidden = NO;
    _loadingImageView.hidden = YES;
    [_rotateView startRotating];
}

- (void)endRotating {
    [_rotateView endRotating];
    self.hidden = YES;
}

@end


@interface PlayerLoadingRotateView ()

@property(nonatomic, strong) NSTimer *timer;
@property(nonatomic, assign) NSInteger curTimes;
@property(nonatomic, assign) NSInteger repeatTimes;
@property(nonatomic, assign) NSInteger lastProgress;
@property(nonatomic, assign) NSInteger kbs;

@end

@implementation PlayerLoadingRotateView

- (void)dealloc {
    [self releaseSpace];
}

- (void)releaseSpace {
    [self endRotating];
    if (self.timer.isValid) {
        [self.timer invalidate];
        self.timer = nil;
    }
    
    [_rotateImageView removeFromSuperview];
    [_downloadRateLabel removeFromSuperview];
    _rotateImageView = nil;
    _downloadRateLabel = nil;
    
    NSLog(@"%@__dealloc", NSStringFromClass([self class]));
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _rotateImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_play_loading"]];
        [self addSubview:_rotateImageView];
        _rotateImageView.userInteractionEnabled = YES;
        _downloadRateLabel = [[UILabel alloc] init];
        [self addSubview:_downloadRateLabel];
        _downloadRateLabel.textColor = [UIColor whiteColor];
        _downloadRateLabel.font = [UIFont systemFontOfSize:14];

    }
    return self;
}

- (void)updateConstraints {
    [_rotateImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
         make.top.left.right.bottom.mas_equalTo(self);
    }];

    [_downloadRateLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
    [super updateConstraints];
}

- (void)startRotating {
    if (_isLoading) {
        return;
    }
    _isLoading = YES;

    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.fromValue = @(0);
    animation.toValue = @(2 * M_PI);
    animation.duration = 2.f;
    animation.repeatCount = INT_MAX;
    [_rotateImageView.layer addAnimation:animation forKey:@"rotateAnimation"];
    [self roadomShowRate];
}

- (void)endRotating {
    _isLoading = NO;
    [_rotateImageView.layer removeAnimationForKey:@"rotateAnimation"];
    if (_timer.isValid) {
        [_timer invalidate];
    }
    [self updateNetRate:@"0kb"];
}

- (void)updateNetRate:(nonnull NSString *)netRate {
    _downloadRateLabel.text = netRate;
}

- (void)roadomShowRate {
    if (_timer.isValid) {
        [_timer invalidate];
    }

    self.curTimes = 0;
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:.2 target:self selector:@selector(timeTick) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSDefaultRunLoopMode];
}

- (void)timeTick {
    if (self.repeatTimes == 0) {
        [self updateNetRate:@"0kb"];
        if (_timer.isValid) {
            [_timer invalidate];
        }
        return;
    }
    if (_curTimes < self.repeatTimes / 2) {
        [self updateNetRate:[NSString stringWithFormat:@"%ldkb", (long) self.kbs]];
    }
    else if (_curTimes < self.repeatTimes) {
        _lastProgress += arc4random() % 20;
        if (_lastProgress > 90) {
            _lastProgress = arc4random() % 10 + 90;
        }
        [self updateNetRate:[NSString stringWithFormat:@"%ld%%", (long) _lastProgress]];
    }
    else {
        if (_timer.isValid) {
            [_timer invalidate];
        }
    }
    _curTimes++;
}


- (NSInteger)repeatTimes {
    ReachabilityStatus netStatus = [[NetStatusMonitor monitor] netWorkStatus];
    switch (netStatus) {
        case RealStatusViaWiFi:
            _repeatTimes = arc4random() % 10 + 15;
            break;
        case RealStatusViaWWAN:
            _repeatTimes = arc4random() % 20 + 15;
            break;
        default:
            _repeatTimes = 0;
            break;
    }

    return _repeatTimes;
}

- (NSInteger)kbs {
    ReachabilityStatus netStatus = [[NetStatusMonitor monitor] netWorkStatus];
    switch (netStatus) {
        case RealStatusViaWiFi:
            _kbs = arc4random() % 150 + 30;
            break;
        case RealStatusViaWWAN:
            _kbs = arc4random() % 100 + 15;
            break;
        default:
            _kbs = 0;
            break;
    }

    return _kbs;
}


@end
