//
//  ColorConfig.h
//  PodProduct
//
//  Created by wzk on 2018/1/16.
//  Copyright © 2018年 wzk. All rights reserved.
//

#import <Foundation/Foundation.h>

// rgb颜色转换（16进制->10进制）
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


//主题字体颜色-黑色
#define BACKGROUND_COLOR [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1.0]

//主题背景颜色-白色
#define BACKGROUND_COLOR [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0]

//清除背景色
#define CLEARCOLOR [UIColor clearColor]

//RGB的设置颜色
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

#define kFontGray UIColorFromRGB(0x8E8E93)


//十六进制
#define UICOLOR_HEX(string) [UIColor colorWithHexString:(string)]


//默认字体:平方体
#define PFFONT(font) [UIFont fontWithName:@"PingFangSC-Regular" size:font]
#define PFMFONT(font) [UIFont fontWithName:@"PingFangSC-Medium" size:font]
#define PFLFONT(font) [UIFont fontWithName:@"PingFangSC-Light" size:font]
#define PFBFONT(font) [UIFont fontWithName:@"PingFangSC-Bold" size:font]
#define PFSFONT(font) [UIFont fontWithName:@"PingFangSC-Semibold" size:font]






@interface ColorConfig : NSObject

@end
