//
//  RSBaseTableViewCell.h
//  RepublicShare
//
//  Created by 姜鸥人 on 2017/8/24.
//  Copyright © 2017年 姜鸥人. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RSBaseTableViewCell : UITableViewCell

+ (NSString *)reuseIdentifier;

+ (CGFloat)staticHeight;

@end
