//
//  AppDelegate.m
//  YoungMonk
//
//  Created by 张江威 on 2017/5/18.
//  Copyright © 2017年 张江威. All rights reserved.
//

#import "AppDelegate.h"
#import "TRZXNetwork.h"
#import "TRZXKit.h"
#import <objc/runtime.h>
#import "Login.h"
#import "User.h"

#import "TRZXFirstLoginViewController.h"
#import "TRZXLoginUserDefaults.h"
#import "MainTabBarController.h"


@interface AppDelegate ()
@property (nonatomic, strong) Login *login;


@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [TRZXNetwork configWithBaseURL:@"http://api.kipo.mmwipo.com/"];
    [TRZXNetwork configWithNewBaseURL:@"http://api.kipo.mmwipo.com/"];
    [self enterMainUI];
    
    return YES;
}
- (void)enterMainUI{
    if ([TRZXLoginUserDefaults token]) {
        
//        // 获取当前User
//        User *user = [Login curLoginUser];
//        // 配置请求头
//        NSMutableDictionary *headers = [[NSMutableDictionary alloc]init];
//        [headers setValue:user.token forKey:@"token"];
//        [headers setValue:user.userId forKey:@"userId"];
//        [TRZXNetwork configHttpHeaders:headers];
//        
//        
//        NSLog(@">>>>>>>>>>>>mobel = %@",user.mobile);
        
        
        // 测试退出登录
        // [Login doLogout];
        MainTabBarController * firstVC = [[MainTabBarController alloc] init];
        self.window.rootViewController = firstVC;
        
    }else{
        //        [self.login setType:@"1" mobile:@"13582014204" psd:@"qqqqqq"];
        //        [self.login.requestSignal_login subscribeNext:^(id x) {
        //
        //            User *user = [Login curLoginUser];
        //
        //            // 配置请求头
        //            NSMutableDictionary *headers = [[NSMutableDictionary alloc]init];
        //            [headers setValue:user.token forKey:@"token"];
        //            [headers setValue:user.userId forKey:@"userId"];
        //            [TRZXNetwork configHttpHeaders:headers];
        //
        //            // 请求完成后，更新UI
        //
        //        } error:^(NSError *error) {
        //            // 如果请求失败，则根据error做出相应提示
        //
        //        }];
        TRZXFirstLoginViewController *login= [[TRZXFirstLoginViewController alloc] init];
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:login];
        self.window.rootViewController = nav;
    }
}
- (Login *)login{
    if (!_login) {
        _login = [Login new];
    }
    return _login;
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
