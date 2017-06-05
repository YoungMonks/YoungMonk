//
//  TRZXCertificationHomeCell.h
//  TRZXLogin
//
//  Created by 张江威 on 2017/4/11.
//  Copyright © 2017年 张江威. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TRZXCertificationHomeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;

@property (nonatomic, strong) NSIndexPath *index;

@end
