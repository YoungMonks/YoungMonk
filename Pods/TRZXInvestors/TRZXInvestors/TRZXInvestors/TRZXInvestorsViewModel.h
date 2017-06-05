//
//  TRZXProjectViewModel.h
//  TRZXProject
//
//  Created by N年後 on 2017/2/21.
//  Copyright © 2017年 TRZX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReactiveCocoa.h"
#import "TRZXNetwork.h"
#import "TRZXInvestors.h"
@interface TRZXInvestorsViewModel : NSObject
@property (readwrite, nonatomic, strong) NSNumber *pageNo, *pageSize, *totalPage;
@property (assign, nonatomic) BOOL canLoadMore, willLoadMore, isLoading;

@property (strong, nonatomic) NSString *trade; //领域
@property (strong, nonatomic) NSString *stage; //阶段


@property (strong, nonatomic) RACSignal *requestSignal_allInvestors; ///< 全部投资人
@property (readwrite, nonatomic, strong) NSMutableArray *list; // 市场投资人列表


- (void)configWithObj:(TRZXInvestorsViewModel *)model;
@end
