//
//  TRZXCityModel.h
//  TRZXLogin
//
//  Created by 张江威 on 2017/4/25.
//  Copyright © 2017年 张江威. All rights reserved.
//

#import <Foundation/Foundation.h>


@class cityData,childrenData;
@interface TRZXCityModel : NSObject
@property (nonatomic, copy) NSString *equipment;

@property (nonatomic, assign) NSInteger pageSize;

@property (nonatomic, copy) NSString *userId;

@property (nonatomic, strong) NSArray<cityData *> *trades;
@property (nonatomic, copy) NSString *status_code;

@property (nonatomic, assign) NSInteger pageNo;


@property (nonatomic, copy) NSString *status_dec;

@property (nonatomic, copy) NSString *requestType;

@property (nonatomic, assign) NSInteger totalPage;

@end

@interface cityData : NSObject<NSCoding>

@property (nonatomic, copy) NSString *mid;

@property (nonatomic, copy) NSString *trade;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, strong) NSArray<childrenData *> *children;

@end

@interface childrenData : NSObject<NSCoding>

@property (nonatomic, copy) NSString *trade;

@property (nonatomic, copy) NSString *mid;

@property (nonatomic, copy) NSString *name;

@end
