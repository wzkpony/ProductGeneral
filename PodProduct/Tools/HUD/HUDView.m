//
//  HUDView.m
//  DuoRongApp
//
//  Created by Panda on 16/10/17.
//  Copyright © 2016年 Panda. All rights reserved.
//

#import "HUDView.h"
#import "ConfigHead.h"

@implementation HUDView


+ (void)showToastWith:(NSString *)status{
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setBackgroundColor:UIColorFromRGBAlpha(0x000000, 0.5)];
    [SVProgressHUD setCornerRadius:3];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD setFont:PFFONT(12)];
    [SVProgressHUD setMinimumDismissTimeInterval:100.0];
    [SVProgressHUD showImage:[UIImage imageNamed:@"白色loading"] status:status];
}
+ (void)showToastWith:(NSString *)status allowUserInteractions:(BOOL)allow{
    if (!allow) {
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    }else{
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
    }
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setBackgroundColor:UIColorFromRGBAlpha(0x000000, 0.5)];
    [SVProgressHUD setCornerRadius:3];
    [SVProgressHUD setMinimumDismissTimeInterval:CGFLOAT_MAX];
    [SVProgressHUD setFont:PFFONT(12)];
    [SVProgressHUD showImage:[UIImage imageNamed:@"白色loading"] status:status];
}
+ (void)showWhiteToastWith:(NSString *)status allowUserInteractions:(BOOL)allow{
    if (!allow) {
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    }else{
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
    }
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setBackgroundColor:UIColorFromRGBAlpha(0x000000, 0.5)];
    [SVProgressHUD setCornerRadius:3];
    [SVProgressHUD setMinimumDismissTimeInterval:CGFLOAT_MAX];
    [SVProgressHUD setFont:PFFONT(12)];
    [SVProgressHUD showImage:[UIImage imageNamed:@"白色loading"] status:status];
}

+ (void)showToastAutoDismiss:(NSString *)status{
    
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setBackgroundColor:UIColorFromRGBAlpha(0x000000, 0.5)];
    [SVProgressHUD setCornerRadius:3];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD setFont:PFFONT(12)];
    [SVProgressHUD setMinimumDismissTimeInterval:1.5];
    [SVProgressHUD showImage:[UIImage imageNamed:@"白色loading"] status:status];
}

+ (void)showTip:(NSString *)tip {
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setBackgroundColor:UIColorFromRGBAlpha(0x000000, 0.5)];
    [SVProgressHUD setCornerRadius:3];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD setFont:PFFONT(12)];
    [SVProgressHUD setMinimumDismissTimeInterval:1.5];
    [SVProgressHUD showImage:[UIImage imageNamed:@""] status:tip];
}

+ (void)dismiss_t{
    [SVProgressHUD dismiss];
}



@end
