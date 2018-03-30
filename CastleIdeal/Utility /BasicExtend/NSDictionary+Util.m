//
//  NSDictionary+Util.m
//  RepublicShare
//
//  Created by 姜鸥人 on 2017/9/2.
//  Copyright © 2017年 姜鸥人. All rights reserved.
//

#import "NSDictionary+Util.h"

@implementation NSDictionary (Util)

//      判断字典里key对应的是否存在
- (NSString *)dealDicEmptyWithKey:(NSString *)key {
    if ([self isKindOfClass:[NSNull class]]) {
        return @"";
    }
    if ([self valueForKey:key]) {
        return  [self valueForKey:key];
    }else{
        return @"";
    }
}

+ (NSString *)convertToJsonData:(NSDictionary *)dict {
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString;
    if (!jsonData) {
        NSLog(@"%@",error);
    }else{
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    NSRange range = {0,jsonString.length};
    //去掉字符串中的空格
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    NSRange range2 = {0,mutStr.length};
    //去掉字符串中的换行符
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    return mutStr;
}

@end
