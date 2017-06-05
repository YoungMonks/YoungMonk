//
//  TRZXInvestors.h
//  TRZXInvestors
//
//  Created by N年後 on 2017/2/22.
//  Copyright © 2017年 TRZX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TRZXInvestors : NSObject
@property (nonatomic, copy) NSString *mid;// 投资人id
@property (nonatomic, copy) NSString *head_img;// 投资人头像
@property (nonatomic, copy) NSString *realName;// 投资人姓名
@property (nonatomic, copy) NSString *investmentStages; // 阶段
@property (nonatomic, copy) NSString *focusTradesName; // 领域
@property (nonatomic, copy) NSString *iposition; // 投资人职位
@property (nonatomic, copy) NSString *organization; // 投资人简介
@end
