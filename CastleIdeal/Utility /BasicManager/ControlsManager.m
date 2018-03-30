//
//  ControlsManager.m
//  RepublicShare
//
//  Created by 姜鸥人 on 2018/3/27.
//  Copyright © 2017年 姜鸥人. All rights reserved.
//

#import "ControlsManager.h"

@implementation ControlsManager

+(UILabel *)createLabelWithFrame:(CGRect)frame text:(NSString *)text font:(UIFont *)font textColor:(UIColor *)textColor textAlignment:(NSInteger)textAlignment backgroundColor:(UIColor *)backgroundColor {
    UILabel*label       = [[UILabel alloc] initWithFrame:frame];
    label.font          = font;
    label.numberOfLines = 1;
    label.text          = text;
    label.textColor     = textColor;
    switch (textAlignment) {
        case 0:
            label.textAlignment = NSTextAlignmentLeft;
            break;
        case 1:
            label.textAlignment = NSTextAlignmentCenter;
            break;
        case 2:
            label.textAlignment = NSTextAlignmentRight;
            break;
        default:
            break;
    }
    if (backgroundColor) {
        label.backgroundColor   = backgroundColor;
    }
    else{
        label.backgroundColor   = [UIColor clearColor];
    }
    return label;
}

+ (UILabel *)createLabelWithtext:(NSString *)text font:(UIFont *)font textColor:(UIColor *)textColor  backgroundColor:(UIColor *)backgroundColor {
    UILabel*label       = [[UILabel alloc] init];
    label.font          = font;
//    label.lineBreakMode = NSLineBreakByCharWrapping;
    label.numberOfLines = 1;
    label.textColor     = textColor;
    label.text          = text;
    if (backgroundColor) {
        label.backgroundColor = backgroundColor;
    }
    else{
        label.backgroundColor = [UIColor clearColor];
    }
    return label;
}


@end
