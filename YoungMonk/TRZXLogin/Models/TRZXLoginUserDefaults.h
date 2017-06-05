//
//  TRZXLoginUserDefaults.h
//  TRZXLogin
//
//  Created by 张江威 on 2017/4/17.
//  Copyright © 2017年 张江威. All rights reserved.
//

#import <Foundation/Foundation.h>


static NSString* userKey = @"KPOUser";

static NSString* tokenKey = @"token";

static NSString* userIdKey = @"userId";

static NSString* userSigKey = @"userSig";

static NSString* head_imgKey = @"head_img";

static NSString* sexKey = @"sex";

static NSString* investorKey = @"investor";

static NSString* realNameKey = @"realName";

static NSString* nameKey = @"name";


@interface TRZXLoginUserDefaults : NSObject



+(NSString*) token;

+(NSString*) userId;

+(NSString*) userSig;

+(NSString*) head_img;

+(NSString*) sex;

+(NSString*) investor;

+(NSString*) realName;

+(NSString*) name;


/**
 *  readUserDefaults_Object
 *  读取数据
 *
 *  @param objKey NSString 读取的键名
 *
 *  @return NSObject 键对应值
 */
+(id) readUserDefaults_Object:(NSString *) objKey;

/**
 *  get_userDefaults
 *  获取并初始化 NSUserDefaults 对象
 *
 *  @return NSUserDefaults
 */
+(NSUserDefaults *) get_userDefaults;

/**
 *  saveUserDefaults_NSObject
 *  保存数据
 *
 *  @param objValue NSObject 保存的数据值
 *  @param objKey   NSString 保存的数据键
 */
+(void) saveUserDefaults_NSObject:(NSObject *) objValue objKey:(NSString *)objKey;


@end
