//
//  TRZXSetPasswordViewController.h
//  TRZXLogin
//
//  Created by 张江威 on 2017/4/10.
//  Copyright © 2017年 张江威. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TRZXLoginLogic.h"

@interface TRZXSetPasswordViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *yesButton;
@property (weak, nonatomic) IBOutlet UITextField *passwordOneText;
@property (weak, nonatomic) IBOutlet UITextField *PasswordTwoText;

@end
