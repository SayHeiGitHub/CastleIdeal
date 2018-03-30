//
//  LaunchingScrollView.m
//  RepublicShare
//
//  Created by 姜鸥人 on 2017/8/23.
//  Copyright © 2017年 姜鸥人. All rights reserved.
//

#import "LaunchingScrollView.h"

@interface LaunchingScrollView ()<UIScrollViewDelegate>

@property(nonatomic, strong) NSArray *imgArray;
@end

@implementation LaunchingScrollView


-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor=[UIColor whiteColor];
        _imgArray =@[@"guide1",@"guide2"];
        CGFloat wid = frame.size.width;
        CGFloat height = frame.size.height;
        UIScrollView *launchScrollView =[[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        launchScrollView.backgroundColor=[UIColor clearColor];
        launchScrollView.contentSize = CGSizeMake(wid*_imgArray.count, 0);
        launchScrollView.pagingEnabled =YES;
        launchScrollView.delegate =self;
        launchScrollView.showsHorizontalScrollIndicator = NO;
        [self addSubview:launchScrollView];
        
        [_imgArray enumerateObjectsUsingBlock:^(NSString *imgStr, NSUInteger idx, BOOL * _Nonnull stop) {
            UIImageView *guideImgView = [[UIImageView alloc] init];
            guideImgView.frame        = CGRectMake(idx*wid, 0, wid, height);
            guideImgView.image        = [UIImage imageNamed:imgStr];
            [launchScrollView addSubview:guideImgView];
            guideImgView.userInteractionEnabled =YES;
            if (idx == _imgArray.count-1) {
                UIButton *welcomeBtn =[UIButton buttonWithType:UIButtonTypeCustom];
                [welcomeBtn setFrame:CGRectMake((wid/2-50), height-80, 100, 47)];
                [welcomeBtn setImage:[UIImage imageNamed:@"lijitiyan"] forState:UIControlStateNormal];
                [welcomeBtn addTarget:self action:@selector(welcomeBtnClick) forControlEvents:UIControlEventTouchUpInside];
                [guideImgView addSubview:welcomeBtn];
            }
        }];
    }
    return self;
}

-(void)welcomeBtnClick{
    [UIView animateWithDuration:1 animations:^{
        // self.transform = CGAffineTransformMakeScale(1.6, 1.6); //放大
        self.alpha=0;
    }completion:^(BOOL finished) {
        //更改登陆过的标示，以便后续登陆，不需要加载引导页面
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:[NSString stringWithFormat:@"KEY_HASLOGIN_%@",kCURRENT_APP_VERSION]];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [self removeFromSuperview];
    }];
}

//向右滑到最后时,也同样进入主页面
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    CGFloat wid = self.frame.size.width;
    if (scrollView.contentOffset.x>(_imgArray.count-1)*wid+30) {
        [self welcomeBtnClick];
    }
}

@end
