//
//  TRZXPushLabelCell.m
//  TRZXLogin
//
//  Created by 张江威 on 2017/4/11.
//  Copyright © 2017年 张江威. All rights reserved.
//

#import "TRZXPushLabelCell.h"

@implementation TRZXPushLabelCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.nextLabel.layer.cornerRadius = 6;
    self.nextLabel.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
