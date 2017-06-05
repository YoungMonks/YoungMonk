//
//  TRZXLoginUserDefaults.m
//  TRZXLogin
//
//  Created by 张江威 on 2017/4/17.
//  Copyright © 2017年 张江威. All rights reserved.
//

#import "TRZXLoginUserDefaults.h"

@implementation TRZXLoginUserDefaults

#pragma mark-Class static variable
static NSUserDefaults* userDefaults;


+(NSString*) token{
    NSDictionary *userDic = [self get_userDictionary];
    return userDic[tokenKey];
}
+(NSString*) userId{
    NSDictionary *userDic = [self get_userDictionary];
    return userDic[userIdKey];
}

+(NSString*) userSig{
    NSDictionary *userDic = [self get_userDictionary];
    
    return userDic[userSigKey];
}

+(NSString*) head_img{
    NSDictionary *userDic = [self get_userDictionary];
    
    return userDic[head_imgKey];
}
+(NSString*) sex{
    NSDictionary *userDic = [self get_userDictionary];
    
    return userDic[sexKey];
}

+(NSString*) investor{
    NSDictionary *userDic = [self get_userDictionary];
    
    return userDic[investorKey];
}
+(NSString*) realName{
    NSDictionary *userDic = [self get_userDictionary];
    
    return userDic[realNameKey];
}

+(NSString*) name{
    NSDictionary *userDic = [self get_userDictionary];
    
    return userDic[nameKey];
}


//主要的
+(NSDictionary*)get_userDictionary{
    
    return [self readUserDefaults_Object:userKey];
}

+(id) readUserDefaults_Object:(NSString *) objKey{
    return [[TRZXLoginUserDefaults get_userDefaults] objectForKey:objKey];
}


#pragma mark-Class method
+(NSUserDefaults *) get_userDefaults{
    if (userDefaults == nil)
        userDefaults = [NSUserDefaults standardUserDefaults];
    return userDefaults;
}

+(void) saveUserDefaults_NSObject:(NSObject*) objValue objKey:(NSString *)objKey{
    [[TRZXLoginUserDefaults get_userDefaults] setObject:objValue forKey:objKey];
    
    //这里建议同步存储到磁盘中，但是不是必须的
    [[TRZXLoginUserDefaults get_userDefaults] synchronize];
}


@end
