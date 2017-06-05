//
//  CTMediator+TRZXConfirmFinancing.m
//  TRZXConfirmFinancingBusinessCategory
//
//  Created by N年後 on 2017/1/21.
//  Copyright © 2017年 TRZX. All rights reserved.
//

#import "CTMediator+TRZXInvestors.h"

@implementation CTMediator (TRZXInvestors)
- (UIViewController *)investorsViewController:(NSString *)projectTitle{

    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[@"projectTitle"] = projectTitle;
    return [self performTarget:@"TRZXInvestors" action:@"InvestorsViewController" params:params shouldCacheTarget:NO];
}
@end
