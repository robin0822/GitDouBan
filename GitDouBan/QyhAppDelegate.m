//
//  QyhAppDelegate.m
//  GitDouBan
//
//  Created by ibokan on 13-4-15.
//  Copyright (c) 2013年 quyanhui. All rights reserved.
//

#import "QyhAppDelegate.h"

#import "SouCangViewController.h" 
#import "GuanYuViewController.h"
#import "TuiJianViewController.h"

@implementation QyhAppDelegate

- (void)dealloc
{
    [_window release];
    [_viewController release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    TuiJianViewController *sousu = [[TuiJianViewController alloc]init];
    UINavigationController *navigation1 = [[UINavigationController alloc]initWithRootViewController:sousu];
    navigation1.tabBarItem.title = @"推荐";
    navigation1.navigationBar.tintColor = [UIColor grayColor];
    navigation1.tabBarItem.image = [UIImage imageNamed:@"123.png"];
    [sousu release];
    
    
    SouCangViewController *tuijian = [[SouCangViewController alloc]initWithStyle:UITableViewStylePlain];
    UINavigationController *navigation2 = [[UINavigationController alloc]initWithRootViewController:tuijian];
    navigation2.tabBarItem.title = @"收藏";
    navigation2.tabBarItem.image = [UIImage imageNamed:@"456.png"];
    [tuijian release];
    
    
    GuanYuViewController *guanyu = [[GuanYuViewController alloc]init];
    UINavigationController *navigation3 = [[UINavigationController alloc]initWithRootViewController:guanyu];
    navigation3.tabBarItem.title = @"关于";
    navigation3.tabBarItem.image = [UIImage imageNamed:@"789.png"];
    [guanyu release];
    
    UITabBarController *tab = [[UITabBarController alloc] init];
    tab.viewControllers = [NSArray arrayWithObjects:navigation1, navigation2, navigation3, nil];
    
    self.window.rootViewController = tab;
    [tab release];
    
    [navigation1 release];
    [navigation2 release];
    [navigation3 release];

    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
