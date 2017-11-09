//
//  AppDelegate.m
//  心仪家居
//
//  Created by dllo on 15/12/21.
//  Copyright © 2015年 蓝鸥科技. All rights reserved.
//

#import "AppDelegate.h"
#import "HomePageViewController.h"
#import "GalleryViewController.h"
#import "InstanceViewController.h"
#import "UserViewController.h"
#import "DataBaseLast.h"
#import "GuidanceViewController.h"
#import <ShareSDK/ShareSDK.h>
@interface AppDelegate ()<UITabBarControllerDelegate>

@end

@implementation AppDelegate
- (void)dealloc
{
    [_window release];
    [super dealloc];
    
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
 
    
    self.window.backgroundColor = [UIColor whiteColor];
   
   
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"ye"];
    //打开数据库
    [[DataBaseLast defaultDataBaseLast]openDatabase];
    
    
    
    
    
    
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    if([userDefaults objectForKey:@"FirstLoad"] == nil) {
        [userDefaults setBool:NO forKey:@"FirstLoad"];
        //显示引导页
        GuidanceViewController *gudanceVC = [[GuidanceViewController alloc] init];
        
        
        self.window.rootViewController = gudanceVC;
        [gudanceVC release];
    }else
    {
        [self takeTheTabBarController];
    }
    
    [ShareSDK registerApp:@"iosv1101"
          activePlatforms:@[@(SSDKPlatformTypeSinaWeibo), @(SSDKPlatformTypeTencentWeibo)]
                 onImport:nil
          onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo) {
              
              switch (platformType)
              {
                  case SSDKPlatformTypeSinaWeibo:
                      //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
                      [appInfo SSDKSetupSinaWeiboByAppKey:@"568898243"
                                                appSecret:@"38a4f8204cc784f81f9f0daaf31e02e3"
                                              redirectUri:@"http://www.sharesdk.cn"
                                                 authType:SSDKAuthTypeBoth];
                      break;
                  default:
                  case SSDKPlatformTypeTencentWeibo:
                      //设置腾讯微博应用信息，其中authType设置为只用Web形式授权
                      [appInfo SSDKSetupTencentWeiboByAppKey:@"801307650"
                                                   appSecret:@"ae36f4ee3946e1cbb98d6965b0b2ff5c"
                                                 redirectUri:@"http://www.sharesdk.cn"];

                      break;
              } 
              
          }];


    [_window release];
    

    
    [self.window makeKeyAndVisible];
    return YES;
}


- (void)takeTheTabBarController
{
    UITabBarController *firstBar = [[UITabBarController alloc] init];
    
    firstBar.tabBar.tintColor = [UIColor redColor];
    
    firstBar.delegate = self;
    
    [[UINavigationBar appearance]setBarTintColor:[UIColor colorWithRed:0.828 green:0.113 blue:0.160 alpha:1]];
    
    //启动页
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO];

    [NSThread sleepForTimeInterval:1];
    
    //首页
    HomePageViewController *homePageVC = [[HomePageViewController alloc]init];
    
    UINavigationController *homePageNav = [[UINavigationController alloc] initWithRootViewController:homePageVC];
    
    homePageNav.tabBarItem.title = @"首页";
    
    homePageNav.tabBarItem.image = [UIImage imageNamed:@"53-house"];
    
    //图库
    GalleryViewController *galleryVC =[[GalleryViewController alloc] init];
    UINavigationController *galleryNav = [[UINavigationController alloc] initWithRootViewController:galleryVC];
    
    galleryNav.tabBarItem.title = @"图库";
    
    galleryNav.tabBarItem.image = [UIImage imageNamed:@"98-palette"];
    
    //实例
    InstanceViewController *instanceVC = [[InstanceViewController alloc] init];
    
    UINavigationController *instanceNav = [[UINavigationController alloc] initWithRootViewController:instanceVC];
    
    instanceNav.tabBarItem.title = @"实例";
    
    instanceNav.tabBarItem.image = [UIImage imageNamed:@"13-target"];
    //用户
    UserViewController *userVC = [[UserViewController alloc] init];
    
    UINavigationController *userNav = [[UINavigationController alloc] initWithRootViewController:userVC];
    
    userNav.tabBarItem.title = @"我的";
    
    userNav.tabBarItem.image = [UIImage imageNamed:@"Tabbar-Btn-Hot-Normal"];
    
    
    firstBar.viewControllers = @[homePageNav, galleryNav, instanceNav, userNav];
    
    
    self.window.rootViewController = firstBar;
    [userVC release];
    [instanceVC release];
    [galleryVC release];
    [homePageVC release];
    [firstBar release];
    

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
