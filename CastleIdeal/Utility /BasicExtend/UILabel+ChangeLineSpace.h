//
//  UILabel+ChangeLineSpace.h
//  RepublicShare
//
//  Created by 姜鸥人 on 2017/11/22.
//  Copyright © 2017年 姜鸥人. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (ChangeLineSpace)

/**
 *  改变行间距
 */
+ (void)changeSpaceForLabel:(UILabel *)label lineSpace:(CGFloat)lineSpace;
/**
 *  改变行间距和字间距
 */
+ (void)changeSpaceForLabel:(UILabel *)label lineSpace:(CGFloat)lineSpace wordSpace:(CGFloat)wordSpace;

@end
