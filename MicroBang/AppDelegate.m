//
//  AppDelegate.m
//  MicroBang
//
//  Created by leon on 2016/二月/14.
//  Copyright © 2016年 leon. All rights reserved.
//

#import "AppDelegate.h"
#import "MBNearListViewController.h"
#import "MBActivityIndexViewController.h"
#import "MBPersonIndexViewController.h"
#import "MBMessageIndexViewController.h"
@interface AppDelegate ()
{
    MBBaseNavigationController *NearNavi;
    MBBaseNavigationController *ActivityNavi;
    MBBaseNavigationController *MessageNavi;
    MBBaseNavigationController *PersonalNavi;
    MBBaseTabBarController     *baseTabBar;
}

@end

@implementation AppDelegate

- (void)setupUI {
    UIWindow *window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    window.backgroundColor = [UIColor whiteColor];
    self.window = window;
    //4 section
    NearNavi = [[MBBaseNavigationController alloc]initWithRootViewController:[MBNearListViewController new]];
    [NearNavi setTitle:@"附近"];
    ActivityNavi = [[MBBaseNavigationController alloc]initWithRootViewController:[MBActivityIndexViewController new]];
    [ActivityNavi setTitle:@"发现"];
    MessageNavi = [[MBBaseNavigationController alloc]initWithRootViewController:[MBMessageIndexViewController new]];
    [MessageNavi setTitle:@"消息"];
    PersonalNavi = [[MBBaseNavigationController alloc]initWithRootViewController:[MBPersonIndexViewController new]];
    [PersonalNavi setTitle:@"个人"];
    baseTabBar = [[MBBaseTabBarController alloc]init];
    [baseTabBar setViewControllers:@[NearNavi,ActivityNavi,MessageNavi,PersonalNavi]];
    window.rootViewController = baseTabBar;
    [self.window makeKeyAndVisible];
}

- (void)setupEnv {
    [MAMapServices sharedServices].apiKey = @"e590b8299c0475aaff1e3d58e3c22964";
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self setupUI];
    [self setupEnv];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
