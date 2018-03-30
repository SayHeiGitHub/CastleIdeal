//
//  AppDelegate.m
//  CastleIdeal
//
//  Created by 姜鸥人 on 2018/3/27.
//  Copyright © 2018年 HeiCoder_OR. All rights reserved.
//

#import "AppDelegate.h"

#import "RSTabBarController.h"
#import "LaunchingScrollView.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
     [[IQKeyboardManager sharedManager] setEnable:YES];
     [[NetStatusMonitor  monitor] startMonitorNetwork];
     [self setupSVPApprence];
     [self setupAlertUtils];
     [self setupTabBarItem];
     [self setupRootViewController];
    return YES;
}
- (void)setupSVPApprence {
    [SVProgressHUD setMinimumDismissTimeInterval:1.5];
    [[SVProgressHUD appearance] setCornerRadius:5];
    [[SVProgressHUD appearance] setDefaultStyle:SVProgressHUDStyleCustom];
    [[SVProgressHUD appearance] setBackgroundColor:kRGBCOLOR(230, 231, 238)];
    [[SVProgressHUD appearance] setForegroundColor:[UIColor blackColor]];
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
}

- (void)setupAlertUtils {
    MMAlertViewConfig *alertViewConfig = [MMAlertViewConfig globalConfig];
    alertViewConfig.titleFontSize      = 16;
    alertViewConfig.buttonFontSize     = 16;
    alertViewConfig.titleColor         = kDark;
    alertViewConfig.detailColor        = kRGB16(0x777777);
    alertViewConfig.itemNormalColor    = kRGB16(0x0099FF);
}

-(void)setupTabBarItem {
    NSDictionary *tabBarNormalTitleTextDic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:10],NSFontAttributeName,nil];
    [[UITabBarItem appearance] setTitleTextAttributes:tabBarNormalTitleTextDic forState:UIControlStateNormal];
    NSDictionary *tabBarSelectTitleTextDic = [NSDictionary dictionaryWithObjectsAndKeys:kRGB16(0xffd634),NSForegroundColorAttributeName,nil];
    [[UITabBarItem appearance] setTitleTextAttributes:tabBarSelectTitleTextDic forState:UIControlStateSelected];
}

-(void)setupRootViewController {
    RSTabBarController *tabBarController =[[RSTabBarController alloc] init];
    [self.window setRootViewController:tabBarController];
    //  需要注意，KEY_HAS_LOGIN必须添加版本号以示区别,如果不需要引导页，可注释掉本句
    if (![[NSUserDefaults standardUserDefaults] boolForKey:[NSString stringWithFormat:@"KEY_HASLOGIN_%@",kCURRENT_APP_VERSION]]) {
        LaunchingScrollView *launchScrollVC=[[LaunchingScrollView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        [tabBarController.view addSubview:launchScrollVC];
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
