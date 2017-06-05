//
//  TRZXRetrievePasswordViewController.m
//  TRZXLogin
//
//  Created by 张江威 on 2017/4/10.
//  Copyright © 2017年 张江威. All rights reserved.
//

#import "TRZXRetrievePasswordViewController.h"
#import "TRZXSetPasswordViewController.h"

@interface TRZXRetrievePasswordViewController ()
- (IBAction)nextBtn:(UIButton *)sender;
- (IBAction)verificationBtn:(UIButton *)sender;

@property (nonatomic,assign)NSInteger maxCount;

@end

@implementation TRZXRetrievePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"找回密码";
    [[NSBundle bundleForClass:[self class]] loadNibNamed:@"TRZXRetrievePasswordViewController" owner:self options:nil];
    self.nextButton.layer.cornerRadius =  6;
    self.nextButton.layer.masksToBounds = YES;
    [_photoText addTarget:self action:@selector(textChanged:) forControlEvents:UIControlEventEditingChanged];
    [_verificationText addTarget:self action:@selector(textChanged:) forControlEvents:UIControlEventEditingChanged];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//下一步
- (IBAction)nextBtn:(UIButton *)sender {
    TRZXSetPasswordViewController *viewController = [[TRZXSetPasswordViewController alloc] init];
    [self.navigationController pushViewController: viewController animated:true];
}
//获取验证码
- (IBAction)verificationBtn:(UIButton *)sender {
    
    sender.enabled = NO;
    __block int timeout=59; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [sender setTitle:@"重新发送" forState:UIControlStateNormal];
                sender.titleLabel.font = [UIFont systemFontOfSize:15];
                sender.enabled = YES;
                
                
            });
        } else {
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                [sender setTitle:[NSString stringWithFormat:@"%@s后重新发送",strTime] forState:UIControlStateNormal];
                sender.titleLabel.font = [UIFont systemFontOfSize:15];
                sender.enabled = NO;
            });
            
            timeout--;
        }
    });
    dispatch_resume(timer);
}

#pragma  mark - 文本改变的通知
- (void)textChanged:(UITextField *)textField
{
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"
    if (textField.tag == mobleNB) {
        _maxCount = 11;
    }else if (textField.tag == verificationNB) {
        _maxCount = 4;
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

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([[[textField textInputMode] primaryLanguage] isEqualToString:@"emoji"] || ![[textField textInputMode] primaryLanguage])
    {
        return NO;
    }
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{ // called when 'return' key pressed. return NO to ignore.
    [textField resignFirstResponder];
    [self.view endEditing:YES];
    return YES;
    
}

@end
