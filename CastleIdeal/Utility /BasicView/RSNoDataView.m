//
//  RSNoDataView.m
//  RepublicShare
//
//  Created by 姜鸥人 on 2017/9/26.
//  Copyright © 2017年 姜鸥人. All rights reserved.
//

#import "RSNoDataView.h"

@implementation RSNoDataView

-(instancetype)initWithFrame:(CGRect)frame noDataImage:(NSString *)noDataImage FirstNoDataLabelStr:(NSString *)FirstNoDataLabelStr  noDataButtonTitle:(NSString *)noDataButtonTitle{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kBaseBgColor;
        //无数据的图片
        UIImageView *noDataImageView =[[UIImageView alloc] init];
        noDataImageView.image = [UIImage imageNamed:noDataImage];
        noDataImageView.userInteractionEnabled = YES;
        [self addSubview:noDataImageView];
        //无数据的文字
        UILabel *FirstNoDataLabel =[[UILabel alloc]init];
        FirstNoDataLabel.text = FirstNoDataLabelStr;
        FirstNoDataLabel.textColor = kRGB16(0x999999);
        FirstNoDataLabel.font = kFont(14);
        FirstNoDataLabel.numberOfLines = 0;
        FirstNoDataLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:FirstNoDataLabel];
        //无数据的button
        UIButton * noDataButton = [[UIButton alloc]init];
//        [noDataButton setBackgroundColor:kRGB16(0xffd634)];
        [noDataButton setTitle:noDataButtonTitle forState:UIControlStateNormal];
        [noDataButton setTitleColor:kDeepDark forState:UIControlStateNormal];
        noDataButton.titleLabel.font = kFont(12);
//        noDataButton.layer.masksToBounds = YES;
//        noDataButton.layer.cornerRadius = 6;
        [noDataButton addTarget:self action:@selector(noDataButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:noDataButton];
        if (noDataButtonTitle == nil) {
            noDataButton.hidden = YES;
        }
        [noDataImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.bottom.equalTo(FirstNoDataLabel.mas_top).offset(-kSpace10);
            make.size.mas_equalTo(CGSizeMake(120, 120));
        }];
        [FirstNoDataLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.centerY.equalTo(self.mas_centerY).with.offset(0);
        }];
        [noDataButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(FirstNoDataLabel.mas_bottom).with.offset(kSpace15);
            make.size.mas_equalTo(CGSizeMake(120, kSpace15));
        }];
    }
    return self;
}

-(void)noDataButtonClick:(UIButton*)button {
    if (self.nodataButtonBlock) {
        self.nodataButtonBlock(button.tag);
    }
}

@end
