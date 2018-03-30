//
//  RSBaseViewController.m
//  RepublicShare
//
//  Created by 姜鸥人 on 2018/3/27.
//  Copyright © 2017年 姜鸥人. All rights reserved.
//

#import "RSBaseViewController.h"

//#import "LoginViewController.h"
#import "MMNavigationController.h"

@interface RSBaseViewController ()

@end

@implementation RSBaseViewController

- (id)init{
    self = [super init];
    if (self) {
//        self.canInteractivePopGestureRecognizer = YES;
        //   self.hidesBottomBarWhenPushed=YES;
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    //手势代理建议放在willAppear里，防止有些单例的VC无法加载
//    self.navigationController.interactivePopGestureRecognizer.delegate=(id)self;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = kBaseBgColor;
}

//      导航栏的title
-(void)addTiTle:(NSString *)title{
    UILabel *label =[[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth/2, kNavBarHeight)];
    label.text = title;
    label.font = [UIFont systemFontOfSize:18];
    label.textColor = kDeepDark;
    label.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = label;
}

//     导航栏的左右两侧navigationItem
-(void)addimage:(UIImage *)image title:(NSString *)title selector:(SEL)selector location:(BOOL)isLeft {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    if (image) {
        btn.frame = CGRectMake(0, kSpace10, kSpace20, kSpace20);
        [btn setImage:image forState:UIControlStateNormal];
    }else {
        btn.frame = CGRectMake(0, kSpace10, 30, 30);
        [btn setTitleColor:kRGB16(0x666666) forState:UIControlStateNormal];
        [btn setTitle:title forState:UIControlStateNormal];
        btn.titleLabel.font = kTextSize14;
    }
    [btn addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *item =[[UIBarButtonItem alloc] initWithCustomView:btn];
    if (isLeft == YES) {
        self.navigationItem.leftBarButtonItem = item;
    }else{
        self.navigationItem.rightBarButtonItem = item;
    }
}

//     导航栏的返回按钮
-(void)addLeftBackButton {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 10, 20, 20);
    [btn setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item =[[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = item;
}
//
//-(void)addRightButton:(UIButton *)btn {
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    btn.frame = CGRectMake(0, 10, 20, 20);
//    [btn setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
//    [btn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *item =[[UIBarButtonItem alloc] initWithCustomView:btn];
//    self.navigationItem.leftBarButtonItem = item;
//}

-(void)backClick {
    [SVProgressHUD dismiss];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)dismissClick {
    [SVProgressHUD dismiss];
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

//  没有登录的话  会直接弹出 登录界面
//- (void)presentToLoginController {
//    LoginViewController *loginVC = [[LoginViewController alloc] init];
//    MMNavigationController *nav  = [[MMNavigationController alloc] initWithRootViewController:loginVC];
//    [self presentViewController:nav animated:YES completion:nil];
//}

/**
 *  验证是否登录
 *  return   Yes 没登录 跳转登录界面 ，  NO 登录
 */
//- (BOOL)verityLoginAction {
//    UserInfoData *userInfo = [UserInfoData getUserDefault];
//    if (!userInfo.isLogin) {
//        [self presentToLoginController];
//        return YES;
//    }
//    return NO;
//}

//- (BOOL)jumpResStatusWithResponseObj:(id)responseObj {
//    NSInteger resInt = [responseObj[@"Result"] integerValue];
//    if ( resInt != kResOK) {
//        if (resInt == 2) {
//            [UserInfoData resetUserDefault];
////            [SVProgressHUD showErrorWithStatus:@"登录失效，请重新登录"];
//            [self presentToLoginController];
//        }
//        return YES;
//    }
//    return NO;
//}



@end
