//
//  RSBaseTableViewController.h
//  RepublicShare
//
//  Created by 姜鸥人 on 2017/8/24.
//  Copyright © 2017年 姜鸥人. All rights reserved.
//

#import "RSBaseViewController.h"

typedef NS_ENUM(NSInteger , RequestNoDataType) {
    /** 本身就是没有数据 */
    RequestNoDataTypeNoData =0,
    /** 服务器错误导致没有数据 */
    RequestNoDataTypeServerError =1,
    /** 网络原因导致没有数据 */
    RequestNoDataTypeInternetError =2,
};

@interface RSBaseTableViewController : RSBaseViewController

@property(nonatomic,assign) BOOL isGetNewData; //是否要刷新
@property(nonatomic,assign) BOOL isGetMoreData; //是否要加载
/** 显示数据的tableView控件 */
@property (nonatomic, strong) UITableView *tableView;

/** 数据源 */
@property (nonatomic, strong) NSMutableArray *dataArray;

/** tableview的style，默认值请到init方法中查看，可在子类init的时候进行设置 */
@property (nonatomic, assign) UITableViewStyle tableViewStyle;

/** tableview的frame，默认值请到init方法中查看，可在子类init的时候进行设置 */
@property(nonatomic, assign)CGRect tableViewFrame;

/** 一次请求的pageSize，默认值请到init方法中查看，可在子类init的时候进行设置 */
@property (nonatomic, assign) NSUInteger pageSize;

/** 根据page获取请求URL的block，可在子类init的时候进行设置，且必须设置 */
@property (nonatomic, copy) NSDictionary * (^generateURL)(NSUInteger page);

/** 请求的状态设置 */
@property (nonatomic, assign) RequestNoDataType noDataType;

/**
 *  对网络请求获取的json数据，解析成对应的array，需要rewrite
 */
- (NSArray *)parseToModelArray:(id)responseObj;

/**
 *  对子类暴露的refreshData，用于子类调用，做规定动作以外的其他手动刷新
 */
- (void)refreshData;
- (void)refreshDataWithMJHeadRefresh;
- (void)requestData;

/**
 *  其他可拓展字段内容...
 */
@end
