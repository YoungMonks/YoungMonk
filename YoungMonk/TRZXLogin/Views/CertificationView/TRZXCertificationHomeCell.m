//
//  TRZXCertificationHomeCell.m
//  TRZXLogin
//
//  Created by 张江威 on 2017/4/11.
//  Copyright © 2017年 张江威. All rights reserved.
//

#import "TRZXCertificationHomeCell.h"

@implementation TRZXCertificationHomeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Ini(nonatomic) (nonatomic) tialization code
    self.iconImage.layer.cornerRadius = 33;
    self.iconImage.layer.masksToBounds = YES;
    
}
-(void)setIndex:(NSIndexPath *)index{
    if (_index!=index) {
        _index = index;
        if (_index.row == 1) {
            self.titleLabel.text = @"专家";
            self.contentLabel.text = @"专家通过认证可获得讲课、直播、约见股东和回答等功能";
            self.iconImage.image = [UIImage imageNamed:@"图1"];
        }else if (_index.row == 2){
            self.titleLabel.text = @"股东";
            self.contentLabel.text = @"股东通过认证可获得发项目、录制路演、编写商业计划书和提问等功能";
            self.iconImage.image = [UIImage imageNamed:@"图1"];
        }else{
            self.titleLabel.text = @"投资人";
            self.contentLabel.text = @"投资人通过认证可获得平台精准推送匹配项目";
            self.iconImage.image = [UIImage imageNamed:@"图1"];
        }
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
