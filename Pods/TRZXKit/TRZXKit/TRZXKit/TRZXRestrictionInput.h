//
//  TRZXRestrictionInput.h
//  TRZXKit
//
//  Created by N年後 on 2017/4/13.
//  Copyright © 2017年 TRZX. All rights reserved.
//

// 使用方法
/*
 
 
 - (void)textFieldChange:(UITextField *)textField
 {
 //判断输入(不能输入特殊字符)
 [RestrictionInput restrictionInputTextField:self.titleTextField maxNumber:100 showView:self showErrorMessage:@"商品名称0~100字符~"];

 [RestrictionInput restrictionInputTextView:self.infoTextView maxNumber:200 showView:self showErrorMessage:@"商品描述0~200字符~"];

 }

 - (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
 {
 if ([RestrictionInput isInputRuleAndBlank:text] || [text isEqualToString:@""]) {//当输入符合规则和退格键时允许改变输入框
 return YES;
 } else {
 return NO;
 }
 }

 - (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
 {
 if ([RestrictionInput isInputRuleAndBlank:string] || [string isEqualToString:@""]) {//当输入符合规则和退格键时允许改变输入框
 return YES;
 } else {
 return NO;
 }
 }





 */


#import <UIKit/UIKit.h>

@interface TRZXRestrictionInput : NSObject


//验证手机号码
+ (BOOL) validateMobile:(NSString *)mobile;
#pragma mark 电话号验证
+ (BOOL)isMobileNumber:(NSString *)mobileNum;

//验证电子邮箱
+ (BOOL) validateEmail:(NSString *)email;

//验证密码
+ (BOOL) validatePassword:(NSString *) password;

//验证银行卡
+(BOOL)validateBankCard:(NSString *)card;

//  4.身份证验证
+ (BOOL)isIdCard:(NSString *)sPaperId;



/**
 * 判断UITextField输入(不能输入特殊字符)
 */
+ (void)restrictionInputTextField:(UITextField *)inputClass maxNumber:(NSInteger)maxNumber showView:(UIView *)showView showErrorMessage:(NSString *)errorMessage;
/**
 * 判断UITextView输入(不能输入特殊字符)
 */
+ (void)restrictionInputTextView:(UITextView *)inputClass maxNumber:(NSInteger)maxNumber showView:(UIView *)showView showErrorMessage:(NSString *)errorMessage;


/**
 * 字母、数字、中文正则判断（包括空格）【注意3】
 */
+ (BOOL)isInputRuleAndBlank:(NSString *)str;








@end
