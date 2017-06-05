//
//  TRZXRZPositionViewController.h
//  TRZXLogin
//
//  Created by 张江威 on 2017/4/21.
//  Copyright © 2017年 张江威. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol positionDelegate <NSObject>

- (void)pushInformation:(NSString *)informationStr;

@end


@interface TRZXRZPositionViewController : UIViewController

@property (nonatomic, weak) id<positionDelegate>delegate;
@property (strong, nonatomic) NSString * titleStr;



@end
