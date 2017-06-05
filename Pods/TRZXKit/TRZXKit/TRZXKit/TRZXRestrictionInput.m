//
//  TRZXRestrictionInput.m
//  TRZXKit
//
//  Created by N年後 on 2017/4/13.
//  Copyright © 2017年 TRZX. All rights reserved.
//

#import "TRZXRestrictionInput.h"

@implementation TRZXRestrictionInput

//验证手机号码
+ (BOOL) validateMobile:(NSString *)mobile
{
    if (mobile.length == 0) {
        NSString *message = @"手机号码不能为空！";
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                            message:message
                                                           delegate:nil
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil, nil];
        [alertView show];
        return NO;
    }
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    if (![phoneTest evaluateWithObject:mobile]) {
        NSString *message = @"手机号码格式不正确！";
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                            message:message
                                                           delegate:nil
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil, nil];
        [alertView show];
        return NO;
    }
    return YES;
}

#pragma mark 电话号验证
+ (BOOL)isMobileNumber:(NSString *)mobileNum
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";

    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";

    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";

    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";

    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";

    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];

    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];

    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];

    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];

    NSPredicate *regextestphs = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PHS];


    if (([regextestmobile evaluateWithObject:mobileNum] == YES)

        || ([regextestcm evaluateWithObject:mobileNum] == YES)

        || ([regextestct evaluateWithObject:mobileNum] == YES)

        || ([regextestcu evaluateWithObject:mobileNum] == YES)

        || ([regextestphs evaluateWithObject:mobileNum] == YES))

    {
        return YES;
    }
    else
    {
        return NO;
    }
}

//验证电子邮箱
+ (BOOL) validateEmail:(NSString *)email
{
    if (email.length == 0) {
        NSString *message = @"邮箱不能为空！";
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                            message:message
                                                           delegate:nil
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil, nil];
        [alertView show];
        return NO;
    }

    NSString *expression = [NSString stringWithFormat:@"^\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*$"];
    NSError *error = NULL;
    NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:expression
                                                                      options:NSRegularExpressionCaseInsensitive
                                                                        error:&error];
    NSTextCheckingResult *match = [regex firstMatchInString:email
                                                    options:0
                                                      range:NSMakeRange(0,[email length])];
    if (!match) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                            message:@"邮箱格式错误！"
                                                           delegate:nil
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil, nil];
        [alertView show];
        return NO;
    }
    return YES;
}

//验证密码
+(BOOL)validatePassword:(NSString *)password
{
    if (password.length == 0) {
        NSString *message = @"密码不能为空！";
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                            message:message
                                                           delegate:nil
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil, nil];
        [alertView show];
        return NO;
    }
    if (password.length < 6) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                            message:@"密码不足六位！"
                                                           delegate:nil
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil, nil];
        [alertView show];
        return NO;
    }

    return YES;
}
//银行卡验证
+(BOOL)validateBankCard:(NSString *)card{

    if (card.length==0) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                            message:@"银行卡不能为空"
                                                           delegate:nil
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil, nil];
        return NO;
    }
    NSString *bankNameregex = @"^[\u4e00-\u9fa5]{0,}$";
    NSPredicate *bankNamepredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", bankNameregex];
    BOOL isbankName = [bankNamepredicate evaluateWithObject:card];

    if (!isbankName) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                            message:@"银行卡格式不对"
                                                           delegate:nil
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil, nil];
        [alertView show];
        return NO;
    }

    return YES;
}
#pragma mark 验证身份证是否合法
/**
 * 功能:验证身份证是否合法
 * 参数:输入的身份证号
 */
+ (BOOL)isIdCard:(NSString *)sPaperId
{
    //判断位数
    if ([sPaperId length] < 15 ||[sPaperId length] > 18) {
        return NO;
    }
    NSString *carid = sPaperId;
    long lSumQT =0;
    //加权因子
    int R[] ={7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2 };
    //校验码
    unsigned char sChecker[11]={'1','0','X', '9', '8', '7', '6', '5', '4', '3', '2'};
    //将15位身份证号转换成18位
    NSMutableString *mString = [NSMutableString stringWithString:sPaperId];
    if ([sPaperId length] == 15) {
        [mString insertString:@"19" atIndex:6];
        long p = 0;
        const char *pid = [mString UTF8String];
        for (int i=0; i<=16; i++)
        {
            p += (pid[i]-48) * R[i];
        }
        int o = p%11;
        NSString *string_content = [NSString stringWithFormat:@"%c",sChecker[o]];
        [mString insertString:string_content atIndex:[mString length]];
        carid = mString;

    }
    //判断地区码
    NSString * sProvince = [carid substringToIndex:2];

    if (![self areaCode:sProvince]) {

        return NO;
    }
    //年份
    int strYear = [[carid substringWithRange:NSMakeRange(6, 4)]intValue];
    //月份
    int strMonth = [[carid substringWithRange:NSMakeRange(10, 2)]intValue];
    //日
    int strDay = [[carid substringWithRange:NSMakeRange(12, 2)]intValue];

    NSTimeZone *localZone = [NSTimeZone localTimeZone];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    [dateFormatter setTimeZone:localZone];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date=[dateFormatter dateFromString:[NSString stringWithFormat:@"%d-%d-%d 12:01:01",strYear,strMonth,strDay]];
    if (date == nil) {

        return NO;
    }

    const char *PaperId  = [carid UTF8String];

    //检验长度
    if( 18 != strlen(PaperId)) return -1;
    //校验数字
    for (int i=0; i<18; i++)
    {
        if ( !isdigit(PaperId[i]) && !(('X' == PaperId[i] || 'x' == PaperId[i]) && 17 == i) )
        {
            return NO;
        }
    }
    //验证最末的校验码
    for (int i=0; i<=16; i++)
    {
        lSumQT += (PaperId[i]-48) * R[i];
    }
    if (sChecker[lSumQT%11] != PaperId[17] )
    {
        return NO;
    }

    return YES;
}
/**
 * 功能:判断是否在地区码内
 * 参数:地区码
 */
+(BOOL)areaCode:(NSString *)code
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"北京" forKey:@"11"];
    [dic setObject:@"天津" forKey:@"12"];
    [dic setObject:@"河北" forKey:@"13"];
    [dic setObject:@"山西" forKey:@"14"];
    [dic setObject:@"内蒙古" forKey:@"15"];
    [dic setObject:@"辽宁" forKey:@"21"];
    [dic setObject:@"吉林" forKey:@"22"];
    [dic setObject:@"黑龙江" forKey:@"23"];
    [dic setObject:@"上海" forKey:@"31"];
    [dic setObject:@"江苏" forKey:@"32"];
    [dic setObject:@"浙江" forKey:@"33"];
    [dic setObject:@"安徽" forKey:@"34"];
    [dic setObject:@"福建" forKey:@"35"];
    [dic setObject:@"江西" forKey:@"36"];
    [dic setObject:@"山东" forKey:@"37"];
    [dic setObject:@"河南" forKey:@"41"];
    [dic setObject:@"湖北" forKey:@"42"];
    [dic setObject:@"湖南" forKey:@"43"];
    [dic setObject:@"广东" forKey:@"44"];
    [dic setObject:@"广西" forKey:@"45"];
    [dic setObject:@"海南" forKey:@"46"];
    [dic setObject:@"重庆" forKey:@"50"];
    [dic setObject:@"四川" forKey:@"51"];
    [dic setObject:@"贵州" forKey:@"52"];
    [dic setObject:@"云南" forKey:@"53"];
    [dic setObject:@"西藏" forKey:@"54"];
    [dic setObject:@"陕西" forKey:@"61"];
    [dic setObject:@"甘肃" forKey:@"62"];
    [dic setObject:@"青海" forKey:@"63"];
    [dic setObject:@"宁夏" forKey:@"64"];
    [dic setObject:@"新疆" forKey:@"65"];
    [dic setObject:@"台湾" forKey:@"71"];
    [dic setObject:@"香港" forKey:@"81"];
    [dic setObject:@"澳门" forKey:@"82"];
    [dic setObject:@"国外" forKey:@"91"];

    if ([dic objectForKey:code] == nil) {

        return NO;
    }
    return YES;
}







+ (void)restrictionInputTextField:(UITextField *)inputClass maxNumber:(NSInteger)maxNumber showView:(UIView *)showView showErrorMessage:(NSString *)errorMessage
{

    NSString *toBeString = inputClass.text;

    if (![self isInputRuleAndBlank:toBeString]) {
        inputClass.text = [self disable_emoji:toBeString];
        return;
    }

    NSString *lang = [[inputClass textInputMode] primaryLanguage]; // 获取当前键盘输入模式
    if([lang isEqualToString:@"zh-Hans"]) { //简体中文输入,第三方输入法（搜狗）所有模式下都会显示“zh-Hans”
        UITextRange *selectedRange = [inputClass markedTextRange];
        //获取高亮部分
        UITextPosition *position = [inputClass positionFromPosition:selectedRange.start offset:0];
        //没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if(!position) {
            NSString *getStr = [self getSubString:toBeString maxNumber:maxNumber];
            if(getStr && getStr.length > 0) {
                inputClass.text = getStr;

                NSLog(@"%@", errorMessage);
                NSLog(@"%@", inputClass.text);
            }
        }
    } else{
        NSString *getStr = [self getSubString:toBeString maxNumber:maxNumber];
        if(getStr && getStr.length > 0) {
            inputClass.text= getStr;
            NSLog(@"%@", errorMessage);
            NSLog(@"%@",inputClass.text);
        }
    }
}

+ (void)restrictionInputTextView:(UITextView *)inputClass maxNumber:(NSInteger)maxNumber showView:(UIView *)showView showErrorMessage:(NSString *)errorMessage
{
    NSString *toBeString = inputClass.text;

    if (![self isInputRuleAndBlank:toBeString]) {
        inputClass.text = [self disable_emoji:toBeString];
        return;
    }

    NSString *lang = [[inputClass textInputMode] primaryLanguage]; // 获取当前键盘输入模式
    if([lang isEqualToString:@"zh-Hans"]) { //简体中文输入,第三方输入法（搜狗）所有模式下都会显示“zh-Hans”
        UITextRange *selectedRange = [inputClass markedTextRange];
        //获取高亮部分
        UITextPosition *position = [inputClass positionFromPosition:selectedRange.start offset:0];
        //没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if(!position) {
            NSString *getStr = [self getSubString:toBeString maxNumber:maxNumber];
            if(getStr && getStr.length > 0) {
                inputClass.text = getStr;
                NSLog(@"%@", errorMessage);

                NSLog(@"%@", inputClass.text);
            }
        }
    } else{
        NSString *getStr = [self getSubString:toBeString maxNumber:maxNumber];
        if(getStr && getStr.length > 0) {
            inputClass.text= getStr;
            NSLog(@"%@", errorMessage);
            NSLog(@"%@",inputClass.text);
        }
    }
}

/**
 *  获得 kMaxLength长度的字符
 */
+ (NSString *)getSubString:(NSString*)string maxNumber:(NSInteger)maxNumber
{
    NSStringEncoding encoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSData* data = [string dataUsingEncoding:encoding];
    NSInteger length = [data length];
    if (length > maxNumber) {
        NSData *data1 = [data subdataWithRange:NSMakeRange(0, maxNumber)];
        NSString *content = [[NSString alloc] initWithData:data1 encoding:encoding];//【注意4】：当截取kMaxLength长度字符时把中文字符截断返回的content会是nil
        if (!content || content.length == 0) {
            data1 = [data subdataWithRange:NSMakeRange(0, maxNumber - 1)];
            content =  [[NSString alloc] initWithData:data1 encoding:encoding];
        }
        return content;
    }
    return nil;
}

/**
 * 字母、数字、中文正则判断（不包括空格）
 */
+ (BOOL)isInputRuleNotBlank:(NSString *)str {
    NSString *pattern = @"^[➋➌➍➎➏➐➑➒\a-zA-Z\u4E00-\u9FA5\\d]*$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:str];
    return isMatch;
}
/**
 * 字母、数字、中文正则判断（包括空格）【注意3】
 */
+ (BOOL)isInputRuleAndBlank:(NSString *)str {

    //九宫格无法输入解决需要加上正则 \➋➌➍➎➏➐➑➒
    NSString *pattern = @"^[➋➌➍➎➏➐➑➒\a-zA-Z\u4E00-\u9FA5\\d\\s]*$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:str];
    return isMatch;
}

+ (NSString *)disable_emoji:(NSString *)text{
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]"options:NSRegularExpressionCaseInsensitive error:nil];
    NSString *modifiedString = [regex stringByReplacingMatchesInString:text
                                                               options:0
                                                                 range:NSMakeRange(0, [text length])
                                                          withTemplate:@""];
    return modifiedString;
}
@end
