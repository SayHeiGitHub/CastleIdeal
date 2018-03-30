//
//  RSBaseTableViewController.m
//  RepublicShare
//
//  Created by 姜鸥人 on 2017/8/24.
//  Copyright © 2017年 姜鸥人. All rights reserved.
//

#import "RSBaseTableViewController.h"

#import "MJDIYHeader.h"
#import "MJDIYFooter.h"
#import "NetStatusMonitor.h"
#import "MJAnimationHeader.h"
#import "UIScrollView+EmptyDataSet.h"

@interface RSBaseTableViewController ()<UITableViewDataSource,UITableViewDelegate,DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

//.m参数不对子类暴露
/** 当前请求的pageIndex */
@property (nonatomic, assign) NSUInteger currentPageIndex;
/** 当没有数据，且没有正在进行网络请求时，需要显示的String，默认值请到init方法中查看 */
@property (nonatomic, copy)   NSString *noDataString;
/** 当没有数据，且没有正在进行网络请求时，需要显示的图片，默认值请到init方法中查看 */
@property (nonatomic, copy)   UIImage *noDataImg;
/** 判断目前是否正在进行网络请求的flag */
@property (nonatomic, assign, getter = isLoading) BOOL loading;

@property(nonatomic, assign)  BOOL   isPull;

@property(nonatomic, strong)  UIView *loadingView;

@end

@implementation RSBaseTableViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        //设置默认值
        _isGetNewData  = YES;
        _isGetMoreData = YES;
        _loading       = YES;
        _currentPageIndex = 1;
        _tableViewFrame   = CGRectMake(0, 0, kScreenWidth, kScreenHeight-kNavBarHeight-kIphoneXBottomSpace);
        _tableViewStyle   = UITableViewStylePlain;
        _noDataString     = @"这里空空如也哎~";
        _noDataImg        = [UIImage imageNamed:@"nodata"];
        _noDataType       = RequestNoDataTypeNoData;
        _pageSize         = kDefaultRequestPageSize;
    }
    
    return self;
}

#pragma mark - Propertys for Lazy loading

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:_tableViewFrame style:_tableViewStyle];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = kBaseBgColor;
        _tableView.emptyDataSetSource=self;
        _tableView.emptyDataSetDelegate=self;
    }
    return _tableView;
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] initWithCapacity:1];
    }
    return _dataArray;
}

#pragma mark - Life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    if (_isGetNewData) {
        self.tableView.mj_header = [MJAnimationHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
        [self.tableView.mj_header beginRefreshing];
    }else {
        [self refreshData];
    }
    if (_isGetMoreData) {
        self.tableView.mj_footer=[MJDIYFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    }
    
}

#pragma mark - DZNEmptyDataSet delegate

//是否需要显示空数据
- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView {
    return YES;
}

//空数据的标题
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    if (self.loading) {
        return nil;
    }
    NSMutableDictionary *attributes = [NSMutableDictionary new];
    NSString *text = @"";
    UIFont *font = [UIFont systemFontOfSize:12.0];
    UIColor *textColor = kRGB(153);
    if (self.noDataType == RequestNoDataTypeNoData) {
        text = _noDataString;
    }else if(self.noDataType == RequestNoDataTypeServerError) {
        text = @"加载失败";
    }else {
        text = @"网络不见了，快检查一下吧";
    }
    [attributes setObject:font forKey:NSFontAttributeName];
    [attributes setObject:textColor forKey:NSForegroundColorAttributeName];
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

//空数据的标题
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    if (_loading) {
        if (self.isPull) {
            return [UIImage imageNamed:@"tableViewloading"];
        }
        return nil;
    }
//    if (_loading) {
//        return [UIImage imageNamed:@"tableViewloading"];
//    }
    UIImage *noDataImg;
    if (self.noDataType == RequestNoDataTypeNoData) {
        noDataImg = _noDataImg;
    }else if(self.noDataType == RequestNoDataTypeServerError) {
        noDataImg = [UIImage imageNamed:@"nodata"];
    }else {
        noDataImg = [UIImage imageNamed:@"nowifi"];
    }
    return _noDataImg;
}

//是否有动画效果
- (BOOL)emptyDataSetShouldAnimateImageView:(UIScrollView *)scrollView {
    return self.isLoading;
}

//动画效果设定
- (CAAnimation *)imageAnimationForEmptyDataSet:(UIScrollView *)scrollView {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    animation.toValue = [NSValue valueWithCATransform3D: CATransform3DMakeRotation(M_PI_2, 0.0, 0.0, 1.0) ];
    animation.duration = 0.25;
    animation.cumulative = YES;
    animation.repeatCount = MAXFLOAT;
    
    return animation;
}

/**
 *  更新是否正在加载的状态，并且重新reload emptydataset
 *
 *  @param loading 是否loading
 */
- (void)setLoading:(BOOL)loading
{
    if (self.isLoading == loading) {
        return;
    }
    _loading = loading;
    [self.tableView reloadEmptyDataSet];
}

/** 空数据按钮 */
- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state
{
    //加载完成，并且由于网络或服务器原因导致，则可以进行重新加载
    //    if(!self.isLoading && self.noDataType!=RequestNoDataTypeNoData){
    if(!self.isLoading ){
        NSMutableDictionary *attributes = [NSMutableDictionary new];
        [attributes setObject:[UIFont systemFontOfSize:12] forKey:NSFontAttributeName];
        [attributes setObject:kDeepDark forKey:NSForegroundColorAttributeName];
        return [[NSAttributedString alloc] initWithString:@"重新加载数据" attributes:attributes];
    }
    return nil;
    
}

/** 空数据按钮点击事件 */
- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button
{
    self.loading = YES;
    [self refreshData];
}

#pragma mark - 刷新数据

/**
 *  初始或上拉刷新加载数据
 */
-(void)refreshData {
    _currentPageIndex = 1;
    self.loading      = YES;
    _isPull           = YES;
    [self requestData];
}

/**
 *  加载更多数据
 */
-(void)loadMoreData{
    _isPull = NO;
    _currentPageIndex++;
    [self requestData];
}

- (void)refreshDataWithMJHeadRefresh {
    [self.tableView.mj_header beginRefreshing];
}

/**
 *  获取网络数据
 */
-(void)requestData{
    [[UIApplication sharedApplication].keyWindow addSubview:self.loadingView];
    if (self.generateURL) {
//        RSLog(@"打印接口：%@", self.generateURL(_currentPageIndex));
//        NSString *url = self.generateURL(_currentPageIndex)[@"url"];
//        NSDictionary *param = self.generateURL(_currentPageIndex)[@"param"];
        [NetManager postUnsignRequestWithUrlParam:self.generateURL(_currentPageIndex) finished:^(id responseObj) {
            NSArray *newArray = [self parseToModelArray:responseObj];
            if (_isPull) {
                [self.dataArray removeAllObjects];
            }
            [self.dataArray addObjectsFromArray:newArray];
            //请求成功设置类型
            _noDataType=RequestNoDataTypeNoData;
            if (newArray.count == _pageSize) {
                [self reloadDataByResetNoMoreData];
            }else{
                [self reloadDataByNoMoreData];
            }
        } failed:^(NSString *errorMsg) {
            if ([[NetStatusMonitor monitor] isNetworkEnable]) {
                //网络原因设置类型
                _noDataType = RequestNoDataTypeInternetError;
            }else{
                //服务器原因设置类型
                _noDataType = RequestNoDataTypeServerError;
            }
            [self reloadDataByNoMoreData];
        }];
    }
}


/**
 *  重新加载数据，并隐藏“没有更多数据”的标签
 */
-(void)reloadDataByResetNoMoreData{
    self.loading = NO;
    [_tableView.mj_footer resetNoMoreData];
    [_tableView.mj_header endRefreshing];
    [_tableView reloadData];
}

/**
 *  重新加载数据，并显示“没有更多数据”的标签
 */
-(void)reloadDataByNoMoreData{
    self.loading = NO;
    [_tableView.mj_footer endRefreshingWithNoMoreData];
    //如果数据为空，则隐藏掉mj_header的标签
    if ([_dataArray count] == 0) {
        [_tableView.mj_footer resetNoMoreData];
    }
    [_tableView.mj_header endRefreshing];
    [_tableView reloadData];
}

#pragma mark - UITableView DataSource and Private Method, Need to rewrite

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSAssert(false, @"Over ride in subclasses");
    return nil;
}

- (NSArray *)parseToModelArray:(id)responseObj {
    NSAssert(false, @"Over ride in subclasses");
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return kMinFloat;
}

@end
