//
//  SizeMacro.h
//  RepublicShare
//
//  Created by 姜鸥人 on 2018/3/27.
//  Copyright © 2017年 姜鸥人. All rights reserved.
//

#ifndef SizeMacro_h
#define SizeMacro_h

#define kScreenWidth     ([UIScreen mainScreen].bounds.size.width)//屏幕宽
#define kScreenHeight    ([UIScreen mainScreen].bounds.size.height)//屏幕高
#define kScreenRect       ([UIScreen mainScreen].bounds)

#define kWidthRate  (kScreenWidth / 375.0f)
#define kHeightRate (kScreenHeight / 667.0f)

//  机型相关
#define IS_IPAD     [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad
#define IS_IPHONE   [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone
#define IS_IPHONE_4 (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double )480) < DBL_EPSILON )
#define IS_IPHONE_5 (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double )568) < DBL_EPSILON )
#define IS_IPHONE_6 (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double )667) < DBL_EPSILON )
#define IS_IPHONE_6_PLUS (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double )736) < DBL_EPSILON )
#define IS_IPHONE_X (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double )812) < DBL_EPSILON )

//  高度相关
#define kStatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height //状态栏高度
#define kNavBarHeight (kStatusBarHeight + 44) //导航栏高
#define kTabBarHeight (kStatusBarHeight > 20 ? 83 : 49) //Tabbar高
#define kIphoneXBottomSpace (kStatusBarHeight > 20 ? 35 : 0) //没有tabbar时 底部不显示内容高度

#define kSpace10    10.0f
#define kSpace15    15.0f
#define kSpace20    20.0f
#define kDefaultTableHeight 44.0f

#define kHomeNavCollectionCellWidth (kScreenWidth-60-40)/5
#define kHomeCycleScrollHeight 180.0f
#define KHomeCycleHeight 160.0f
#define kHomeSectionTitleCellHeight 35.0f
#define kHomePageContentCollectionSize CGSizeMake((kScreenWidth-30)/2, 166*kHeightRate)

#define kSearchIdolContentImgSizeWidth       (kScreenWidth-40-18*3)/4
#define kSearchVedioContentCollectionSize CGSizeMake((kScreenWidth-30)/2, 115*kHeightRate+15+30*kHeightRate)
#define kSearchSectionTitleCellHeight 45.0f

#define kFindBottomSpace         14.0f //下边距
#define kFindHeadImgWidth        50.0f //头像宽度  / 播放按钮
#define kFindVedioImgHeight      200*kHeightRate //视屏图片高度
#define kFindCommentButtonWidth  50.0f
#define kFindCommentButtonHeight 20.0f

#define kPlayPlayControlHeight   kScreenWidth*9/16
#define kPlayHeadImgWidth        50.0f //播放head的头像宽度
#define kPlayVedioImgSize        CGSizeMake(160, 90)
#define kPlayZanButtonWidth      kScreenWidth/3-0.5
#define kPlayZanButtonHeight     20.0f
#define kPlayVedioHeadImgWidth   30.0f //视频评论的头像宽度
#define kPlayCommentVedioImgSize CGSizeMake(285*kWidthRate, 160*kHeightRate)
#define kPlayCommentZanBtnSize   CGSizeMake(20.0f, 35.0f)
#define kPlayVedioPlayBtnWidth   40.0f //视频评论播放按钮

#define kAnchorHeadViewHeight    255.0f
#define kAnchorHeadImgWidth      74.0f
#define kAnchorSpaceBottom       8.0f
#define kAnchorContentVideoSize  CGSizeMake((kScreenWidth-5*kSpace10)/2,  107*kHeightRate+35)

#define kMinFloat 0.01
#define kMaxFloat 9999.99


#endif /* SizeMacro_h */
