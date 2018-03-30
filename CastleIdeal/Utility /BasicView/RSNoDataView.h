//
//  RSNoDataView.h
//  RepublicShare
//
//  Created by 姜鸥人 on 2017/9/26.
//  Copyright © 2017年 姜鸥人. All rights reserved.
//

#import "MMView.h"

typedef void(^noDataButtonBlock)(NSInteger index);

@interface RSNoDataView : MMView

- (instancetype)initWithFrame:(CGRect)frame noDataImage:(NSString *)noDataImage FirstNoDataLabelStr:(NSString*)FirstNoDataLabelStr noDataButtonTitle:(NSString *)noDataButtonTitle;
@property (nonatomic,strong)noDataButtonBlock nodataButtonBlock;

@end
