//
//  PushObject.h
//  PodProduct
//
//  Created by wzk on 2018/10/28.
//  Copyright © 2018年 wzk. All rights reserved.
//

#import <Foundation/Foundation.h>
// 引入 JPush 功能所需头文件
#import "JPUSHService.h"
// iOS10 注册 APNs 所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max

#import <UserNotifications/UserNotifications.h>

#endif
// 如果需要使用 idfa 功能所需要引入的头文件（可选）
#import <AdSupport/AdSupport.h>


NS_ASSUME_NONNULL_BEGIN

@interface PushObject : NSObject<JPUSHRegisterDelegate>

@end

NS_ASSUME_NONNULL_END
