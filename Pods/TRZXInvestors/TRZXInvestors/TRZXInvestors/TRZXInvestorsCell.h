//
//  InvestorListTableViewCell.h
//  TRZX
//
//  Created by 移动微 on 16/10/8.
//  Copyright © 2016年 Tiancaila. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TRZXInvestors.h"
static NSString *kCellIdentifier_TRZXInvestorsCell = @"TRZXInvestorsCell";

@interface TRZXInvestorsCell : UITableViewCell


@property(nonatomic,strong)TRZXInvestors *model;

@end
