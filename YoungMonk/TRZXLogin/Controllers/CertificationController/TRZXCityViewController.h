//
//  TRZXCityViewController.h
//  TRZXLogin
//
//  Created by 张江威 on 2017/4/25.
//  Copyright © 2017年 张江威. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol cityDelegate <NSObject>

- (void)pushCity:(NSArray *)cityArr;

@end

@interface TRZXCityViewController : UIViewController

@property (nonatomic, weak) id<cityDelegate>delegate;
@property (strong, nonatomic) NSString * titleStr;

@end
