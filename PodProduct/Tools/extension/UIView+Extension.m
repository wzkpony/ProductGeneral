//
//  UIView+Extension.m
//  DuoRongApp
//
//  Created by Panda on 16/9/29.
//  Copyright © 2016年 Panda. All rights reserved.
//

#import "UIView+Extension.h"
#import "MBProgressHUD.h"
#import "HUDView.h"
@implementation UIView (Extension)

/**
 *  显示提示框 2秒消失
 *
 *  @param message 提示的文字内容
 */
- (void) showTextHud:(NSString *)message{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
    hud.bezelView.backgroundColor = [UIColor colorWithHue:0 saturation:0 brightness:0 alpha:0.8];
    hud.mode = MBProgressHUDModeText;
    hud.label.text = message;
    hud.label.numberOfLines = 0;
    hud.label.textColor = [UIColor whiteColor];
    [hud hideAnimated:YES afterDelay:1.5];
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
