//
//  TRZXCertificationInformationCell.m
//  TRZXLogin
//
//  Created by 张江威 on 2017/4/14.
//  Copyright © 2017年 张江威. All rights reserved.
//

#import "TRZXCertificationInformationCell.h"

@implementation TRZXCertificationInformationCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code

}

-(void)setMode:(TRZXRZIformationMode *)mode{
    if (_mode!=mode) {
        _mode = mode;
        if ([self.titleLabel.text isEqualToString:@"姓名"]) {
            self.zhanshiLabel.text = mode.name;
        } else if ([self.titleLabel.text  isEqualToString:@"性别"]) {
            self.zhanshiLabel.text = mode.sex;
        } else if ([self.titleLabel.text  isEqualToString:@"身份证"]) {
            self.zhanshiLabel.text = mode.idCard;
        } else if ([self.titleLabel.text  isEqualToString:@"公司所在地"]) {
            self.zhanshiLabel.text = mode.city;
        }
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
