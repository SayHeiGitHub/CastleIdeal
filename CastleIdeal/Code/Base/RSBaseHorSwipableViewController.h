//
//  RSBaseHorSwippleViewController.h
//  RepublicShare
//
//  Created by 姜鸥人 on 2017/10/24.
//  Copyright © 2017年 姜鸥人. All rights reserved.
//

#import "RSBaseViewController.h"

typedef void(^ScrollToVCFromIndexItemBlock)(NSUInteger index);

@interface RSBaseHorSwipableViewController : RSBaseViewController

/** 负责tab页滑动的横向的collection */
@property (nonatomic , strong) UICollectionView *contentCollectionView;

/** tab页的高度,默认值参考init方法 */
@property (nonatomic, assign) CGFloat titleHeight;

/** 下方滑动条的高度,默认值参考init方法 */
@property (nonatomic, assign) CGFloat currentLineLabelHeight;

/** 选中按钮后，字体的放大比例,默认值参考init方法 */
@property (nonatomic, assign) CGFloat selectedTitleScales;

/** 未选中文字的颜色 字体,默认值参考init方法 */
@property (nonatomic, strong) UIColor *unSelectedTitleColor;
@property (nonatomic, strong) UIFont  *unSelectedFont;
/** 选中文字的颜色  字体,默认值参考init方法 */
@property (nonatomic, strong) UIColor *selectedTitleColor;
@property (nonatomic, strong) UIFont  *selectedFont;
@property (nonatomic, assign) BOOL    scrollEnabled;


/** Horizontal初始化 */
- (instancetype)initWithViewControllers:(NSArray *)controllers;
- (instancetype)initWithViewControllers:(NSArray *)controllers andTitles:(NSArray *)titles;

- (void)scrollToViewAtIndex:(NSUInteger)index;
- (void)scrollToIndexAndUpdateTitle:(NSInteger)index;

@property (nonatomic,copy) ScrollToVCFromIndexItemBlock scrollToVCFromIndexItemBlock;

@end
