//
//  RSBaseCollectionViewCell.m
//  RepublicShare
//
//  Created by 姜鸥人 on 2017/8/24.
//  Copyright © 2017年 姜鸥人. All rights reserved.
//

#import "RSBaseCollectionViewCell.h"

@implementation RSBaseCollectionViewCell

+ (NSString *)reuseIdentifier {
    return NSStringFromClass([self class]);
}

@end
