//
//  TRZXRZBasicInformationVC.h
//  TRZXLogin
//
//  Created by 张江威 on 2017/4/19.
//  Copyright © 2017年 张江威. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol informationDelegate <NSObject>

- (void)pushInformation:(NSString *)informationStr;

@end

@interface TRZXRZBasicInformationVC : UIViewController

@property (strong, nonatomic) NSString * titleStr;

@property (strong, nonatomic) NSString * textFieldStr;

@property (nonatomic, weak) id<informationDelegate>delegate;

@end
