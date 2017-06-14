//
//  UIImage+Extension.h
//  DuoRongApp
//
//  Created by Panda on 16/10/8.
//  Copyright © 2016年 Panda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)
/**
 *  颜色转为图片
 *
 *  @param color 颜色值
 *
 *  @return 1像素大小的纯色图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color;
@end
