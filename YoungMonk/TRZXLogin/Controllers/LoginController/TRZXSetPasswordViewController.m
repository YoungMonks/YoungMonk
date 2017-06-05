//
//  TRZXSetPasswordViewController.m
//  TRZXLogin
//
//  Created by 张江威 on 2017/4/10.
//  Copyright © 2017年 张江威. All rights reserved.
//

#import "TRZXSetPasswordViewController.h"

@interface TRZXSetPasswordViewController ()

@property (nonatomic,assign)NSInteger maxCount;
- (IBAction)pushBtn:(UIButton *)sender;
@property (strong, nonatomic) NSString * alertTitle;

@end

@implementation TRZXSetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置密码";
    [[NSBundle bundleForClass:[self class]] loadNibNamed:@"TRZXSetPasswordViewController" owner:self options:nil];
    self.yesButton.layer.cornerRadius =  6;
    self.yesButton.layer.masksToBounds = YES;
    [_passwordOneText addTarget:self action:@selector(textChanged:) forControlEvents:UIControlEventEditingChanged];
    [_PasswordTwoText addTarget:self action:@selector(textChanged:) forControlEvents:UIControlEventEditingChanged];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma  mark - 文本改变的通知
- (void)textChanged:(UITextField *)textField
{
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"
    if (textField.tag == passwordOneNB) {
        _maxCount = 20;
    }else if (textField.tag == passwordTwoNB) {
        _maxCount = 20;
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


- (IBAction)pushBtn:(UIButton *)sender {
    if ([_passwordOneText.text isEqualToString:_PasswordTwoText.text]) {
        
    }else{
        _alertTitle = @"两次密码需要一致";
        [self alertViewStr];
    }
}
//警告框
- (void)alertViewStr {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:_alertTitle message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        
    }else{
        
    }
}

@end
