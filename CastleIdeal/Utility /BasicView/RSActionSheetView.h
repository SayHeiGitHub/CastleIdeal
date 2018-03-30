//
//  RSActionSheetView.h
//  RepublicShare
//
//  Created by 姜鸥人 on 2017/8/24.
//  Copyright © 2017年 姜鸥人. All rights reserved.
//

#import "MMView.h"

#import "RSBaseTableViewCell.h"

/**  ActionSheet点击取消按钮、充值等非确定按钮的Block  */
typedef void(^CancelBtnClickBlock)(void);

/**
 *  ActionSheet点击确定按钮的Block
 *  @param index  点击确定时选择的index
 *  @param extDic 点击确定时需要传回的值的拓展
 */
typedef void(^SureBtnClickBlock)(NSInteger index,NSDictionary *extDic);

/**
 *  点击某个item时的触发时间，如果需要点击确认键
 *  @param index 点击item的index
 */
typedef void(^ItemBtnClickBlock)(NSInteger index);

/** ActionSheet类型 */
typedef NS_ENUM(NSInteger, RSActionSheetViewStyle){
    /** 分享 */
    RSActionSheetViewStyleShare = 0,
    /** 退出登录 */
    RSActionSheetViewStyleLogout = 1,
    RSActionSheetViewStyleCommonSex = 2,
    RSActionSheetViewStyleCommonPlaySetting = 3,
};


/**
 *  用于所有从下方弹出的ActionSheetView
 */
@interface RSActionSheetView : MMView

/** ActionSheetView的主UI */
@property (nonatomic, strong) UIView *actionSheetView;

/**
 *  单例
 *
 *  @return 单例
 */
+ (RSActionSheetView *)sharedRSActionSheetView;

/**
 *  显示通用网格状ActionSheet，无回调，只用于显示
 *
 *  @param height     高度
 *  @param title      标题
 *  @param itemTitles item名称
 *  @param images     item图片
 *  @param colunm     列数
 */
+ (void)showGridSheetWithHeight:(NSInteger)height
                      withTitle:(NSString *)title
                     itemTitles:(NSArray *)itemTitles
                         images:(NSArray *)images
                     withColumn:(NSInteger)colunm;

/**

/**
 *  显示通用网格状ActionSheet，需要添加各种按键回调，可为空
 *
 *  @param height     高度
 *  @param title      标题
 *  @param lastSelectedContent  记录上次选择的内容 （播放设置/性别选择 用到）
 *  @param itemTitles item名称
 *  @param images     item图片
 *  @param btnTitles  下方btn名称，如为nil，则为"确认"和"取消"
 *  @param colunm     列数
 *  @param extDic     拓展dic
 *  @param cancelBtnClickBlock 取消按钮block
 *  @param sureBtnClickBlock   确认按钮block
 *  @param itemBtnClickBlock   item按钮block
 */
+ (void)showGridSheetStyle:(RSActionSheetViewStyle)style
                withHeight:(NSInteger)height
                     title:(NSString *)title
       lastSelectedContent:(NSString *)lastSelectedContent
                itemTitles:(NSArray *)itemTitles
                    images:(NSArray *)images
                 btnTitles:(NSArray *)btnTitles
                withColumn:(NSInteger)colunm
                   withExt:(NSDictionary *)extDic
               cancelBlock:(CancelBtnClickBlock)cancelBtnClickBlock
                 sureBlock:(SureBtnClickBlock)sureBtnClickBlock
            itemClickBlock:(ItemBtnClickBlock)itemBtnClickBlock;

/**
 *  提供手动隐藏ActionSheet的方法
 */
- (void)dismissView;

@end


@interface commonSheetTableViewCell : RSBaseTableViewCell

- (void)configText:(NSString *)text isSlected:(BOOL )isSelected;

@end
