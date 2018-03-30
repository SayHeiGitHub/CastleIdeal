//
//  RSTabBarController.m
//  RepublicShare
//
//  Created by 姜鸥人 on 2017/8/23.
//  Copyright © 2017年 姜鸥人. All rights reserved.
//

#import "RSTabBarController.h"

//#import "AlertViewUntils.h"
//#import "FindViewController.h"
//#import "MineViewController.h"
//#import "MMNavigationController.h"
//#import "HomeTableViewController.h"
//#import "ShortLiveViewController.h"
//#import "HomeSwipableViewController.h"
//#import "MessageSwipleViewController.h"

@interface RSTabBarController ()
//<UITabBarControllerDelegate, EMClientDelegate, EMChatManagerDelegate>

//@property (nonatomic, strong) HomeSwipableViewController  *homeController;
//@property (nonatomic, strong) MessageSwipleViewController *messageController;
//@property (nonatomic, strong) FindViewController *findController;
//@property (nonatomic, strong) MineViewController *mineController;
//@property (nonatomic, strong) HomeTableViewController *homeTableController;

@end

@implementation RSTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.delegate = self;
    [self createControllers];
    [self registerNotifications];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setupUnreadMessageCount) name:KHuanXinUnreadMessageCount object:nil];
}

- (void)createControllers {
//    self.homeController = [HomeSwipableViewController new];
////    [self addChildController:self.homeController title:@"首页" imageName:@"tabbar_home_normal" selectedImageName:@"tabbar_home_selected"];
//    self.homeTableController = [HomeTableViewController new];
//    [self addChildController:self.homeTableController title:@"首页" imageName:@"tabbar_home_normal" selectedImageName:@"tabbar_home_selected"];
//
//    self.messageController = [MessageSwipleViewController new];
//    [self addChildController:self.messageController title:@"消息" imageName:@"tabbar_message_normal" selectedImageName:@"tabbar_message_selected"];
//
//    self.findController = [FindViewController new];
//    [self addChildController:self.findController title:@"发现" imageName:@"tabbar_find_normal" selectedImageName:@"tabbar_find_selected"];
//
//    self.mineController = [MineViewController new];
//    [self addChildController:self.mineController title:@"我的" imageName:@"tabbar_mine_normal" selectedImageName:@"tabbar_mine_selected" ];
//
//    [[UITabBar appearance] setBackgroundImage:[self imageWithColor:[UIColor whiteColor]]];
//    [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
//    [self setCustomTabbar];
}

- (void)setCustomTabbar {
//    RSTabBar *tabbar = [[RSTabBar alloc] init];
//    [self setValue:tabbar forKeyPath:@"tabBar"];
//    [tabbar.centerBtn addTarget:self action:@selector(centerBtnClick:) forControlEvents:UIControlEventTouchUpInside];
}

//- (void)centerBtnClick:(UIButton *)sender {
//    ShortLiveViewController *shortLiveVC = [[ShortLiveViewController alloc] init];
//    MMNavigationController *nav = [[MMNavigationController alloc] initWithRootViewController:shortLiveVC];
//    shortLiveVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
//    shortLiveVC.modalPresentationStyle = UIModalPresentationCustom;
//    [self presentViewController:nav animated:YES completion:nil];
//}

- (void)addChildController:(UIViewController*)childController title:(NSString*)title imageName:(NSString*)imageName selectedImageName:(NSString*)selectedImageName {
    childController.title = title;
    childController.tabBarItem.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childController.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [childController.tabBarItem setTitleTextAttributes:@{ NSForegroundColorAttributeName : kRed }forState:UIControlStateSelected];
    
    MMNavigationController *nav = [[MMNavigationController alloc] initWithRootViewController:childController];
    [self addChildViewController:nav];
}


- (UIImage *)imageWithColor:(UIColor *)color{
    // 一个像素
    CGRect rect = CGRectMake(0, 0, 1, 1);
    // 开启上下文
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    [color setFill];
    UIRectFill(rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

#pragma mark ============= tabbarDelegate ==============

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
//    if (tabBarController.selectedIndex == selectedTabbarItemHome) {
//        if (self.selectedTabbarItem == selectedTabbarItemHome) {
//            [self.homeController selectTabbarRefreshData];
//        }
//        self.selectedTabbarItem = selectedTabbarItemHome;
//    }else if (tabBarController.selectedIndex == selectedTabbarItemMessage) {
//        if (self.selectedTabbarItem == selectedTabbarItemMessage) {
//            [self.messageController RefreshMessageSwippleData];
//        }
//        self.selectedTabbarItem = selectedTabbarItemMessage;
//    }else if (tabBarController.selectedIndex == selectedTabbarItemFind) {
//        if (self.selectedTabbarItem == selectedTabbarItemFind) {
//            [self.findController refreshFindData];
//        }
//        self.selectedTabbarItem = selectedTabbarItemFind;
//    }else {
//        self.selectedTabbarItem = selectedTabbarItemMine;
//    }
}

#pragma mark - registerNotifications

- (void)registerNotifications {
    [self unregisterNotifications];
//    [[EMClient sharedClient] addDelegate:self delegateQueue:nil];
//    [[EMClient sharedClient].chatManager addDelegate:self delegateQueue:nil];
}

- (void)unregisterNotifications {
//    [[EMClient sharedClient] removeDelegate:self];
//    [[EMClient sharedClient].chatManager removeDelegate:self];
}

#pragma mark ============= EMClientDelegate ==============

//-(void)connectionStateDidChange:(EMConnectionState)aConnectionState {
//    if (aConnectionState==EMConnectionDisconnected) {
////        [SVProgressHUD showInfoWithStatus:@"环信断开连接"];
//        RSLog(@"环信监听,连接状态发生变化,EMConnectionDisconnected");
//    }else{
//        RSLog(@"环信监听,连接状态发生变化,EMConnectionConnected");
//    }
//    [self.messageController networkChanged:aConnectionState];
//}

//- (void)autoLoginDidCompleteWithError:(EMError *)aError {
//    if (aError) {
////        [SVProgressHUD showErrorWithStatus:@"消息服务器连接失败"];
////        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"自动登录失败，请重新登录" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
////        [alertView show];
//        RSLog(@"自动登录失败，请重新登录");
//    } else if([[EMClient sharedClient] isConnected]){
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//            BOOL flag = [[EMClient sharedClient] migrateDatabaseToLatestSDK];
//            if (flag) {
//                [self asyncConversationFromDB];
//            }
//            RSLog(@"huanxin did auto login");
//        });
//    }
//}

//- (void)userAccountDidLoginFromOtherDevice {
//    //登录 顶替  先移除所有登录信息
//    [UserInfoData resetUserDefault];
//    [AlertViewUntils showNoTouchHideWithTitle:@"提示" detail:@"您的账号已在其他设备登陆" itemHandler:^(NSInteger index) {
//
//    }];
//
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"RefreshMineData" object:nil];
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"RefreshFindData" object:nil];
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"RefreshMessageSwippleData" object:nil];//刷新关注和粉丝列表
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        [[EMClient sharedClient] logout:NO];
//        [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGE object:nil];
//    });
//    [self.navigationController popViewControllerAnimated:YES];
//}

//- (void)userAccountDidRemoveFromServer {
//    [AlertViewUntils showNoTouchHideWithTitle:@"提示" detail:@"您的账号无法登陆消息服务器" itemHandler:^(NSInteger index) {
//    }];
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        [[EMClient sharedClient] logout:NO];
//        [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGE object:@NO];
//    });
//}

#pragma mark - private method

//- (void)asyncPushOptions {
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        EMError *error = nil;
//        [[EMClient sharedClient] getPushOptionsFromServerWithError:&error];
//    });
//}

//- (void)asyncConversationFromDB {
//    WEAKSELF
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        NSArray *array = [[EMClient sharedClient].chatManager getAllConversations];
//        [array enumerateObjectsUsingBlock:^(EMConversation *conversation, NSUInteger idx, BOOL *stop){
//            if(conversation.latestMessage == nil){
//                [[EMClient sharedClient].chatManager deleteConversation:conversation.conversationId isDeleteMessages:NO completion:nil];
//            }
//        }];
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [weakSelf.messageController RefreshMessageSwippleData];
//            [weakSelf setupUnreadMessageCount];
//        });
//    });
//}

#pragma mark ============= EMChatManageDelegate ==============

//- (void)conversationListDidUpdate:(NSArray *)aConversationList {
//    [self setupUnreadMessageCount];
//}
//
//- (void)messagesDidReceive:(NSArray *)aMessages {
//    [self.messageController tableViewDidTriggerHeaderRefresh];
//    [self setupUnreadMessageCount];
//    [[NSNotificationCenter defaultCenter] postNotificationName:KHuanXinUnreadMessageCount object:nil];
//}
//
//// 统计未读消息数
//-(void)setupUnreadMessageCount {
//    NSArray *conversations = [[EMClient sharedClient].chatManager getAllConversations];
//    NSInteger unreadCount = 0;
//    for (EMConversation *conversation in conversations) {
//        if (conversation.type == EMChatTypeChatRoom){
//        }else{
//            unreadCount += conversation.unreadMessagesCount;
//        }
//    }
//    dispatch_async(dispatch_get_main_queue(), ^{
//        if (unreadCount == 0) {
//            self.messageController.tabBarItem.badgeValue = nil;
//        }else {
//            self.messageController.tabBarItem.badgeValue = [NSString stringWithFormat:@"%ld",unreadCount];
//        }
//        UIApplication *application = [UIApplication sharedApplication];
//        [application setApplicationIconBadgeNumber:unreadCount];
//    });
//}

//- (void)dealloc {
//    [self unregisterNotifications];
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:KHuanXinUnreadMessageCount object:nil];
//}

@end
