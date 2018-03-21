//
//  NetworkManage.h
//  DuoRongApp
//  网络请求管理类
//  Created by Panda on 16/9/28.
//  Copyright © 2016年 Panda. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkManage : NSObject
+ (NetworkManage *) shareInstance;
/**
 *  请求方法
 *
 *  @param parameters 请求数据
 *  @param parameters 请求api
 *  @param success    成功回调
 *  @param failure    失败回调
 */
- (void)postWithParameters:(NSDictionary *)parameters
                       api:apiStr
                   success:(void (^)(NSDictionary *responseObject))success
                   failure:(void (^)(NSDictionary *errorObject))failure;

@end
