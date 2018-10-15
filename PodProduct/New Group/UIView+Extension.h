//
//  UIView+Extension.h
//  DuoRongApp
//
//  Created by Panda on 16/9/29.
//  Copyright © 2016年 Panda. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface UIView (Extension)
/**
 *  显示提示框 2秒消失
 *
 *  @param message 提示的文字内容
 */
- (void) showTextHud:(NSString *)message;

/**
 *  显示等待读取中
 */
- (void) showLoadingHud;
/**
 *  隐藏等待框
 */
- (void)hideHud;
@end
