//
//  HUDView.h
//  DuoRongApp
//
//  Created by Panda on 16/10/17.
//  Copyright © 2016年 Panda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SVProgressHUD.h"
@interface HUDView : UIView
+ (void)showToastWith:(NSString *)status;
+ (void)showToastWith:(NSString *)status allowUserInteractions:(BOOL)allow;
+ (void)showWhiteToastWith:(NSString *)status allowUserInteractions:(BOOL)allow;
+ (void)showToastAutoDismiss:(NSString *)status;
+ (void)showTip:(NSString *)tip;
+ (void)dismiss_t;
@end
