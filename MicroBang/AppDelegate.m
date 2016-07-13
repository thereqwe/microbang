//
//  AppDelegate.m
//  MicroBang
//
//  Created by leon on 2016/二月/14.
//  Copyright © 2016年 leon. All rights reserved.
//

#import "AppDelegate.h"
#import "MBBaseNavigationController.h"
#import "MBBaseViewController.h"
#import "MBMsgListViewController.h"
#import "MBProfileViewController.h"
#import "SocketService.h"
#import  "MBMsgListener.h"
#import  "FMDBService.h"
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
    //聊天中心
    MessageNavi = [[MBBaseNavigationController alloc]init];
    MBMsgListViewController *messageIndexVc = [MBMsgListViewController new];
    [MessageNavi pushViewController:messageIndexVc animated:NO];
    
    //个人设置中心
    PersonalNavi = [[MBBaseNavigationController alloc]init];
    MBProfileViewController *profileViewController = [MBProfileViewController new];
    [PersonalNavi pushViewController:profileViewController animated:NO];
    
    baseTabBar = [[MBBaseTabBarController alloc]init];
    [baseTabBar setViewControllers:@[MessageNavi,PersonalNavi]];
    MessageNavi.title = @"聊天";
    PersonalNavi.title = @"设置";
  
    window.rootViewController = baseTabBar;
    [self.window makeKeyAndVisible];
}

- (void)setupEnv {
    /******************udp socket**********************/
    [SocketService sharedInstance].delegate = self;
    [[SocketService sharedInstance] connectToHost:@"30.97.16.232" onPort:10006 error:nil];
    /******************高德地图**********************/
    [MAMapServices sharedServices].apiKey = @"e590b8299c0475aaff1e3d58e3c22964";
    /******************msg listen**********************/
    [[MBMsgListener sharedInstance] getNewMsg];
    /******************FMDB**********************/
    [[FMDBService sharedInstance] open];
    //msg
    BOOL rst = [[FMDBService sharedInstance] executeUpdate:@"create table if not exists mb_msg(id integer primary key  autoincrement, msg text,from_mid varchar(256),create_time datetime)"];
    //friend
    BOOL rst2 = [[FMDBService sharedInstance] executeUpdate:@"create table if not exists mb_friend(id integer primary key  autoincrement, nickname varchar(256),friend_mid varchar(256),avatar_url varchar(1024) ,create_time datetime)"];
    if (rst&&rst2) {
        NSLog(@"FMDB 初始化成功");
    }
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
