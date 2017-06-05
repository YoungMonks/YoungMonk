//
//  UIColor+MACProject
//  MACProject
//
//  Created by MacKun on 15/12/14.
//  Copyright © 2015年 MacKun. All rights reserved.
//

#import "UIColor+TRZX.h"



CGFloat colorComponentFrom(NSString *string, NSUInteger start, NSUInteger length) {
    NSString *substring = [string substringWithRange:NSMakeRange(start, length)];
    NSString *fullHex = length == 2 ? substring : [NSString stringWithFormat: @"%@%@", substring, substring];

    unsigned hexComponent;
    [[NSScanner scannerWithString: fullHex] scanHexInt: &hexComponent];
    return hexComponent / 255.0;
}

@implementation UIColor(TRZX)

+(UIColor *)trzx_MainColor{

    return [UIColor trzx_colorWithHexString:@"#323542"];
}
//导航条颜色
+ (UIColor *)trzx_NavigationBarColor{
    return [UIColor trzx_colorWithHexString:@"#FFFFFF"];//#1aa7f2 2da4f6
}

//trzx_蓝色
+ (UIColor *)trzx_BlueColor{
    return [UIColor trzx_colorWithHexString:@"#7687f1"];//099fde
}

//trzx_红色
+ (UIColor *)trzx_RedColor{
    return [UIColor trzx_colorWithHexString:@"#D7000F"];
}

//trzx_黄色
+ (UIColor *)trzx_YellowColor{
    return [UIColor trzx_colorWithHexString:@"#f7ba5b"];
}


//trzx_橙色
+ (UIColor *)trzx_OrangeColor{
    return [UIColor trzx_colorWithHexString:@"#ea6644"];
}

//trzx_绿色
+ (UIColor *)trzx_GreenColor{
    return [UIColor trzx_colorWithHexString:@"#52cbb9"];
}

//trzx_背景色
+ (UIColor *)trzx_BackGroundColor{
    return [UIColor trzx_colorWithHexString:@"#e6e6e6"];
}

//trzx_直线色
+ (UIColor *)trzx_LineColor{
//    return [UIColor colorWithMacHexString:@"#c8c8c8"];
    return [UIColor trzx_colorWithHexString:@"#D6D6D6"];
}
//trzx_导航栏文字颜色
+ (UIColor *)trzx_NavTitleColor{
    return [UIColor trzx_colorWithHexString:@"#525252"];
}
//trzx_标题颜色
+ (UIColor *)trzx_TitleColor{
    return [UIColor trzx_colorWithHexString:@"#474747"];
}

//trzx_文字颜色
+ (UIColor *)trzx_TextColor{
    return [UIColor trzx_colorWithHexString:@"#A0A0A0"];
}

//trzx_浅红颜色
+ (UIColor *)trzx_LightRedColor{
    return [UIColor trzx_colorWithHexString:@"#FFB7C1"];
}

//trzx_输入框颜色
+ (UIColor *)trzx_TextFieldColor{
    return [UIColor trzx_colorWithHexString:@"#FFFFFF"];
}

//trzx_黑色色
+ (UIColor *)trzx_BlackColor{
    return [UIColor trzx_colorWithHexString:@"#333d47" ];
}
/**
 *  trzx_次分割线
 */
+ (UIColor *)trzx_SecondLineColor{
     return [UIColor trzx_colorWithHexString:@"#e5e5e5"];
}


+ (UIColor *)trzx_colorWithHexString:(NSString *)hexString {
    CGFloat alpha, red, blue, green;

    NSString *colorString = [[hexString stringByReplacingOccurrencesOfString:@"#" withString:@""] uppercaseString];
    switch ([colorString length]) {
        case 3: // #RGB
            alpha = 1.0f;
            red   = colorComponentFrom(colorString, 0, 1);
            green = colorComponentFrom(colorString, 1, 1);
            blue  = colorComponentFrom(colorString, 2, 1);
            break;

        case 4: // #ARGB
            alpha = colorComponentFrom(colorString, 0, 1);
            red   = colorComponentFrom(colorString, 1, 1);
            green = colorComponentFrom(colorString, 2, 1);
            blue  = colorComponentFrom(colorString, 3, 1);
            break;

        case 6: // #RRGGBB
            alpha = 1.0f;
            red   = colorComponentFrom(colorString, 0, 2);
            green = colorComponentFrom(colorString, 2, 2);
            blue  = colorComponentFrom(colorString, 4, 2);
            break;

        case 8: // #AARRGGBB
            alpha = colorComponentFrom(colorString, 0, 2);
            red   = colorComponentFrom(colorString, 2, 2);
            green = colorComponentFrom(colorString, 4, 2);
            blue  = colorComponentFrom(colorString, 6, 2);
            break;

        default:
            return nil;
    }
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}




@end



