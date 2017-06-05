//
//  TRZXCertificationInformationCell.h
//  TRZXLogin
//
//  Created by 张江威 on 2017/4/14.
//  Copyright © 2017年 张江威. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TRZXRZIformationMode.h"

@interface TRZXCertificationInformationCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *zhanshiLabel;
@property (weak, nonatomic) IBOutlet UIImageView *yzImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *lineLabel;

@property (nonatomic, strong) TRZXRZIformationMode *mode;
@property (nonatomic, strong) NSArray * titleArr;


@end
