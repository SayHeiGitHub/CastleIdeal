//
//  NSArray+Safe.h
//  RepublicShare
//
//  Created by 姜鸥人 on 2018/3/27.
//  Copyright © 2017年 姜鸥人. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  解决NSArray和NSMutableArray数组越界的crash问题，当debug模式下会crash报错方便调试，release模式下会返回nil
 */

@interface NSArray (Safe)

@end

@interface NSMutableArray (Safe)

@end
