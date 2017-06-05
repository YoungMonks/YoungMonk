//
//  MainTabBarController.m
//  MACProject
//
//  Created by 张江威 on 16/8/11.
//  Copyright © 2016年 张江威. All rights reserved.
//

#import "MainTabBarController.h"
#import "MainTabBar0ViewController.h"
#import "MainTabBar1ViewController.h"
#import "MainTabBar2ViewController.h"
#import "MainTabBar3ViewController.h"
#import "TRZXNavigationController.h"
#import <TRZXKit/TRZXKit.h>
#import "UIViewController+APP.h"
@interface MainTabBarController ()

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];


    for (UITabBarItem *item in self.tabBar.items) {
        item.selectedImage = [item.selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        item.image = [item.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        //item.title
    }
    self.tabBar.tintColor =  [UIColor trzx_RedColor];

    [self initUI];
}
-(void)initUI{
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor trzx_TextColor]} forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor trzx_RedColor]} forState:UIControlStateHighlighted];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor trzx_RedColor]} forState:UIControlStateSelected];
    [self.tabBar setBackgroundImage:[UIImage trzx_imageWithColor:[UIColor trzx_NavigationBarColor]]];

    NSArray *titleArr = @[@"消息",@"通讯录",@"发现",@"我"];
    NSArray *iconArr = @[@"tabbar_mainframe",@"tabbar_contacts",@"tabbar_discover",@"tabbar_me"];
    NSArray *selectIconArr = @[@"tabbar_mainframeHL",@"tabbar_contactsHL",@"tabbar_discoverHL",@"tabbar_meHL"];
    NSArray *controllerArr = @[@"MainTabBar0ViewController",@"MainTabBar1ViewController",@"MainTabBar2ViewController",@"MainTabBar3ViewController"];
    for(NSInteger i = 0;i < controllerArr.count;i++)
    {
            UIViewController *viewController = [[NSClassFromString(controllerArr[i]) alloc]init];
            viewController.view.backgroundColor = [UIColor trzx_BackGroundColor];
            [viewController setTabBarItemImage:iconArr[i] selectedImage:selectIconArr[i] title:titleArr[i]];
            UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:viewController];
            [self addChildViewController:nav];
       
    }
    self.tabBar.selectionIndicatorImage = [UIImage imageNamed:@"bottom_bg"];

}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
