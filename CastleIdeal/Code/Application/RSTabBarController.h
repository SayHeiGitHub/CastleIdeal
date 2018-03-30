//
//  RSTabBarController.h
//  RepublicShare
//
//  Created by 姜鸥人 on 2017/8/23.
//  Copyright © 2017年 姜鸥人. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,selectedTabbarItem) {
    selectedTabbarItemHome,
    selectedTabbarItemMessage,
    selectedTabbarItemFind,
    selectedTabbarItemMine,
};

@interface RSTabBarController : UITabBarController

@property (nonatomic, assign) selectedTabbarItem selectedTabbarItem;

//- (void)asyncPushOptions;
//- (void)asyncConversationFromDB;

@end
