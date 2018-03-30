//
//  RegisterViewController.m
//  RepublicShare
//
//  Created by 姜鸥人 on 2017/9/10.
//  Copyright © 2017年 姜鸥人. All rights reserved.
//

#import "RegisterViewController.h"

//#import "RSTimeBtn.h"
#import "NSString+Util.h"
//#import <SMS_SDK/SMSSDK.h>
//#import <Hyphenate/Hyphenate.h>
#import "RSBaseWebViewController.h"

@interface RegisterViewController ()

@property (nonatomic, strong) UIView      *whiteViewF;
@property (nonatomic, strong) UIView      *whiteViewS;
@property (nonatomic, strong) UIView      *whiteViewT;
//@property (nonatomic, strong) RSTimeBtn   *sendCodeBtn;
@property (nonatomic, strong) UIButton    *userProtocol;
@property (nonatomic, strong) UITextField *passWordTField;
@property (nonatomic, strong) UIButton    *sureMessageBtn;
@property (nonatomic, strong) UILabel     *userProtocolLabel;
@property (nonatomic, strong) UITextField *phoneNumberTField;
@property (nonatomic, strong) UITextField *verificationCodeTField;

@end

@implementation RegisterViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    [MobClick beginLogPageView:@"RegisterViewController"];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
//    [MobClick endLogPageView:@"RegisterViewController"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addTiTle:@"注册"];
    [self setSubView];
    [self addLeftBackButton];
}

- (void)setSubView {
    self.whiteViewF = [UIView new];
    self.whiteViewF.backgroundColor = kWhite;
    [self.view addSubview:self.whiteViewF];
    
    self.phoneNumberTField = [UITextField new];
    self.phoneNumberTField.placeholder = @"请输入手机号";
    self.phoneNumberTField.font = kTextSize16;
    self.phoneNumberTField.keyboardType = UIKeyboardTypeNumberPad;
    [self.whiteViewF addSubview:self.phoneNumberTField];
    
    self.whiteViewS = [UIView new];
    self.whiteViewS.backgroundColor = kWhite;
    [self.view addSubview:self.whiteViewS];
    
    self.verificationCodeTField = [UITextField new];
    self.verificationCodeTField.placeholder = @"请输入验证码";
    self.verificationCodeTField.font = kTextSize16;
    self.verificationCodeTField.keyboardType = UIKeyboardTypeNumberPad;
    [self.whiteViewS addSubview:self.verificationCodeTField];
    
//    self.sendCodeBtn = [RSTimeBtn new];
//    self.sendCodeBtn.backgroundColor = kRGBCOLOR(253, 208, 41);
//    self.sendCodeBtn.normalTintColor = kBlack;
//    self.sendCodeBtn.layer.masksToBounds = YES;
//    self.sendCodeBtn.layer.cornerRadius = 6;
//    self.sendCodeBtn.fontSize = 14;
//    self.sendCodeBtn.tag = 77701;
//    WEAKSELF
//    [self.sendCodeBtn doneSend:^{
//        [weakSelf sendCodeBtnClick];
//    }];
//    [self.whiteViewS addSubview:self.sendCodeBtn];
    
    self.whiteViewT = [UIView new];
    self.whiteViewT.backgroundColor = kWhite;
    [self.view addSubview:self.whiteViewT];
    
    self.passWordTField =  [UITextField new];
    self.passWordTField.placeholder = @"请输入密码";
    self.passWordTField.secureTextEntry = YES;
    self.passWordTField.font = kTextSize16;
    [self.whiteViewT addSubview:self.passWordTField];
    
    self.sureMessageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.sureMessageBtn setTitle:@"确认" forState:UIControlStateNormal];
    self.sureMessageBtn.backgroundColor = kRGBCOLOR(253, 208, 41);
    self.sureMessageBtn.layer.masksToBounds = YES;
    self.sureMessageBtn.layer.cornerRadius = 6;
    [self.sureMessageBtn addTarget:self action:@selector(sureMessageBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.sureMessageBtn];
    
    self.userProtocolLabel = [UILabel new];
    self.userProtocolLabel.text = @"点击确认即表示同意";
    self.userProtocolLabel.font = kTextSize12;
    self.userProtocolLabel.textColor = kRGB16(0x999999);
    [self.view addSubview:self.userProtocolLabel];
    
    self.userProtocol = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.userProtocol setTitleColor:kYellow forState:UIControlStateNormal];
    [self.userProtocol setTitle:@"《理想城堡用户协议》" forState:UIControlStateNormal];
    self.userProtocol.titleLabel.font = kTextSize13;
    [self.userProtocol addTarget:self action:@selector(userProtocolBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.userProtocol];
    
    // Masonry
    [self.whiteViewF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(20);
        make.width.equalTo(self.view);
        make.height.mas_equalTo(50);
    }];
    [self.whiteViewS mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.whiteViewF.mas_bottom).offset(20);
        make.width.equalTo(self.view);
        make.height.mas_equalTo(50);
    }];
    [self.whiteViewT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.whiteViewS.mas_bottom).offset(20);
        make.width.equalTo(self.view);
        make.height.mas_equalTo(50);
    }];
    [self.phoneNumberTField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.whiteViewF.mas_centerY);
        make.left.equalTo(self.view).offset(20);
        make.right.equalTo(self.view);
    }];
    [self.verificationCodeTField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.whiteViewS.mas_centerY);
        make.left.equalTo(self.view).offset(20);
        make.right.equalTo(self.view).offset(-110);
    }];
//    [self.sendCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(self.whiteViewS.mas_centerY);
//        make.left.equalTo(self.verificationCodeTField.mas_right).offset(10);
//        make.width.mas_equalTo(90);
//        make.height.mas_equalTo(38);
//    }];
    [self.passWordTField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.whiteViewT.mas_centerY);
        make.left.equalTo(self.view).offset(20);
        make.right.equalTo(self.view);
    }];
    [self.sureMessageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.whiteViewT.mas_bottom).offset(31);
        make.left.equalTo(self.view).offset(20);
        make.right.equalTo(self.view).offset(-20);
        make.height.mas_equalTo(44);
    }];
    [self.userProtocol mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.sureMessageBtn.mas_bottom).offset(16);
        make.right.equalTo(self.sureMessageBtn.mas_right);
    }];
    [self.userProtocolLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.userProtocol.mas_left).offset(-2);
        make.centerY.equalTo(self.userProtocol.mas_centerY);
    }];
}

- (void)sureMessageBtnClick {
    WEAKSELF
//    [self.verificationCodeTField resignFirstResponder];
//    NSDictionary *urlDic = [UrlParamManager registerUserWithPhone:self.phoneNumberTField.text vCode:self.passWordTField.text password:self.verificationCodeTField.text];
//    [NetManager postUnsignRequestWithUrlParam:urlDic finished:^(id responseObj) {
//        if ([responseObj[@"Result"] integerValue] == kResOK) {
//            [SVProgressHUD showSuccessWithStatus:@"注册成功!"];
//            [[NSNotificationCenter defaultCenter] postNotificationName:@"isReg" object:nil];
//            [weakSelf backClick];
//        }else{
//            [SVProgressHUD showInfoWithStatus:responseObj[@"Message"]];
//        }
//
//    } failed:^(NSString *errorMsg) {
//        RSLog(@"error:%@",errorMsg);
//    }];
}

- (void)userProtocolBtnClick {
    RSBaseWebViewController *webVC = [[RSBaseWebViewController alloc] init];
    webVC.titleString = @"用户协议";
    webVC.urlString   = kUserProtocol;
    [self.navigationController pushViewController:webVC animated:YES];
}

- (void)sendCodeBtnClick {
    if ([self.phoneNumberTField.text isValidMobile]) {
        [self.phoneNumberTField resignFirstResponder];
        [self.verificationCodeTField becomeFirstResponder];
//        self.sendCodeBtn.userInteractionEnabled = YES;
//        WEAKSELF
//        [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:weakSelf.phoneNumberTField.text zone:@"86" result:^(NSError *error) {
//        }];
    }else{
        [SVProgressHUD showInfoWithStatus:@"请输入正确的手机号"];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}


- (void)dealloc {
    NSLog(@"%@ dealloc",NSStringFromClass([self class]));
}
@end

