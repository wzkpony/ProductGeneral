//
//  UIImageView+Gif.h
//  PodProduct
//
//  Created by wzk on 2018/10/25.
//  Copyright © 2018年 wzk. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (Gif)
-(void)pauseLayer:(CALayer*)layer;
-(void)resumeLayer:(CALayer*)layer;

@end

NS_ASSUME_NONNULL_END
