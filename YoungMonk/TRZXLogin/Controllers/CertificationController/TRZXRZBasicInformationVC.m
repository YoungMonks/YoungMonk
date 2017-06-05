//
//  TRZXRZBasicInformationVC.m
//  TRZXLogin
//
//  Created by 张江威 on 2017/4/19.
//  Copyright © 2017年 张江威. All rights reserved.
//

#import "TRZXRZBasicInformationVC.h"
#import "TRZXRZBasicInformationCell.h"
#import "TRZXLoginLogic.h"

@interface TRZXRZBasicInformationVC ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView * tableView;
@property (strong, nonatomic) UIButton * rightButton;
@property (strong, nonatomic) UILabel * textFieldLab;

@property (strong, nonatomic) NSString *str1;
@property (strong, nonatomic) NSString *str2;
@property (nonatomic, assign) NSInteger maxCount;

@end

@implementation TRZXRZBasicInformationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = _titleStr;
    [self.view addSubview:self.tableView];
    _textFieldLab = [[UILabel alloc]init];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.rightButton];
}


- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.estimatedRowHeight = 100;
        
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.backgroundColor = backColor;
    }
    return _tableView;
}
-(UIButton *)rightButton{
    _rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 35)];
    [_rightButton setTitle:@"完成" forState:UIControlStateNormal];
    _rightButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [_rightButton setTitleColor:[UIColor colorWithRed:38.0/255.0 green:38.0/255.0 blue:38.0/255.0 alpha:1] forState:UIControlStateNormal];
    [_rightButton addTarget:self action:@selector(pushBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    return _rightButton;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
        return 60;

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        TRZXRZBasicInformationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TRZXRZBasicInformationCell"];
        if (!cell) {
            cell = [[[NSBundle bundleForClass:[self class]] loadNibNamed:@"TRZXRZBasicInformationCell" owner:self options:nil] lastObject];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.informationFeild addTarget:self action:@selector(textChanged:) forControlEvents:UIControlEventEditingChanged];
        cell.informationFeild.text = _textFieldStr;
        _textFieldStr = cell.informationFeild.text;
        cell.numberLab.text = _textFieldLab.text;
        _textFieldLab = cell.numberLab;
        cell.feildStr = _titleStr;
        return cell;
    }else {
        TRZXRZBasicInformationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TRZXRZBasicInformationCell"];
        if (!cell) {
            cell = [[[NSBundle bundleForClass:[self class]] loadNibNamed:@"TRZXCertificationHomeCell" owner:self options:nil] lastObject];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.informationFeild.text = _textFieldStr;
        [cell.informationFeild addTarget:self action:@selector(textChanged:) forControlEvents:UIControlEventEditingChanged];
        cell.feildStr = _titleStr;;
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //行被选中后，自动变回反选状态的方法
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}
//完成事件
- (void)pushBtnClick:(UIButton *)sender{
    if ([_textFieldStr isEqualToString:@""]) {
        _str1 = @"输入信息不能为空";
        _str2 = @"请重新输入";
        [self alertViewStr];
    }else if ([_titleStr isEqualToString:@"身份证"]&&![TRZXLoginLogic isValidateIdentityCard:_textFieldStr]) {
        _str1 = @"身份证号错误";
        _str2 = @"请重新输入";
        [self alertViewStr];
    }else{
        [self popController];
    }
}

//返回传值
- (void)popController{
    [self.delegate pushInformation:_textFieldStr];
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma  mark - 文本改变的通知
- (void)textChanged:(UITextField *)textField
{
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"
    if ([self.titleStr isEqualToString:@"姓名"]) {
        _maxCount = 20;
    } else if ([self.titleStr  isEqualToString:@"身份证"]) {
        _maxCount = 18;
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
        }else{ // 有高亮选择的字符串，则暂不对文字进行统计和限制
            return;
            
        }
    }else{ // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
        if (toBeString.length > self.maxCount) {
            textField.text = [toBeString substringToIndex:self.maxCount];
        }
    }
    _textFieldLab.text = [NSString stringWithFormat:@"%lu/%lu",textField.text.length,_maxCount];
    textField.text = [self disable_emoji:textField.text];
    self.textFieldStr = textField.text;
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
