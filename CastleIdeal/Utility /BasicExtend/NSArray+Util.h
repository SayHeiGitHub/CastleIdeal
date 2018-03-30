//
//  NSArray+Util.h
//  RepublicShare
//
//  Created by 姜鸥人 on 2018/3/27.
//  Copyright © 2017年 姜鸥人. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Util)

/**
 *  随机化序列
 *  @return return value description
 */
- (NSArray*)shuffleArray;
/**
 *  数组 反转
 */
- (NSArray *)arrayReversal;
/**
 *  升序 排列
 */
- (NSArray *)arraySortASC;
/**
 *  降序 排列
 */
- (NSArray *)arraySortDESC;
@end
