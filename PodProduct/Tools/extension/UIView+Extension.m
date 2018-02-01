//
//  UIView+Extension.m
//  DuoRongApp
//
//  Created by Panda on 16/9/29.
//  Copyright © 2016年 Panda. All rights reserved.
//

#import "UIView+Extension.h"
#import "HUDView.h"
@implementation UIView (Extension)

/**
 *  显示提示框 2秒消失
 *
 *  @param message 提示的文字内容
 */
- (void) showTextHud:(NSString *)message{
   
}

/**
 *  显示等待读取中
 */
- (void) showLoadingHud{
    for (UIView *v in self.subviews) {
        if ([v isKindOfClass:[HUDView class]]) {
            return;
        }
    }
    HUDView *loadingView = [[HUDView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [loadingView showLoadingInView:self];
    [self addSubview:loadingView];
}

/**
 *  隐藏等待框
 */
- (void)hideHud{
    for (UIView *v in self.subviews) {
        if ([v isKindOfClass:[HUDView class]]) {
            [v removeFromSuperview];
        }
    }
}


@end
