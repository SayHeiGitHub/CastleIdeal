//
//  RSBaseCollectionViewController.h
//  RepublicShare
//
//  Created by 姜鸥人 on 2017/8/24.
//  Copyright © 2017年 姜鸥人. All rights reserved.
//

#import "RSBaseViewController.h"

typedef NS_ENUM(NSInteger , RequestCollectionNoDataType) {
    /** 本身就是没有数据 */
    RequestCollectionNoDataTypeNoData =0,
    /** 服务器错误导致没有数据 */
    RequestCollectionNoDataTypeServerError =1,
    /** 网络原因导致没有数据 */
    RequestCollectionNoDataTypeInternetError =2,
};

@interface RSBaseCollectionViewController : RSBaseViewController

@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) NSMutableArray *dataArray;
/** collectionView的flowLayout，默认值请到init方法中查看，可在子类init的时候进行设置 */
//@property (nonatomic,assign) UICollectionViewFlowLayout *flowLayout;
/** collectionView的frame，默认值请到init方法中查看，可在子类init的时候进行设置 */
@property (nonatomic,assign) CGRect collectViewFrame;
/** 一次请求的pageSize，默认值请到init方法中查看，可在子类init的时候进行设置 */
@property (nonatomic, assign) NSUInteger pageSize;

/** 根据page获取请求URL的block，可在子类init的时候进行设置，且必须设置 */
@property (nonatomic,copy) NSDictionary * (^generateURL)(NSUInteger page);
/**
 *  对网络请求获取的json数据，解析成对应的array，需要rewrite
 */
-(NSArray *)parseToModelArray:(id)responseObj;

/**
 *  对子类暴露的refreshData，用于子类调用，做规定动作以外的其他手动刷新
 */
-(void)refreshData;
-(void)refreshDataWithMJHeadRefresh;


@end
