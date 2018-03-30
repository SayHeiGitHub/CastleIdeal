//
//  ControlsManager.h
//  RepublicShare
//
//  Created by 姜鸥人 on 2018/3/27.
//  Copyright © 2017年 姜鸥人. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

@interface ControlsManager : NSObject

/**
 *   创建 label
 *
 *   带frame的一般布局，设置frame  font默认系统字体
 *   不带frame的一般布局， 用 masonry 布局
 */
+ (UILabel *)createLabelWithFrame:(CGRect)frame text:(NSString *)text font:(UIFont *)font textColor:(UIColor *)textColor textAlignment:(NSInteger)textAlignment backgroundColor:(UIColor *)backgroundColor;

+ (UILabel *)createLabelWithtext:(NSString *)text font:(UIFont *)font textColor:(UIColor *)textColor  backgroundColor:(UIColor *)backgroundColor;

@end
