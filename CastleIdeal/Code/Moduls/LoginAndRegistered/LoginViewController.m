//
//  LoginViewController.m
//  RepublicShare
//
//  Created by 姜鸥人 on 2017/8/24.
//  Copyright © 2017年 姜鸥人. All rights reserved.
//

#import "LoginViewController.h"

//#import <Hyphenate/Hyphenate.h>
//#import <UINavigationController+FDFullscreenPopGesture.h>

#import "UIView+Util.h"
#import "NSString+Util.h"
//#import "HuanxinHandle.h"
//#import "UMSocialHandle.h"
#import "RegisterViewController.h"
#import "MMNavigationController.h"
//#import "ForgetPassWordController.h"


#define PWD_MIN_LENGTH 6
#define PWD_MAX_LENGTH 20
#define MPHONE_MAX_LENGTH 11
@interface LoginViewController ()<UITextFieldDelegate>

@property (nonatomic, retain) UITextField *phoneNumberTField;
@property (nonatomic, retain) UITextField *passWordNumberTField;

@end

@implementation LoginViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    [MobClick beginLogPageView:@"LoginViewController"];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
//    [MobClick endLogPageView:@"LoginViewController"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self generalUI];
}

- (void)generalUI{
//    self.fd_prefersNavigationBarHidden = YES;

    self.view.backgroundColor = kWhite;
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(dismissClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    
    UIImageView *logoImgView = [UIImageView new];
    logoImgView.image = [UIImage imageNamed:@"logo"];
    [self.view addSubview:logoImgView];
    
    UILabel *accountLabel = [UILabel new];
    accountLabel.text = @"账号";
    accountLabel.font = kTextSize16;
    [self.view addSubview:accountLabel];
    
    self.phoneNumberTField = [UITextField new];
    self.phoneNumberTField.font = kTextSize16;
    self.phoneNumberTField.placeholder  = @"请输入手机号码";
    self.phoneNumberTField.keyboardType = UIKeyboardTypeNumberPad;
    self.phoneNumberTField.delegate     = self;
    [self.view addSubview:self.phoneNumberTField];
    
    UIView *lineFirstView = [UIView new];
    lineFirstView.backgroundColor = kLineColor;
    [self.view addSubview:lineFirstView];
    
    UILabel *passWordLabel = [UILabel new];
    passWordLabel.text = @"密码";
    passWordLabel.font = kTextSize16;
    [self.view addSubview:passWordLabel];
    
    self.passWordNumberTField = [UITextField new];
    self.passWordNumberTField.font = kTextSize16;
    self.passWordNumberTField.placeholder     = @"请输入密码";
    self.passWordNumberTField.secureTextEntry = YES;
    self.passWordNumberTField.delegate        = self;
    [self.view addSubview:self.passWordNumberTField];
    
    UIButton *forgetCodeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    forgetCodeButton.titleLabel.font = kTextSize12;
    [forgetCodeButton setTitle:@"忘记密码" forState:UIControlStateNormal];
    [forgetCodeButton setTitleColor:kRGBCOLOR(254, 209, 41) forState:UIControlStateNormal];
    [forgetCodeButton addTarget:self action:@selector(forgetCodeClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forgetCodeButton];
    
    UIView *lineSecondView = [UIView new];
    lineSecondView.backgroundColor = kLineColor;
    [self.view addSubview:lineSecondView];
    
    UIButton *loginInButtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginInButtn setTitle:@"登陆" forState:UIControlStateNormal];
    [loginInButtn addTarget:self action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchUpInside];
    loginInButtn.backgroundColor = kRGB16(0xf53119);
    [loginInButtn cornerViewRadius:6 border:0 color:nil];
    [self.view addSubview:loginInButtn];
    
    UIButton *registeredButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [registeredButton setTitle:@"注册" forState:UIControlStateNormal];
    [registeredButton setTitleColor:kRGBCOLOR(253, 208, 41) forState:UIControlStateNormal];
    [registeredButton addTarget:self action:@selector(registerBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [registeredButton cornerViewRadius:6 border:2.0f color:kRGBCOLOR(253, 208, 41)];
    [self.view addSubview:registeredButton];
    
    UILabel *fastLoginLabel = [UILabel new];
    fastLoginLabel.text = @"快速登陆";
    fastLoginLabel.font = kTextSize14;
    fastLoginLabel.textColor = kRGB16(0x999999);
    [self.view addSubview:fastLoginLabel];
    
    UIView *lineThereView = [UIView new];
    lineThereView.backgroundColor = kLineColor;
    [self.view addSubview:lineThereView];
    
    UIView *lineFourView = [UIView new];
    lineFourView.backgroundColor = kRGB(193);
    [self.view addSubview:lineFourView];
    
    UIButton *qqLoginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [qqLoginButton setImage:[UIImage imageNamed:@"erji_share_qq"] forState:UIControlStateNormal];
    [qqLoginButton addTarget:self action:@selector(qqLoginBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:qqLoginButton];
    
    UIButton *weChatButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [weChatButton setImage:[UIImage imageNamed:@"erji_share_wechat"] forState:UIControlStateNormal];
    [weChatButton addTarget:self action:@selector(weChatLoginBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:weChatButton];
    
    UIButton *sinaButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [sinaButton setImage:[UIImage imageNamed:@"erji_share_-weibo"] forState:UIControlStateNormal];
    [sinaButton addTarget:self action:@selector(sinaLoginBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sinaButton];
    
    // Masonry
    [backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(kSpace10);
        make.top.offset(kStatusBarHeight+7);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    [logoImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view).offset(kNavBarHeight+kSpace10*kHeightRate);
        make.width.height.mas_equalTo(50);
    }];
    [accountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(30);
        make.width.mas_equalTo(35);
        make.top.equalTo(logoImgView.mas_bottom).offset(56*kHeightRate);
        make.left.equalTo(@[lineFirstView,passWordLabel,lineSecondView]);
    }];
    [self.phoneNumberTField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(accountLabel.mas_centerY);
        make.left.equalTo(accountLabel.mas_right).offset(22);
        make.right.equalTo(self.view).offset(-30);
        make.right.equalTo(@[lineFirstView,forgetCodeButton,lineSecondView,lineFourView]);
    }];
    [lineFirstView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(1);
        make.top.equalTo(accountLabel.mas_bottom).offset(kSpace10*kHeightRate);
    }];
    [passWordLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(35);
        make.top.equalTo(lineFirstView.mas_bottom).offset(35*kHeightRate);
    }];
    [forgetCodeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(passWordLabel.mas_centerY);
        make.width.mas_equalTo(60);
    }];
    [self.passWordNumberTField  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(passWordLabel.mas_centerY);
        make.left.equalTo(passWordLabel.mas_right).offset(22);
        make.right.equalTo(forgetCodeButton.mas_left).offset(-15);
    }];
    [lineSecondView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(1);
        make.top.equalTo(passWordLabel.mas_bottom).offset(kSpace10*kHeightRate);
    }];
    [loginInButtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineSecondView.mas_bottom).offset(50*kHeightRate);
        make.left.equalTo(self.view).offset(20);
        make.right.equalTo(self.view).offset(-20);
        make.height.mas_equalTo(44);
    }];
    [registeredButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(loginInButtn.mas_bottom).offset(30*kHeightRate);
        make.left.equalTo(loginInButtn);
        make.right.equalTo(loginInButtn.mas_right);
        make.height.mas_equalTo(44);
    }];
    [fastLoginLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weChatButton.mas_top).offset(-kSpace10);
        make.centerX.equalTo(self.view.mas_centerX);
    }];
    [lineThereView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(fastLoginLabel.mas_centerY);
        make.left.equalTo(self.view).offset(30);
        make.right.equalTo(fastLoginLabel.mas_left).offset(-12);
        make.height.mas_equalTo(1);
    }];
    [lineFourView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(fastLoginLabel.mas_centerY);
        make.left.equalTo(fastLoginLabel.mas_right).offset(12);
        make.height.mas_equalTo(1);
    }];
    CGFloat bottomSpace;
    if (IS_IPHONE_X) {
        bottomSpace = kSpace10+35;
    }else {
        bottomSpace = kSpace10;
    }
    [weChatButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.bottom.lessThanOrEqualTo(self.view.mas_bottom).offset(-bottomSpace);
        make.centerY.equalTo(@[qqLoginButton,sinaButton]);
    }];
    [qqLoginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weChatButton.mas_left).offset(-48);
    }];
    [sinaButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weChatButton.mas_right).offset(48);
    }];
}

#pragma mark ============= Action ==============

- (void)forgetCodeClick {
//    ForgetPasswordController *forgetPWVC = [[ForgetPasswordController alloc]init];
//    [self.navigationController pushViewController:forgetPWVC animated:YES];
}

- (void)registerBtnClick {
    RegisterViewController *registerVC = [[RegisterViewController alloc]init];
    [self.navigationController pushViewController:registerVC animated:YES];
}

- (void)loginBtnClick {
    [SVProgressHUD show];
    NSString *userName = self.phoneNumberTField.text;
    NSString *password = self.passWordNumberTField.text;
    if(![userName isValidMobile] || password.length < PWD_MIN_LENGTH){
        [SVProgressHUD showInfoWithStatus:@"请输入正确的手机号和6位以上的密码"];
        return;
    }
    if(password.length > PWD_MAX_LENGTH){
        [SVProgressHUD showInfoWithStatus:@"密码不能超过20位"];
        return;
    }
    WEAKSELF
//    NSDictionary *urlDic = [UrlParamManager loginInUserWithPhone:userName password:password];
//    [NetManager postUnsignRequestWithUrlParam:urlDic finished:^(id responseObj) {
//        [weakSelf dealWithLoginResponseObj:responseObj];
//    } failed:^(NSString *errorMsg) {
//        [SVProgressHUD showInfoWithStatus:errorMsg];
//    }];
}

- (void)qqLoginBtnClick {
//    [self UMHandleLoginWithPlatformType:UMSocialPlatformType_QQ type:1];
}

- (void)weChatLoginBtnClick {
//    [self UMHandleLoginWithPlatformType:UMSocialPlatformType_WechatSession type:2];
}

- (void)sinaLoginBtnClick {
//    [self UMHandleLoginWithPlatformType:UMSocialPlatformType_Sina type:3];
}
//
//- (void)UMHandleLoginWithPlatformType:(UMSocialPlatformType )platformType type:(NSInteger)type {
//    [SVProgressHUD show];
//    WEAKSELF
//    [UMSocialHandle UMLoginWithPlatformType:platformType Type:type completion:^(id resobjectObj) {
//        [weakSelf dealWithLoginResponseObj:resobjectObj];
//    }];
//}

- (void)dealWithLoginResponseObj:(id)responseObj {
    dispatch_async(dispatch_get_main_queue(), ^{
        WEAKSELF
        if ([responseObj[@"Result"] integerValue] == kResOK) {
//            NSDictionary *resDic = responseObj[@"Data"];
//            UserInfoData *userInfo = [UserInfoData yy_modelWithDictionary:resDic];
//            [userInfo setUserDefault];
//            // 环信登录
//
//            [[HuanxinHandle new] loginWithUsername:[NSString stringWithFormat:@"%ld",(long)userInfo.MemberID] password:userInfo.IMPassWord];
//            [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGE object:nil];
            // 刷新发现界面数据
            [[NSNotificationCenter defaultCenter] postNotificationName:@"RefreshMessageSwippleData" object:nil];//刷新关注和粉丝列表
            [[NSNotificationCenter defaultCenter] postNotificationName:@"RefreshFindData" object:nil];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"RefreshMineData" object:nil];
            
            [SVProgressHUD showSuccessWithStatus:responseObj[@"Message"]];
            [weakSelf dismissClick];
        }else{
            [SVProgressHUD showInfoWithStatus:responseObj[@"Message"]];
        }
    });
}

- (void)dismissClick {
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark ============= textFieldDelegate ==============

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField == self.phoneNumberTField) {
        if (string.length == 0) return YES;
        NSInteger existedLength = textField.text.length;
        NSInteger selectedLength = range.length;
        NSInteger replaceLength = string.length;
        if (existedLength - selectedLength + replaceLength > MPHONE_MAX_LENGTH) {
            return NO;
        }
    }
    return YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

@end
