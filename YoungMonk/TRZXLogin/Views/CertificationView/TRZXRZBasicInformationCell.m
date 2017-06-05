//
//  TRZXRZBasicInformationCell.m
//  TRZXLogin
//
//  Created by 张江威 on 2017/4/19.
//  Copyright © 2017年 张江威. All rights reserved.
//

#import "TRZXRZBasicInformationCell.h"

@implementation TRZXRZBasicInformationCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setFeildStr:(NSString *)feildStr{
    if (_feildStr!=feildStr) {
        _feildStr = feildStr;
        if ([_feildStr isEqualToString:@"姓名"]) {
            _maxCount = 20;
            self.informationFeild.placeholder = @"请填写真实姓名";
        }else if ([_feildStr isEqualToString:@"性别"]){
            self.informationFeild.placeholder = @"请填写性别";
        }else if ([_feildStr isEqualToString:@"身份证"]){
            _maxCount = 18;
            self.numberLab.hidden = YES;
            self.informationFeild.placeholder = @"请填写有效身份证号码";
        }else if ([_feildStr isEqualToString:@"职业"]){
            _maxCount = 20;
            self.informationFeild.placeholder = @"请填写";
        }else if ([_feildStr isEqualToString:@"职位"]){
            _maxCount = 20;
            self.informationFeild.placeholder = @"请填写职位全称";
        }else if ([_feildStr isEqualToString:@"服务行业"]){
            _maxCount = 20;
            self.informationFeild.placeholder = @"请填写";
        }else if ([_feildStr isEqualToString:@"公司名称"]){
            _maxCount = 20;
            self.informationFeild.placeholder = @"请填写";
        }else if ([_feildStr isEqualToString:@"公司所在地"]){
            _maxCount = 20;
            self.informationFeild.placeholder = @"请填写";
        }
        
//        if (self.informationFeild.text.length == 0) {
//            [self.numberLab setHidden:NO];
//        }else{
//            [self.numberLab  setHidden:YES];
//        }
        if (self.informationFeild.text.length <= _maxCount) {
            self.numberLab .text = [NSString stringWithFormat:@"%lu/%lu",_informationFeild.text.length,_maxCount];
        } else {
            self.numberLab .text = [NSString stringWithFormat:@"0/%lu",_maxCount];
            NSString *subText = [_informationFeild.text substringToIndex:_maxCount];
            self.informationFeild.text = subText;
        }
        
        
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
