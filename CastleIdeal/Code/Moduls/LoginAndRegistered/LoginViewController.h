//
//  LoginViewController.h
//  RepublicShare
//
//  Created by 姜鸥人 on 2017/8/24.
//  Copyright © 2017年 姜鸥人. All rights reserved.
//

#import "RSBaseViewController.h"

typedef NS_ENUM(NSInteger, FastLoginType){
    FastLoginType_QQ = 1,
    FastLoginType_WX = 2,
    FastLoginType_Sine = 3,
};

@interface LoginViewController : RSBaseViewController
@end
