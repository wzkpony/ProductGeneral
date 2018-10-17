//
//  SizeConst.h
//  DuoRongApp
//  
//  Created by Panda on 16/9/28.
//  Copyright © 2016年 Panda. All rights reserved.
//

#ifndef SizeConst_h
#define SizeConst_h

//NavBar高度
#define NavigationBar_HEIGHT 44

//获取屏幕 宽度、高度
#define KWIDTH ([UIScreen mainScreen].bounds.size.width)
#define KHEIGHT ([UIScreen mainScreen].bounds.size.height)

#define kNavHeight (kDevice_Is_iPhoneX ? 88 : 64)
#define kStatusBarHeight (kDevice_Is_iPhoneX ? 44 : 20)
#define kTabHeight (kDevice_Is_iPhoneX ? 70 : 49)
#define kDevice_Is_iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)


//适配等比缩放大小
#define SCREEN_RATIO KWIDTH / 320
#define SCREEN_RATIO6 KWIDTH / 375

#endif /* SizeConst_h */
