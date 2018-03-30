//
//  RSBaseViewController.h
//  RepublicShare
//
//  Created by 姜鸥人 on 2018/3/27.
//  Copyright © 2017年 姜鸥人. All rights reserved.
//

#import "MMViewController.h"

@interface RSBaseViewController : MMViewController

/** 是否支持侧滑返回，默认为YES */
@property(nonatomic,assign)BOOL canInteractivePopGestureRecognizer;

- (void)addTiTle:(NSString *)title;
- (void)addLeftBackButton;
- (void)addimage:(UIImage *)image title:(NSString *)title selector:(SEL)selector location:(BOOL)isLeft;
-(void)addRightButton:(UIButton *)btn;
- (void)backClick;
- (void)dismissClick;
- (BOOL)verityLoginAction;
- (void)presentToLoginController; //跳转到登录界面
- (BOOL)jumpResStatusWithResponseObj:(id)responseObj;
@end
