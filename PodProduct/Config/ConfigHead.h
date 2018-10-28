//
//  ConfigHead.h
//  PodProduct
//
//  Created by wzk on 2017/6/13.
//  Copyright © 2017年 wzk. All rights reserved.
//

#ifndef ConfigHead_h
#define ConfigHead_h
/**
 * SLLog
 */
#ifdef DEBUG
#define SLLog(fmt, ...) NSLog((@"\n\n函数名：%s 第 %d 行日志：\n" fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define SLLog(...)
#endif



#import "RequestHead.h"
#import "SizeConst.h"
#import "CustomConst.h"
#import "AppKeyConst.h"
#import "PodLibraryHeader.h"
#import "ColorConfig.h"
#import "FontConfig.h"

#import <objc/runtime.h>
#import <objc/message.h>
#import "UIImage+GIF.h"
#import "UIImageView+WebCache.h"
#import "ReactiveObjC.h"
#import "RACReturnSignal.h"
#import <UMShare/UMShare.h>
#import "ShareObject.h"
#endif /* ConfigHead_h */
