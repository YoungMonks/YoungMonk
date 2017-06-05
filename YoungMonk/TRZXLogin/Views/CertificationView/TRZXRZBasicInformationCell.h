//
//  TRZXRZBasicInformationCell.h
//  TRZXLogin
//
//  Created by 张江威 on 2017/4/19.
//  Copyright © 2017年 张江威. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TRZXRZBasicInformationCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UITextField *informationFeild;
@property (weak, nonatomic) IBOutlet UILabel *numberLab;

@property (nonatomic, strong) NSString *feildStr;
@property (nonatomic,assign)NSInteger maxCount;


@end
