//
//  TRZXCertificationHeadImageCell.m
//  TRZXLogin
//
//  Created by 张江威 on 2017/4/14.
//  Copyright © 2017年 张江威. All rights reserved.
//

#import "TRZXCertificationHeadImageCell.h"

@implementation TRZXCertificationHeadImageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.icmImage.layer.cornerRadius = 30;
    self.icmImage.layer.masksToBounds = YES;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
