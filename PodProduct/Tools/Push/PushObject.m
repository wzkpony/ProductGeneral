//
//  PushObject.m
//  PodProduct
//
//  Created by wzk on 2018/10/28.
//  Copyright © 2018年 wzk. All rights reserved.
//

#import "PushObject.h"
/*
 配置方式参考：http://docs.jiguang.cn/jpush/client/iOS/ios_guide_new/
 
 
 */
@implementation PushObject
- (void)registerJPushWith:(NSDictionary *)launchOptions {
#if !(TARGET_IPHONE_SIMULATOR)
    if (IOS10_OR_LATER) {
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
        JPUSHRegisterEntity *JPushEntity = [[JPUSHRegisterEntity alloc] init];
        JPushEntity.types = JPAuthorizationOptionAlert | JPAuthorizationOptionBadge | JPAuthorizationOptionSound;
        [JPUSHService registerForRemoteNotificationConfig:JPushEntity delegate:self];
#endif
    } else if (IOS8_OR_LATER) {
        UIMutableUserNotificationCategory *categorys = [[UIMutableUserNotificationCategory alloc] init];
        [JPUSHService registerForRemoteNotificationTypes:UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert categories:[NSSet setWithObject:categorys]];
    }
    
    [JPUSHService setupWithOption:launchOptions appKey:JPUSHAPPKEY channel:@"App Store" apsForProduction:NO];
    [JPUSHService registrationIDCompletionHandler:^(int resCode, NSString *registrationID) {
        if(resCode == 0){
            NSLog(@"registrationID获取成功：%@", registrationID);
        } else {
            NSLog(@"registrationID获取失败：%d", resCode);
        }
    }];
#else
    
    // 在模拟器情况下
    
#endif
    
}

@end
