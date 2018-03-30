//
//  RSActionSheetView.m
//  RepublicShare
//
//  Created by 姜鸥人 on 2017/8/24.
//  Copyright © 2017年 姜鸥人. All rights reserved.
//

#import "RSActionSheetView.h"

#import "UIImageView+WebCache.h"
//#import "NSMutableAttributedString+Util.h"

static const NSInteger tagPlus = 1000;
static const NSString *kValueKey = @"value";

@interface RSActionSheetView ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>

@property (nonatomic, assign) NSInteger actionViewHeight;
@property (nonatomic, strong) UILabel   *titleLabel;
@property (nonatomic, strong) UILabel   *titleLineLabel;
@property (nonatomic, strong) UIButton  *chargeBtn;

@property (nonatomic, assign) NSInteger actionItemCount;   //item的数量
@property (nonatomic, strong) NSMutableArray *bonusArray;  //打赏的数组
@property (nonatomic, strong) NSMutableArray *giftArray;   //gift的数组
@property (nonatomic, strong) NSMutableArray *commonSheetArray;   //一般的sheet数组  比如：播放设置 性别选择
@property (nonatomic, strong) NSString *tempCommonTitle;   //上次选的title，不传默认选择第一个

@property (nonatomic, assign) NSInteger itemSelectedIndex; //当前选择的item的index
@property (nonatomic, copy) NSString    *itemSelectedValue;//当前选择的item需要传回的值，会自动放入extDic，键名为kValueKey

/** 取消按钮click */
@property (nonatomic, copy) CancelBtnClickBlock cancelBtnClickBlock;
/** 确认按钮click */
@property (nonatomic, copy) SureBtnClickBlock sureBtnClickBlock;
/** item按钮click */
@property (nonatomic, copy) ItemBtnClickBlock itemBtnClickBlock;

@end

@implementation RSActionSheetView

#pragma mark - LJActionSheetView Public Method
+ (RSActionSheetView *)sharedRSActionSheetView {
    static RSActionSheetView *ljActionSheetView = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        CGRect rect = [[UIScreen mainScreen] bounds];
        ljActionSheetView = [[RSActionSheetView alloc] initWithFrame:rect];
    });
    
    return ljActionSheetView;
}

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = kRGBACOLOR(0, 0, 0, 0.3);
        self.alpha = 1.0f;
        UITapGestureRecognizer *bgViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fingerTapped:)];
        bgViewTap.delegate = self;
        [self addGestureRecognizer:bgViewTap];
    }
    return self;
}

+ (void)showGridSheetWithHeight:(NSInteger)height
                      withTitle:(NSString *)title
                     itemTitles:(NSArray *)itemTitles
                         images:(NSArray *)images
                     withColumn:(NSInteger)colunm {
    
    [[RSActionSheetView sharedRSActionSheetView] resetSheetView:height];
    [[RSActionSheetView sharedRSActionSheetView] createShareViewWithTitle:title itemTitles:itemTitles images:images withColumn:colunm];
    [[RSActionSheetView sharedRSActionSheetView] showView];
}

+ (void)showGridSheetStyle:(RSActionSheetViewStyle)style
                withHeight:(NSInteger)height
                     title:(NSString *)title
       lastSelectedContent:(NSString *)lastSelectedContent
                itemTitles:(NSArray *)itemTitles
                    images:(NSArray *)images
                 btnTitles:(NSArray *)btnTitles
                withColumn:(NSInteger)colunm
                   withExt:(NSDictionary *)extDic
               cancelBlock:(CancelBtnClickBlock)cancelBtnClickBlock
                 sureBlock:(SureBtnClickBlock)sureBtnClickBlock
            itemClickBlock:(ItemBtnClickBlock)itemBtnClickBlock
{
    [RSActionSheetView sharedRSActionSheetView].cancelBtnClickBlock = cancelBtnClickBlock;
    [RSActionSheetView sharedRSActionSheetView].sureBtnClickBlock   = sureBtnClickBlock;
    [RSActionSheetView sharedRSActionSheetView].itemBtnClickBlock   = itemBtnClickBlock;
    [[RSActionSheetView sharedRSActionSheetView] resetSheetView:height];
    
    //根据不同类别的style，去画UI，UI相关的内容可以再进行优化，目前只是copy原有的写法
    if (style == RSActionSheetViewStyleShare ) {
        [[RSActionSheetView sharedRSActionSheetView]
         createShareViewWithTitle:title
                       itemTitles:itemTitles
                           images:images
                       withColumn:colunm];
        
    }else if(style == RSActionSheetViewStyleLogout){
        [[RSActionSheetView sharedRSActionSheetView] createLogoutViewWithTitle:title];
        
    }else if (style == RSActionSheetViewStyleCommonSex){
        [[RSActionSheetView sharedRSActionSheetView]
         createCommonSheetViewWithTitle:title
                    lastSelectedContent:lastSelectedContent
                             sheetStyle:RSActionSheetViewStyleCommonSex];
        
    }else if (style == RSActionSheetViewStyleCommonPlaySetting){
        [[RSActionSheetView sharedRSActionSheetView]
         createCommonSheetViewWithTitle:title
                    lastSelectedContent:lastSelectedContent
                             sheetStyle:RSActionSheetViewStyleCommonPlaySetting];
    }
    [[RSActionSheetView sharedRSActionSheetView] showView];
}

/**
 *  重置actionSheetView高度
 *
 *  @param actionHeight 高度
 */
-(void)resetSheetView:(NSInteger)actionHeight {
    [_actionSheetView removeFromSuperview];
    self.actionViewHeight = actionHeight;
    _actionSheetView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, actionHeight)];
    _actionSheetView.backgroundColor = kRGBACOLOR(255, 255, 255, 1);
    [self addSubview:_actionSheetView];
    
    //标题
    _titleLabel = [ControlsManager createLabelWithFrame:CGRectMake(0, 0, kScreenWidth, 64) text:nil font: kFontName(@"PingFangHK-Light", 16) textColor:kRGB16(0x333333) textAlignment:1 backgroundColor:nil];
    [_actionSheetView addSubview:_titleLabel];
    _titleLineLabel = [ControlsManager createLabelWithFrame:CGRectMake(0, 64.5, kScreenWidth, 0.5) text:nil font:kTextSize10 textColor:nil textAlignment:0 backgroundColor:kRGBACOLOR(0, 0, 0, 0.15)];
    [_actionSheetView addSubview:_titleLineLabel];
}

//点击空白处，隐藏actionSheetView
-(void)fingerTapped:(UITapGestureRecognizer *)tapGesture {
    CGPoint touchPoint = [tapGesture locationInView:self];
    if (!CGRectContainsPoint(_actionSheetView.frame, touchPoint)) {
        [self dismissView];
    }
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        return NO;
    }
    return YES;
}

//显示actionSheetView
- (void)showView {
    if (![self superview]) {
        [[UIApplication sharedApplication].keyWindow addSubview:self];
        [UIView animateWithDuration:0.3 animations:^{
            _actionSheetView.frame = CGRectMake(0, kScreenHeight-_actionViewHeight, kScreenWidth,_actionViewHeight);
            self.alpha = 1.0f;
        }];
    }
}

//隐藏actionSheetView
- (void)dismissView {
    if ([self superview]) {
        [[NSNotificationCenter defaultCenter] removeObserver:self];
        [UIView animateWithDuration:0.3 animations:^{
            _actionSheetView.frame = CGRectMake(0, kScreenHeight, kScreenWidth,_actionViewHeight);
            self.alpha = 0.0f;
        } completion:^(BOOL finished){
            [self removeFromSuperview];
        }];
    }
}

//item点击事件
- (void)itemBtnClicked:(NSInteger)tag {
    _itemSelectedIndex = tag-tagPlus;
    if (self.itemBtnClickBlock) {
        self.itemBtnClickBlock(_itemSelectedIndex);
    }
}

//取消按钮点击事件
- (void)cancelBtnClick:(UIButton *)btn {
    [self dismissView];
    if (self.cancelBtnClickBlock) {
        self.cancelBtnClickBlock();
    }
}

//确认按钮点击事件
- (void)sureBtnClick:(UIButton *)btn withExt:(NSDictionary *)dic{
    if (self.sureBtnClickBlock) {
        NSMutableDictionary *extDic = [@{kValueKey:_itemSelectedValue} mutableCopy];
        if (dic) {
            [extDic addEntriesFromDictionary:dic];
        }
        self.sureBtnClickBlock(_itemSelectedIndex,[extDic copy]);
    }
}

//确认按钮点击事件
- (void)sureBtnClick:(UIButton *)btn {
    [self dismissView];
    if (self.sureBtnClickBlock) {
        NSDictionary *extDic;
        if (_itemSelectedValue) {
            extDic=@{kValueKey:_itemSelectedValue};
        }
        self.sureBtnClickBlock(_itemSelectedIndex,extDic);
    }
}

#pragma mark - LJActionSheetViewStyleShare private Method
/**
 *  分享的自定义内容创建
 *
 *  @param title      标题
 *  @param itemTitles item标题
 *  @param images     item图片
 *  @param column     列数
 */
-(void)createShareViewWithTitle:(NSString *)title
                     itemTitles:(NSArray *)itemTitles
                         images:(NSArray *)images
                     withColumn:(NSInteger)column {
    _titleLabel.text = title;
    int buttonWidth  = kScreenWidth/column;
    int buttonheight = 70;
    
    for (int i = 0; i< itemTitles.count; i++) {
        UIButton * shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
        shareButton.tag = tagPlus+i;
        shareButton.frame =  CGRectMake(buttonWidth*(i%column),62+(buttonheight+30)*(i/column), buttonWidth, buttonheight);
        [shareButton setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        [shareButton setImageEdgeInsets:UIEdgeInsetsMake(15, 10, 0, 7)];
        [shareButton addTarget:self action:@selector(shareItemBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [_actionSheetView addSubview:shareButton];
        UILabel * name = [[UILabel alloc]initWithFrame:CGRectMake(buttonWidth*(i%column), CGRectGetMaxY(shareButton.frame)+5, buttonWidth, 15)];
        name.textColor = kRGB16(0x333333);
        name.font = kTextSize12;
        name.textAlignment = NSTextAlignmentCenter;
        name.text = itemTitles[i];
        [_actionSheetView addSubview:name];
    }
    //取消按钮
    UIButton * cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelButton.frame = CGRectMake(32*kWidthRate,62+(buttonheight+35)*(itemTitles.count/column)+10, kScreenWidth-64*kWidthRate, 38);
    [cancelButton setBackgroundImage:[UIImage imageNamed:@"erji_zb_wdtq_button"] forState:UIControlStateNormal];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    cancelButton.titleLabel.font = kTextSize14;
    [cancelButton setTitleColor:kRGB16(0xffffff) forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(cancelBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_actionSheetView addSubview:cancelButton];
}

//分享item自定义点击事件
- (void)shareItemBtnClicked:(UIButton *)btn{
    [self dismissView];
    [self itemBtnClicked:btn.tag];
}

#pragma mark - LJActionSheetViewStyleLogout private Method

/**
 *  登录退出按钮的自定义内容创建
 *
 *  @param title 标题
 */
-(void)createLogoutViewWithTitle:(NSString *)title{
    _titleLabel.text=title;
    [_titleLineLabel removeFromSuperview];
    
    UIButton *cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(19, _actionSheetView.frame.size.height-60, (kScreenWidth-38-24)/2, 40)];
    cancelBtn.backgroundColor = kRGB16(0xaeaeae);
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    cancelBtn.titleLabel.textColor = kRGB16(0xffffff);
    cancelBtn.layer.masksToBounds = YES;
    cancelBtn.layer.cornerRadius = 20;
    cancelBtn.titleLabel.font = kTextSize14;
    [cancelBtn addTarget:self action:@selector(cancelBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *sureBtn = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth/2+19, _actionSheetView.frame.size.height-60, (kScreenWidth-38-24)/2, 40)];
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    sureBtn.titleLabel.font = kTextSize14;
    sureBtn.titleLabel.textColor = kRGB16(0xffffff);
    sureBtn.backgroundColor = kRGB16(0xff4c4c);
    sureBtn.layer.masksToBounds = YES;
    sureBtn.layer.cornerRadius = 20;
    [sureBtn addTarget:self action:@selector(sureBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_actionSheetView addSubview:cancelBtn];
    [_actionSheetView addSubview:sureBtn];
}

#pragma mark - LJActionSheetViewStyleCommon private Method

/**
 *  性别和播放设置的自定义内容创建
 *
 *  @param title 标题
 */
-(void)createCommonSheetViewWithTitle:(NSString *)title lastSelectedContent:(NSString *)lastSelectedContent sheetStyle:(RSActionSheetViewStyle)sheetStyle {
    _titleLabel.text = title;
    [_titleLabel removeFromSuperview];
    [_titleLineLabel removeFromSuperview];
    if (sheetStyle == RSActionSheetViewStyleCommonPlaySetting) {
        self.commonSheetArray = [[NSMutableArray alloc] initWithObjects:@"移动流量和WIFI",@"仅WIFI", nil];
    }else if (sheetStyle == RSActionSheetViewStyleCommonSex) {
        self.commonSheetArray = [[NSMutableArray alloc] initWithObjects:@"男",@"女", nil];
    }
    self.tempCommonTitle = lastSelectedContent;
    
    UITableView *commonTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 5, kScreenWidth, 130) style:UITableViewStylePlain];
    commonTableView.delegate   = self;
    commonTableView.dataSource = self;
    [_actionSheetView addSubview:commonTableView];
    commonTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [commonTableView registerClass:[commonSheetTableViewCell class] forCellReuseIdentifier:[commonSheetTableViewCell reuseIdentifier]];
    
    UIButton *cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(19, _actionSheetView.frame.size.height-60, (kScreenWidth-38-24)/2, 38)];
    cancelBtn.backgroundColor = kRGB16(0xaeaeae);
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    cancelBtn.titleLabel.textColor = kRGB16(0xffffff);
    cancelBtn.titleLabel.font = kFontName(@"PingFangHK-Light", 14);
    cancelBtn.layer.masksToBounds = YES;
    cancelBtn.layer.cornerRadius = 20;
    [cancelBtn addTarget:self action:@selector(cancelBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *sureBtn = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth/2+12, _actionSheetView.frame.size.height-60, (kScreenWidth-38-24)/2, 38)];
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    sureBtn.titleLabel.font = kFontName(@"PingFangHK-Light", 14);
    sureBtn.titleLabel.textColor = kRGB16(0xffffff);
    sureBtn.backgroundColor = kRGB16(0xff4c4c);
    sureBtn.layer.masksToBounds = YES;
    sureBtn.layer.cornerRadius = 20;
    [sureBtn addTarget:self action:@selector(sureBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_actionSheetView addSubview:cancelBtn];
    [_actionSheetView addSubview:sureBtn];
}

#pragma mark ============= commonSheetTableViewDelegate ==============

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    commonSheetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[commonSheetTableViewCell reuseIdentifier] forIndexPath:indexPath];
    
    NSString *content = self.commonSheetArray[indexPath.row];
    [cell configText:content isSlected:[self.tempCommonTitle isEqualToString:content]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 65;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.tempCommonTitle = self.commonSheetArray[indexPath.row];
    _itemSelectedValue   = [NSString stringWithFormat:@"%ld",indexPath.row];
    [tableView reloadData];
}

@end


@interface commonSheetTableViewCell ()

@property (nonatomic, strong) UILabel     *contentLabel;
@property (nonatomic, strong) UIImageView *selectedImgView;
@property (nonatomic, strong) UIView      *lineView;

@end

@implementation commonSheetTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self generalUI];
    }
    return self;
}

- (void)generalUI {
    self.contentLabel = [UILabel new];
    self.contentLabel.font = kFontName(@"PingFangHK-Light", 16);
    self.contentLabel.textColor = kRGB16(0x666666);
    [self.contentView addSubview:self.contentLabel];
    
    self.selectedImgView = [UIImageView new];
    [self.contentView addSubview:self.selectedImgView];
    
    self.lineView = [UIView new];
    self.lineView.backgroundColor = kLineColor;
    [self.contentView addSubview:self.lineView];
}

- (void)configText:(NSString *)text isSlected:(BOOL )isSelected {
    self.contentLabel.text = text;
    if (isSelected) {
        self.contentLabel.textColor = kRGB16(0x333333);
        self.selectedImgView.image = [UIImage imageNamed:@"photo_check_selected"];
    }else  {
        self.contentLabel.textColor = kRGB16(0x666666);
        self.selectedImgView.image = nil;
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.contentView);
    }];
    [self.selectedImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentLabel);
        make.centerX.equalTo(self.contentView.mas_centerX).multipliedBy(1.75);
        make.size.mas_equalTo(CGSizeMake(21, 21));
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(0.5);
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.left.offset(19);
        make.right.equalTo(self.contentView.mas_right).offset(-19);
    }];
}

@end
