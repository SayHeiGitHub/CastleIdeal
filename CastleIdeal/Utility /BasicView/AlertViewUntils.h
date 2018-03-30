//
//  AlertViewUntils.h
//  RepublicShare
//
//  Created by 姜鸥人 on 2017/11/15.
//  Copyright © 2017年 姜鸥人. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <MMPopupView/MMPopupItem.h>

@interface AlertViewUntils : NSObject

+ (void)showWithTitle:(NSString *)title detail:(NSString *)detail itemHandler:(MMPopupItemHandler)itemHandler;

+ (void)showNoTouchHideWithTitle:(NSString *)title detail:(NSString *)detail itemHandler:(MMPopupItemHandler)itemHandler;

@end
