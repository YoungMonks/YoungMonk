//
//  Target_TRZXConfirmFinancing.m
//  TRZXConfirmFinancing
//
//  Created by N年後 on 2017/1/21.
//  Copyright © 2017年 TRZX. All rights reserved.
//

#import "Target_TRZXInvestors.h"
#import "TRZXInvestorsViewController.h"

@implementation Target_TRZXInvestors

- (UIViewController *)Action_InvestorsViewController:(NSDictionary *)params;
{
    TRZXInvestorsViewController *projectPageVC = [[TRZXInvestorsViewController alloc] init];
    projectPageVC.projectTitle = params[@"projectTitle"];
    return projectPageVC;
}

@end
