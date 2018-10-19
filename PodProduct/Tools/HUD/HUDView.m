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
- (void)showLoadingInView:(UIView *)view{
    CGFloat bgWidth = 80 * SCREEN_RATIO;
    CGFloat rotaeWidth = 40 * SCREEN_RATIO;
    CGFloat loadingLogoImageWidth = 20 * SCREEN_RATIO;
    CGFloat deviation = 5 * SCREEN_RATIO;
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake((KWIDTH - bgWidth) / 2, (view.frame.size.height - bgWidth) / 2, bgWidth, bgWidth)];
    bgView.backgroundColor = RGBACOLOR(0, 0, 0, 0.5);
    bgView.layer.masksToBounds = YES;
    bgView.layer.cornerRadius = 5;
    [self addSubview:bgView];
    
    UIImageView *loadingLogoImageView = [[UIImageView alloc] initWithFrame:CGRectMake((KWIDTH - loadingLogoImageWidth) / 2, (view.frame.size.height - loadingLogoImageWidth) / 2 - deviation, loadingLogoImageWidth, loadingLogoImageWidth)];
    loadingLogoImageView.image = [UIImage imageNamed:@"JRLC.png"];
    [self addSubview:loadingLogoImageView];
    
    UIImageView *rotateImageView = [[UIImageView alloc] initWithFrame:CGRectMake((KWIDTH - rotaeWidth) / 2, (view.frame.size.height - rotaeWidth) / 2 - deviation, rotaeWidth, rotaeWidth)];
    rotateImageView.image = [UIImage imageNamed:@"circle"];
    [self addSubview:rotateImageView];
    
    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, bgWidth - 30, bgWidth, 30)];
    textLabel.text = @"载入中...";
    textLabel.textAlignment = NSTextAlignmentCenter;
    
    textLabel.font = FontTypeAndSize(ArialBoldMT, 12, 1);
    textLabel.textColor = [UIColor whiteColor];
    [bgView addSubview:textLabel];
    
    
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    rotationAnimation.duration = 1;
    rotationAnimation.cumulative = YES;
    rotationAnimation.removedOnCompletion = NO;
    rotationAnimation.fillMode = kCAFillModeForwards;
    rotationAnimation.repeatCount = HUGE_VALF;
    
    [rotateImageView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}
-(CABasicAnimation *)rotation:(float)dur degree:(float)degree direction:(int)direction repeatCount:(int)repeatCount

{
    
    CATransform3D rotationTransform  = CATransform3DMakeRotation(degree, 0, 0,direction);
    
    CABasicAnimation* animation;
    
    animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    
    
    
    animation.toValue= [NSValue valueWithCATransform3D:rotationTransform];
    
    animation.duration= dur;
    
    animation.autoreverses= NO;
    
    animation.cumulative= YES;
    
    animation.removedOnCompletion=NO;
    
    animation.fillMode=kCAFillModeForwards;
    
    animation.repeatCount= repeatCount;
    
//    animation.delegate= self;
    
    return animation;
    
}

/**
 * 动画开始时
 */
- (void)animationDidStart:(CAAnimation *)theAnimation
{
    NSLog(@"begin");
}

/**
 * 动画结束时
 */
- (void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)flag
{
    NSLog(@"end");
}

- (void)showToastWith:(NSString *)status{
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setBackgroundColor:UIColorFromRGBAlpha(0x000000, 0.5)];
    [SVProgressHUD setCornerRadius:3];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD setFont:PFFONT(12)];
    [SVProgressHUD setMinimumDismissTimeInterval:100.0];
    [SVProgressHUD showImage:[UIImage imageNamed:@"白色loading"] status:status];
}
- (void)showToastWith:(NSString *)status allowUserInteractions:(BOOL)allow{
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
- (void)showWhiteToastWith:(NSString *)status allowUserInteractions:(BOOL)allow{
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

- (void)showToastAutoDismiss:(NSString *)status{
    
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setBackgroundColor:UIColorFromRGBAlpha(0x000000, 0.5)];
    [SVProgressHUD setCornerRadius:3];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD setFont:PFFONT(12)];
    [SVProgressHUD setMinimumDismissTimeInterval:1.5];
    [SVProgressHUD showImage:[UIImage imageNamed:@"白色loading"] status:status];
}

- (void)showTip:(NSString *)tip {
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setBackgroundColor:UIColorFromRGBAlpha(0x000000, 0.5)];
    [SVProgressHUD setCornerRadius:3];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD setFont:PFFONT(12)];
    [SVProgressHUD setMinimumDismissTimeInterval:1.5];
    [SVProgressHUD showImage:[UIImage imageNamed:@""] status:tip];
}

- (void)dismiss_t{
    [SVProgressHUD dismiss];
}



@end
