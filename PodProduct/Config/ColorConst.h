//
//  ColorConst.h
//  DuoRongApp
//
//  Created by Panda on 16/9/28.
//  Copyright © 2016年 Panda. All rights reserved.
//
#ifndef ColorConst_h
#define ColorConst_h


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



//十六进制
#define UICOLOR_HEX(string) [UIColor colorWithHexString:(string)]

#endif /* ColorConst_h */

