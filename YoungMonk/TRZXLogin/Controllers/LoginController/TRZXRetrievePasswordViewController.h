//
//  TRZXRetrievePasswordViewController.h
//  TRZXLogin
//
//  Created by 张江威 on 2017/4/10.
//  Copyright © 2017年 张江威. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TRZXLoginLogic.h"

@interface TRZXRetrievePasswordViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *photoText;
@property (weak, nonatomic) IBOutlet UITextField *verificationText;
@property (weak, nonatomic) IBOutlet UIButton *verificationButton;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;

@end
