//
//  NSArray+Util.m
//  RepublicShare
//
//  Created by 姜鸥人 on 2018/3/27.
//  Copyright © 2017年 姜鸥人. All rights reserved.
//

#import "NSArray+Util.h"

@implementation NSArray (Util)

- (NSArray*)shuffleArray {
    
    NSMutableArray *temp = [[NSMutableArray alloc] initWithArray:self];
    
    for(NSUInteger i = [self count]; i > 1; i--) {
        NSUInteger j = arc4random_uniform(i);
        [temp exchangeObjectAtIndex:i-1 withObjectAtIndex:j];
    }
    
    return [NSArray arrayWithArray:temp];
}

// 对数组进行排序 升序
- (NSArray *)arraySortASC {
    if (self.count > 0) {
        NSArray *result = [self sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            return [obj1 compare:obj2]; //升序
        }];
        return result;
    }
    return self;
}

//对数组进行排序 降序
- (NSArray *)arraySortDESC {
    if (self.count > 0) {
        NSArray *result = [self sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            return [obj2 compare:obj1]; //降序
        }];
        return result;
    }
    return self;
}

// 数组反转
- (NSArray *)arrayReversal {
    if (self.count > 0) {
        return [[self reverseObjectEnumerator] allObjects];
    }
    return self;
}
@end
