//
//  MainTabBar3ViewController.m
//  TRZX
//
//  Created by 张江威 on 2017/1/23.
//  Copyright © 2017年 张江威. All rights reserved.
//

#import "MainTabBar3ViewController.h"
#import "TRZXLoginUserDefaults.h"
#import "TRZXFirstLoginViewController.h"
#import "AppDelegate.h"


@interface MainTabBar3ViewController ()

@property (strong, nonatomic)AppDelegate *appdelegate;


@end

@implementation MainTabBar3ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIButton * loginButton = [UIButton buttonWithType:UIButtonTypeSystem];
    loginButton.frame = CGRectMake(100, 100, 100, 50);
    loginButton.backgroundColor = [UIColor redColor];
    [loginButton.layer setCornerRadius:10.0];
    [loginButton setTitle:@"退出" forState:UIControlStateNormal];
    [loginButton setTitle:@"退出" forState:UIControlStateHighlighted];
    loginButton.tintColor = [UIColor whiteColor];
    loginButton.titleLabel.font = [UIFont systemFontOfSize: 19.0];
    [loginButton addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButton];
    
}
//事件
-(void)btnClick:(id)sender{
    [[TRZXLoginUserDefaults get_userDefaults] removeObjectForKey:userKey];
    NSLog(@"%@",[TRZXLoginUserDefaults token]);
    _appdelegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
    [_appdelegate enterMainUI];
    //    [self dismissViewControllerAnimated:NO completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
