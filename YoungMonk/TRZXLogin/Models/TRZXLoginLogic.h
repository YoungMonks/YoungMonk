//
//  TRZXLoginLogic.h
//  TRZXLogin
//
//  Created by 张江威 on 2017/4/11.
//  Copyright © 2017年 张江威. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <MJRefresh/MJRefresh.h>
#import "TRZXNetwork.h"
#import <MJExtension/MJExtension.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "TRZXLoginUserDefaults.h"

@interface TRZXLoginLogic : NSObject



#define backColor [UIColor colorWithRed:240.0/255.0 green:239.0/255.0 blue:244.0/255.0 alpha:1]



#define mobleNB        201741101//手机号
#define verificationNB 201741102//验证码
#define passwordNB     201741103//密码
#define passwordOneNB  201741104//新密码1
#define passwordTwoNB  201741105//新密码2
#define emailNB        201741106//邮箱

#define nameNB         201741901//姓名
#define sexNB          201741902//性别
#define idCardNB       201741903//身份证号

//定义宏（限制输入内容）
#define kAlphaNum  @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"


#pragma mark 手机号验证
+ (BOOL)isValidateMobile:(NSString *)mobileNum;

#pragma mark 邮箱验证
+(BOOL)isValidateEmail:(NSString *)email;

#pragma mark 密码验证 (6~16位)
+(BOOL)isValidatePassword:(NSString *)password;

#pragma mark 验证码验证
+(BOOL)isValidateValidation:(NSString *)validation;

#pragma mark 身份证号
+ (BOOL)isValidateIdentityCard: (NSString *)identityCard;

#pragma mark 护照号
+ (BOOL)isValidatePassport: (NSString *)identityCard;

#pragma mark 中文
+ (BOOL)isChiness:(NSString *)character;

#pragma mark URL
+ (BOOL)isURL:(NSString *)neturl;

//#pragma mark 中文
//+ (BOOL)isChiness:(NSString *)character;

#pragma mark 字符串加密
//16位MD5加密方式
+ (NSString *)getMd5_16Bit_String:(NSString *)srcString isUppercase:(BOOL)isUppercase;
//32位MD5加密方式
+ (NSString *)getMd5_32Bit_String:(NSString *)srcString isUppercase:(BOOL)isUppercase;
//sha1加密方式
+ (NSString *)getSha1String:(NSString *)srcString;
//sha256加密方式
+ (NSString *)getSha256String:(NSString *)srcString;
//sha384加密方式
+ (NSString *)getSha384String:(NSString *)srcString;
//sha512加密方式
+ (NSString*) getSha512String:(NSString*)srcString;



@end
