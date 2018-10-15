//
//  UIImage+Extension.m
//  DuoRongApp
//
//  Created by Panda on 16/10/8.
//  Copyright © 2016年 Panda. All rights reserved.
//

#import "UIImage+Extension.h"


@implementation UIImage (Extension)
+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}
@end
