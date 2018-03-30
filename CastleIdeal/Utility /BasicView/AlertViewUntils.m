//
//  AlertViewUntils.m
//  RepublicShare
//
//  Created by 姜鸥人 on 2017/11/15.
//  Copyright © 2017年 姜鸥人. All rights reserved.
//

#import "AlertViewUntils.h"

#import <MMPopupView/MMAlertView.h>

@implementation AlertViewUntils

+ (void)showWithTitle:(NSString *)title detail:(NSString *)detail itemHandler:(MMPopupItemHandler)itemHandler {
    MMPopupItem *cancelItem = MMItemMake(@"取消", MMItemTypeNormal, itemHandler);
    MMPopupItem *doneItem = MMItemMake(@"确定", MMItemTypeNormal, itemHandler);
    MMAlertView *alertView = [[MMAlertView alloc] initWithTitle:title
                                                         detail:detail
                                                          items:@[cancelItem, doneItem]];
    [MMPopupWindow sharedWindow].touchWildToHide = YES;
    [alertView show];
}

+ (void)showNoTouchHideWithTitle:(NSString *)title detail:(NSString *)detail itemHandler:(MMPopupItemHandler)itemHandler {
    MMPopupItem *doneItem = MMItemMake(@"知道了", MMItemTypeNormal, itemHandler);
    MMAlertView *alertView = [[MMAlertView alloc] initWithTitle:title
                                                         detail:detail
                                                          items:@[doneItem]];
    [MMPopupWindow sharedWindow].touchWildToHide = NO;
    [alertView show];
}

@end
