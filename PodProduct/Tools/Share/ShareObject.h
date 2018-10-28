//
//  ShareObject.h
//  PodProduct
//
//  Created by wzk on 2018/10/26.
//  Copyright © 2018年 wzk. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 配置和参考代码：https://developer.umeng.com/docs/66632/detail/66898
 */
NS_ASSUME_NONNULL_BEGIN

@interface ShareObject : NSObject
+(instancetype)shareShareObject;

- (void)configUSharePlatforms;

- (BOOL)application:(UIApplication *)application url:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation;

@end

NS_ASSUME_NONNULL_END
