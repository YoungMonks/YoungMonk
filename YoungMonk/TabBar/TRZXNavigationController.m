//
//  TRZXNavigationController.m
//  TRZX
//
//  Created by 张江威 on 16/8/19.
//  Copyright © 2016年 张江威. All rights reserved.
//

#import "TRZXNavigationController.h"
#import "TRZXKit.h"
#import "AppDelegate.h"
@interface TRZXNavigationController ()<UIGestureRecognizerDelegate>
@end

@implementation TRZXNavigationController

- (void)viewDidLoad{
    [super viewDidLoad];
    //设置滑动返回还是返回按钮
//    __weak typeof (self) weakSelf = self;
//    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
//        self.interactivePopGestureRecognizer.delegate = weakSelf;
//    }
    [self appConfig];
}

-(void)appConfig{


    //Nav文字属性
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowColor = [UIColor colorWithWhite:0.0f alpha:1.0f];
    shadow.shadowOffset = CGSizeMake(0, 0);
    [[UINavigationBar appearance] setTitleTextAttributes:@{
                                                           NSForegroundColorAttributeName: [UIColor trzx_NavTitleColor],
                                                           NSShadowAttributeName: [[NSShadow alloc] init],
                                                           NSFontAttributeName: [UIFont boldSystemFontOfSize:17]
                                                           }];


    //Nav Item文字属性
    [[UIBarButtonItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor trzx_NavTitleColor],NSForegroundColorAttributeName, [UIFont systemFontOfSize:17],NSFontAttributeName , nil] forState:0];

    // 标题颜色
    [[UINavigationBar appearance] setTintColor:[UIColor  trzx_NavTitleColor]];

    // Nav背景颜色
    [[UINavigationBar appearance] setBarTintColor:[UIColor trzx_NavigationBarColor]];


    // 返回按钮图片
    [[UINavigationBar appearance] setBackIndicatorImage:[UIImage imageNamed:@"back_indicator"]];
    [[UINavigationBar appearance] setBackIndicatorTransitionMaskImage:[UIImage imageNamed:@"back_indicator"]];


    AppDelegate * appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    appDelegate.window.backgroundColor = [UIColor whiteColor]; // 解决 push/pop 导航栏黑色阴影问题
    
}


/**
 * 可以在这个方法中拦截所有push进来的控制器
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count > 0) { // 如果push进来的不是第一个控制器

        if ([viewController isKindOfClass:NSClassFromString(@"UIViewController")]) {

        }else{


        }
        // 隐藏tabbar
        viewController.hidesBottomBarWhenPushed = YES;
    }

    // 设置控制器背景颜色
    viewController.view.backgroundColor = [UIColor groupTableViewBackgroundColor];

    // 这句super的push要放在后面, 让viewController可以覆盖上面设置的leftBarButtonItem
    [super pushViewController:viewController animated:animated];
    
}



@end
