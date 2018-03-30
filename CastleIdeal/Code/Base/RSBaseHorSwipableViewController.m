//
//  RSBaseHorSwippleViewController.m
//  RepublicShare
//
//  Created by 姜鸥人 on 2017/10/24.
//  Copyright © 2017年 姜鸥人. All rights reserved.
//

#import "RSBaseHorSwipableViewController.h"

@interface RSBaseHorSwipableViewController ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>

/** 各tab页VC的Arrary */
@property (nonatomic, strong) NSArray *controllers;
/** 当前index */
@property (nonatomic, assign) NSInteger currentIndex;

/** 各tab页标题的Arrary */
@property (nonatomic, strong) NSArray *titles;
/** 各tab页Button的Arrary */
@property (nonatomic, strong) NSMutableArray *titleButtons;
/** tab页View */
@property (nonatomic,strong) UIScrollView *titleBarView;
/** 下方滑动的条 */
@property (nonatomic,strong) UILabel *currentLineLabel;

@end

static NSString *kHorizonalCellID = @"HorizonalCell";
@implementation RSBaseHorSwipableViewController

- (instancetype)initWithViewControllers:(NSArray *)controllers {
    self = [super init];
    if (self) {
        _controllers = [NSArray arrayWithArray:controllers];
        //注意，需要添加childVC后，才能加载view
        for (UIViewController *controller in controllers) {
            [self addChildViewController:controller];
        }
        _titleHeight = 0;
        _titles      = [NSMutableArray new];
        _selectedTitleScales    = 1.15;
        _currentLineLabelHeight = 1;
        _unSelectedTitleColor   = kRGB16(0xFFD634);
        _selectedTitleColor     = kRGB16(0xFFD634);
        _selectedFont           = kTextSize14;
        _unSelectedFont         = kTextSize14_B;
    }
    return self;
}

- (instancetype)initWithViewControllers:(NSArray *)controllers andTitles:(NSArray *)titles {
    self = [super init];
    if (self) {
        _controllers = [NSArray arrayWithArray:controllers];
        //注意，需要添加childVC后，才能加载view
        for (UIViewController *controller in controllers) {
            [self addChildViewController:controller];
        }
        if (titles.count>0) {
            _titles = [NSArray arrayWithArray:titles];
        }
        _titleHeight            = 38;
        _selectedTitleScales    = 1.15;
        _currentLineLabelHeight = 4.5;
        _unSelectedTitleColor   = kRGB16(0xFFD634);
        _selectedTitleColor     = kRGB16(0xFFD634);
        _selectedFont           = kTextSize14;
        _unSelectedFont         = kTextSize14_B;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.contentCollectionView];
    [self.view addSubview:self.titleBarView];
}

#pragma mark - Propertys for Lazy loading

-(UICollectionView *)contentCollectionView{
    if (!_contentCollectionView) {
        UICollectionViewFlowLayout *contentFlowLayout = [[UICollectionViewFlowLayout alloc] init];
        contentFlowLayout.itemSize = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height);
        contentFlowLayout.minimumLineSpacing = 0;
        contentFlowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _contentCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0,  self.titleHeight, self.view.bounds.size.width,self.view.bounds.size.height-self.titleHeight) collectionViewLayout:contentFlowLayout];
        _contentCollectionView.backgroundColor = kBaseBgColor;
        _contentCollectionView.showsHorizontalScrollIndicator = NO;
        _contentCollectionView.dataSource = self;
        _contentCollectionView.delegate = self;
        _contentCollectionView.pagingEnabled = YES;
        //        self.edgesForExtendedLayout = UIRectEdgeNone;
        //        _contentCollectionView.bounces = NO;
        [_contentCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kHorizonalCellID];
        
    }
    return _contentCollectionView;
}

- (UIScrollView *)titleBarView {
    if (!_titleBarView) {
        _titleBarView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, self.titleHeight)];
        _titleBarView.backgroundColor = [UIColor whiteColor];
        
        if (_titleHeight != 0) {
            [self createButtonForTitleBarView];
        }
    }
    return _titleBarView;
}

-(void)createButtonForTitleBarView{
    _currentIndex = 0;
    _titleButtons = [[NSMutableArray alloc] initWithCapacity: [_titles count]];
    NSInteger buttonNum = 1;
    if (_titles.count > 0) {
        buttonNum = _titles.count;
    }
    CGFloat buttonWidth  = _titleBarView.frame.size.width / buttonNum;
    CGFloat buttonHeight = _titleBarView.frame.size.height - _currentLineLabelHeight;
    CGFloat labelWidth   = _titleBarView.frame.size.width / buttonNum;
    
    _currentLineLabel = [[UILabel alloc] initWithFrame:CGRectMake(buttonWidth*_currentIndex+buttonWidth/2-labelWidth/2, _titleBarView.frame.size.height-_currentLineLabelHeight, labelWidth, _currentLineLabelHeight)];
    _currentLineLabel.backgroundColor = kRGBCOLOR(255,214,52);
    [_titleBarView addSubview:_currentLineLabel];
    
    if (_titles.count > 0) {
        [_titles enumerateObjectsUsingBlock:^(NSString *title, NSUInteger idx, BOOL *stop) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.backgroundColor = [UIColor whiteColor];
            button.titleLabel.font = _unSelectedFont;
            [button setTitleColor:_unSelectedTitleColor forState:UIControlStateNormal];
            [button setTitle:title forState:UIControlStateNormal];
            
            button.frame = CGRectMake(buttonWidth * idx, 0, buttonWidth, buttonHeight);
            button.tag = idx;
            [button addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            
            [_titleButtons addObject:button];
            [_titleBarView addSubview:button];
            [_titleBarView sendSubviewToBack:button];
        }];
        
        _titleBarView.contentSize = CGSizeMake(_titleBarView.frame.size.width, _titleBarView.frame.size.height);
        _titleBarView.showsHorizontalScrollIndicator = NO;
        UIButton *firstTitle = _titleButtons[_currentIndex];
        [firstTitle setTitleColor:_selectedTitleColor forState:UIControlStateNormal];
        firstTitle.titleLabel.font = _unSelectedFont;
        firstTitle.transform = CGAffineTransformMakeScale(_selectedTitleScales, _selectedTitleScales);
    }
    UILabel *lineLabel = [UILabel new];
    lineLabel.backgroundColor = kRGB16(0xE6E6E6);
    lineLabel.frame    = CGRectMake(0, _titleBarView.frame.size.height-0.5, _titleBarView.frame.size.width, 0.5);
    [_titleBarView addSubview:lineLabel];
}

#pragma mark ============= CollectionDelagate ==============

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.controllers.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [self.contentCollectionView dequeueReusableCellWithReuseIdentifier:kHorizonalCellID forIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor whiteColor];
    UIViewController *controller = _controllers[indexPath.row];
    controller.view.frame = cell.contentView.bounds;
    //由于已经addChildVC，因此可做加载
    [cell.contentView addSubview:controller.view];
    return cell;
}

#pragma mark - <UIScrollViewDelegate>

/**
 *  滑动完成后，触发的title的变化
 *
 *  param  scrollView
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat horizonalOffset = self.contentCollectionView.contentOffset.x;
    CGFloat screenWidth = self.contentCollectionView.frame.size.width;
    NSUInteger focusIndex = (horizonalOffset + screenWidth / 2) / screenWidth;
    
    //滑动比例，可以做一些渐变
    //    CGFloat offsetRatio = (NSUInteger)horizonalOffset % (NSUInteger)screenWidth / screenWidth;
    
    _currentIndex = focusIndex;
    
    [self scrollToIndexAndUpdateTitle:_currentIndex];
    
    if (self.scrollToVCFromIndexItemBlock) {
        self.scrollToVCFromIndexItemBlock(focusIndex);
    }
}

/**
 *  用于在滑动过程中，如果需要进行页面的调整
 *
 *  param scrollView
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
}



#pragma mark -

/**
 *  上方tab按钮点击事件
 *
 *  param button
 */
- (void)titleBtnClick:(UIButton *)button{
    if (_currentIndex != button.tag) {
        [self scrollToIndexAndUpdateTitle:button.tag];
    }
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}

-(void)scrollToIndexAndUpdateTitle:(NSInteger)index{
    _currentIndex = index;
    if (_titles.count > 0) {
        CGRect lineLabelFrame   = _currentLineLabel.frame;
        lineLabelFrame.origin.x = _currentIndex *kScreenWidth/[_titles count]+(kScreenWidth/[_titles count]/2-kScreenWidth/[_titles count]/2);
        _currentLineLabel.frame = lineLabelFrame;
        [_titleButtons enumerateObjectsUsingBlock:^(UIButton *button, NSUInteger idx, BOOL * _Nonnull stop) {
            if (button.tag != _currentIndex) {
                [button setTitleColor:_unSelectedTitleColor forState:UIControlStateNormal];
                button.titleLabel.font =  _unSelectedFont;
                button.transform       = CGAffineTransformIdentity;
            } else {
                [button setTitleColor:_selectedTitleColor forState:UIControlStateNormal];
                button.titleLabel.font =  _selectedFont;
                button.transform       = CGAffineTransformMakeScale(_selectedTitleScales, _selectedTitleScales);
            }
        }];
    }
    [self scrollToViewAtIndex:_currentIndex];
}

/**
 *  tab页滑动到第几个tab
 *
 *  @param index tab的index
 */
- (void)scrollToViewAtIndex:(NSUInteger)index
{
//    [self.contentCollectionView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]
//                          atScrollPosition:UITableViewScrollPositionNone
//                                  animated:YES];
    [self.contentCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
}

- (void)setTitleHeight:(CGFloat)titleHeight {
    _titleHeight = titleHeight;
}

- (void)setCurrentLineLabelHeight:(CGFloat)currentLineLabelHeight {
    _currentLineLabelHeight = currentLineLabelHeight;
    //    CGRect frame            = _currentLineLabel.frame;
    //    frame.size.height       = currentLineLabelHeight;
    //    _currentLineLabel.frame = frame;
    //    [self createButtonForTitleBarView];
}

@end
