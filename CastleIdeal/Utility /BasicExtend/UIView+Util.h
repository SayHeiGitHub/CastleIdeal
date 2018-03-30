//
//  UIView+Util.h
//  RepublicShare
//
//  Created by 姜鸥人 on 2018/3/27.
//  Copyright © 2017年 姜鸥人. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Util)

@property(nonatomic, assign) CGFloat mm_x;
@property(nonatomic, assign) CGFloat mm_y;
@property(nonatomic, assign) CGFloat mm_width;
@property(nonatomic, assign) CGFloat mm_height;
@property(nonatomic, assign) CGFloat mm_right;
@property(nonatomic, assign) CGFloat mm_left;
@property(nonatomic, assign) CGFloat mm_top;
@property(nonatomic, assign) CGFloat mm_bottom;
@property(nonatomic, assign) CGFloat mm_centerX;
@property(nonatomic, assign) CGFloat mm_centerY;
@property(nonatomic, assign) CGPoint mm_origin;
@property(nonatomic, assign) CGSize mm_size;


- (UIView*)subViewOfClassName:(NSString*)className;

//  圆角
- (void)cornerViewRadius:(CGFloat)radius border:(CGFloat)border color:(UIColor *)color;
//  手势
- (void)addGestureAction:(SEL)mothod target:(id)target;



@end
