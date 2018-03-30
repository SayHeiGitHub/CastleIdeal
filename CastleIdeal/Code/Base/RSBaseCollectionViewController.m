//
//  RSBaseCollectionViewController.m
//  RepublicShare
//
//  Created by 姜鸥人 on 2017/8/24.
//  Copyright © 2017年 姜鸥人. All rights reserved.
//

#import "RSBaseCollectionViewController.h"
#import "MJDIYFooter.h"
#import "MJDIYHeader.h"
#import "UIScrollView+EmptyDataSet.h"
#import "NetStatusMonitor.h"
#import "MJAnimationHeader.h"

@interface RSBaseCollectionViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,DZNEmptyDataSetDelegate,DZNEmptyDataSetSource>

//.m参数不对子类暴露
/** 当前请求的pageIndex */
@property (nonatomic, assign) NSUInteger currentPageIndex;
/** 当没有数据，且没有正在进行网络请求时，需要显示的String，默认值请到init方法中查看 */
@property (nonatomic, copy) NSString *noDataString;
/** 当没有数据，且没有正在进行网络请求时，需要显示的图片，默认值请到init方法中查看 */
@property (nonatomic,copy)UIImage *noDataImg;
/** 请求的状态设置 */
@property (nonatomic, assign) RequestCollectionNoDataType noDataType;

/** 判断目前是否正在进行网络请求的flag */
@property (nonatomic,assign, getter=isLoading) BOOL loading;
@property(nonatomic,assign)BOOL isPull;

@end

@implementation RSBaseCollectionViewController

-(instancetype)init {
    self = [super init];
    if (self) {
        // 设置默认值
        _loading = YES;
        _currentPageIndex = 1;
        self.automaticallyAdjustsScrollViewInsets = NO;
        _collectViewFrame = CGRectMake(0, kNavBarHeight, kScreenWidth, kScreenHeight-kNavBarHeight);
        
        _noDataImg = [UIImage imageNamed:@"nodata"];
        _noDataString = @"这里空空如也哎~";
        _noDataType = RequestCollectionNoDataTypeNoData;
        _pageSize = kDefaultRequestPageSize;
    }
    return self;
}

#pragma  mark - Propertys for Lazy loading

-(UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowlayout = [[UICollectionViewFlowLayout alloc] init];
        [flowlayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        _collectionView = [[UICollectionView alloc] initWithFrame:_collectViewFrame collectionViewLayout:flowlayout];
        _collectionView.backgroundColor = kBaseBgColor;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.emptyDataSetDelegate = self;
        _collectionView.emptyDataSetSource = self;
        
    }
    return _collectionView;
}
-(NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] initWithCapacity:1];
    }
    return _dataArray;
}

#pragma mark - Life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    WEAKSELF
    [self.view addSubview:self.collectionView];
    self.collectionView.mj_header = [MJAnimationHeader headerWithRefreshingBlock:^{
        [weakSelf refreshData];
    }];
    self.collectionView.mj_footer = [MJDIYFooter footerWithRefreshingBlock:^{
        [weakSelf loadMoreData];
    }];
    [self.collectionView.mj_header beginRefreshing];                
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
    
    NSString *text =@"";
    UIFont *font = [UIFont systemFontOfSize:14.0];
    UIColor *textColor = kRGB(153);
    if (self.noDataType == RequestCollectionNoDataTypeNoData) {
        text = _noDataString;
    }else if(self.noDataType == RequestCollectionNoDataTypeServerError) {
        text = @"网络君出问题了哎～";
    }else{
        text = @"没有网络";
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
    UIImage *noDataImg;
    if (self.noDataType == RequestCollectionNoDataTypeNoData) {
        noDataImg = _noDataImg;
    }else if(self.noDataType == RequestCollectionNoDataTypeServerError) {
        noDataImg = [UIImage imageNamed:@"nodata"];
    }else{
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
- (void)setLoading:(BOOL)loading {
    if (self.isLoading == loading) {
        return;
    }
    _loading = loading;
    
    [self.collectionView reloadEmptyDataSet];
}

/** 空数据按钮 */
- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    //加载完成，并且由于网络或服务器原因导致，则可以进行重新加载
    if(!self.isLoading && self.noDataType!=RequestCollectionNoDataTypeNoData){
        NSMutableDictionary *attributes = [NSMutableDictionary new];
        [attributes setObject:[UIFont systemFontOfSize:12] forKey:NSFontAttributeName];
        [attributes setObject:kDeepDark forKey:NSForegroundColorAttributeName];
        return [[NSAttributedString alloc] initWithString:@"重新加载数据" attributes:attributes];
    }
    return nil;
    
}

/** 空数据按钮点击事件 */
- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button {
    self.loading = YES;
    [self refreshData];
}

#pragma mark - 刷新数据
-(void)refreshData {
    _currentPageIndex=1;
    self.loading=YES;
    _isPull=YES;
    [self requestData];
}
-(void)loadMoreData{
    _isPull=NO;
    _currentPageIndex++;
    [self requestData];
}

-(void)refreshDataWithMJHeadRefresh {
    [self.collectionView.mj_header beginRefreshing];
}
/**
 *  获取网络数据
 */
-(void)requestData{
    WEAKSELF
    NSString *url = self.generateURL(_currentPageIndex)[@"url"];
    NSDictionary *param = self.generateURL(_currentPageIndex)[@"param"];
    RSLog(@"%@,url:%@,param:%@",self.generateURL(1),url,param);
    [NetManager postUnsignRequestWithUrlParam:self.generateURL(_currentPageIndex) finished:^(id responseObj) {
        NSArray *newArray=[weakSelf parseToModelArray:responseObj];
        if (_isPull) {
            [weakSelf.dataArray removeAllObjects];
        }
        [weakSelf.dataArray addObjectsFromArray:newArray];
        //请求成功设置类型
        _noDataType = RequestCollectionNoDataTypeNoData;
        if (newArray.count==_pageSize) {
            [weakSelf reloadDataByResetNoMoreData];
        }else{
            [weakSelf reloadDataByNoMoreData];
        }
    } failed:^(NSString *errorMsg) {
        if ([[NetStatusMonitor monitor] isNetworkEnable]) {
            //网络原因设置类型
            _noDataType = RequestCollectionNoDataTypeInternetError;
        }else{
            //服务器原因设置类型
            _noDataType = RequestCollectionNoDataTypeServerError;
        }
        [weakSelf reloadDataByNoMoreData];
    }];
}
/**
 *  重新加载数据，并隐藏“没有更多数据”的标签
 */
-(void)reloadDataByResetNoMoreData{
    self.loading=NO;
    [_collectionView.mj_footer resetNoMoreData];
    [_collectionView.mj_header endRefreshing];
    [_collectionView reloadData];
}
/**
 *  重新加载数据，并显示“没有更多数据”的标签
 */
-(void)reloadDataByNoMoreData{
    self.loading=NO;
    [_collectionView.mj_footer endRefreshingWithNoMoreData];
    //如果数据为空，则隐藏掉mj_header的标签
    if ([_dataArray count]==0) {
        [_collectionView.mj_footer resetNoMoreData];
    }
    [_collectionView.mj_header endRefreshing];
    [_collectionView reloadData];
}
#pragma mark - UITableView DataSource and Private Method, Need to rewrite

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSAssert(false, @"Over ride in subclasses");
    return nil;
}
- (NSArray *)parseToModelArray:(id)responseObj {
    NSAssert(false, @"Over ride in subclasses");
    return nil;
}
@end
