//
//  TRZXLoginViewController.m
//  TRZXLogin
//
//  Created by 张江威 on 2017/4/10.
//  Copyright © 2017年 张江威. All rights reserved.
//

#import "TRZXLoginViewController.h"
#import "TRZXRetrievePasswordViewController.h"
#import "TRZXLoginLogic.h"


@interface TRZXLoginViewController ()
- (IBAction)ForgotPasswordBtn:(UIButton *)sender;
- (IBAction)loginBtn:(UIButton *)sender;
- (IBAction)passwordHidden:(UIButton *)sender;

@property (strong, nonatomic) NSString *str1;
@property (strong, nonatomic) NSString *str2;

@property (nonatomic,assign)NSInteger maxCount;

@end

@implementation TRZXLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"登录";
    [[NSBundle bundleForClass:[self class]] loadNibNamed:@"TRZXLoginViewController" owner:self options:nil];
    self.loginButton.layer.cornerRadius =  6;
    self.loginButton.layer.masksToBounds = YES;
    [_accountText addTarget:self action:@selector(textChanged:) forControlEvents:UIControlEventEditingChanged];
    [_passwordText addTarget:self action:@selector(textChanged:) forControlEvents:UIControlEventEditingChanged];
    
    NSLog(@"hello---------%@",[TRZXLoginUserDefaults name]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//忘记密码
- (IBAction)ForgotPasswordBtn:(UIButton *)sender {
    TRZXRetrievePasswordViewController *viewController = [[TRZXRetrievePasswordViewController alloc] init];
    [self.navigationController pushViewController: viewController animated:true];
}

//登录
- (IBAction)loginBtn:(UIButton *)sender {
    if ([_accountText.text isEqualToString:@""]) {
        _str1 = nil;
        _str2 = @"请输入账号";
        [self alertViewStr];
    }else if ([TRZXLoginLogic isValidatePassword:_passwordText.text]) {
        [self Login_Api];
    }else{
        _str1 = @"密码不符合要求";
        _str2 = @"密码为6-20位数字、字母的任意组合";
        [self alertViewStr];
    }

}

//密码显示状态
- (IBAction)passwordHidden:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        _passwordText.secureTextEntry = YES;
    }else{
        _passwordText.secureTextEntry = NO;
    }
}
- (void)Login_Api{
    NSString*password=[TRZXLoginLogic getMd5_32Bit_String:_passwordText.text isUppercase:NO];
    NSString*account=_accountText.text;
    
    NSMutableDictionary *params = @{@"requestType" : @"Login_Api",
                                    @"loginType" : @"1",
                                    @"loginCode" : account,
                                    @"password" : password,
                                    @"deviceToken":@""}.mutableCopy;
    [TRZXNetwork requestWithUrl:nil params:params method:POST cachePolicy:NetworkingReloadIgnoringLocalCacheData callbackBlock:^(id object, NSError *error) {
        if ([object[@"status_code"] isEqualToString:@"200"]) {
            
        }else{
            _str1 = object[@"status_dec"];
            _str2 = @"";
            [self alertViewStr];
        }
        
    }];
}
#pragma  mark - 文本改变的通知
- (void)textChanged:(UITextField *)textField
{
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"
    if (textField.tag == mobleNB) {
        _maxCount = 11;
    }else{
        _maxCount = 20;
    }
    NSString *toBeString = textField.text;
    NSString *lang = [[UITextInputMode currentInputMode] primaryLanguage]; // 键盘输入模式
    
    if ([lang isEqualToString:@"zh-Hans"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
        UITextRange *selectedRange = [textField markedTextRange];
        //获取高亮部分
        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position) {
            if (toBeString.length > self.maxCount) {
                textField.text = [toBeString substringToIndex:self.maxCount];
            }
            //            _theme_Lable.text = [NSString stringWithFormat:@"%lu字",20-textField.text.length];
        }else{ // 有高亮选择的字符串，则暂不对文字进行统计和限制
            return;
            
        }
    }else{ // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
        if (toBeString.length > self.maxCount) {
            textField.text = [toBeString substringToIndex:self.maxCount];
        }
    }
    textField.text = [self disable_emoji:textField.text];
    //    self.context = textField.text;
}

//禁止输入表情
- (NSString *)disable_emoji:(NSString *)text
{
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]" options:NSRegularExpressionCaseInsensitive error:nil];
    NSString *modifiedString = [regex stringByReplacingMatchesInString:text
                                                               options:0
                                                                 range:NSMakeRange(0, [text length])
                                                          withTemplate:@""];
    return modifiedString;
}

#pragma clang diagnostic pop

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    
    NSCharacterSet *cs;
    cs = [[NSCharacterSet characterSetWithCharactersInString:kAlphaNum] invertedSet];
    NSString *filtered =
    [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    BOOL basic = [string isEqualToString:filtered];
    return basic;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{ // called when 'return' key pressed. return NO to ignore.
    [textField resignFirstResponder];
    [self.view endEditing:YES];
    return YES;
    
}
//警告框
- (void)alertViewStr {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:_str1 message:_str2 delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        
    }else{
        
    }
}

@end
