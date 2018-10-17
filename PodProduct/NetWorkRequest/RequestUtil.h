//
//  RequestUtil.h
//  JJShipping
//
//  Created by Mr.Han on 2017/4/25.
//  Copyright © 2017年 Adinnet_Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "AppDelegate.h"


@interface RequestUtil : NSObject
/**<
 testType :用来区分测试环境和生产环境。或者可以说是用来显示和隐藏部分功能。YES就是显示（测试环境），NO就是不显示（隐藏、生产环境）。Debug默认是YES，Release默认是NO。
 隐藏内容：1.待办tab模块、2.工作tab模块中的我的分栏、3.我的模块中“我的绩效”、“我的工资”、“我的文档”。
  */
@property (nonatomic,assign) BOOL testType;
+ (RequestUtil *)manager;

//普通POST请求json提交
+(void)requestPost:(NSString *)action para:(id)params completionBlock:(void(^)(NSInteger statusCode,id errorString, id responseObject ))completionBlock;

//普通POST请求 表单 提交
+(void)requestPostFrom:(NSString *)action para:(id)params completionBlock:(void(^)(NSInteger statusCode,id errorString, id responseObject ))completionBlock;

//附件post请求
+(void)requestPostForFile:(NSString *)action para:(id)params fileArray:(NSArray *)fileArray completionBlock:(void(^)(NSInteger statusCode,id errorString, id responseObject ))completionBlock;
    
//普通Patch请求
+(void)requestPatch:(NSString *)action para:(id)params completionBlock:(void(^)(NSInteger statusCode,id errorString, id responseObject ))completionBlock;
//普通elete请求
+ (void)requestDelete:(NSString *)action para:(id)params completionBlock:(void(^)(NSInteger statusCode,id errorString, id responseObject ))completionBlock;

//多张上传
+(void)requestPostForFiles:(NSString *)action para:(id)params fileArray:(NSArray *)fileArray completionBlock:(void(^)(NSInteger statusCode,id errorString, id responseObject ))completionBlock;
//普通Get请求
+(void)requestGet:(NSString *)action para:(id)params completionBlock:(void(^)(NSInteger statusCode,id errorString, id responseObject ))completionBlock;
//获取web的cookie
+ (void)getTgtBack:(void(^)(void))completionBlock;

//朝彻的接口请求方式
+ (void)sendRequestForZhaoChe:(NSDictionary *)parameters url:(NSString *)urlPath completionBlock:(void(^)(NSInteger statusCode,id errorString, id responseObject ))completionBlock;

//使用NSURLSession 发起一个get请求
+ (void)requestGetURLSession:(NSString *)urlString completionBlock:(void(^)(NSInteger statusCode,id errorString, id responseObject ))completionBlock;

+ (void)saveAuthStr:(NSString *)str;
+ (void)setDataAuth:(BOOL)auth;
+ (NSString *)authStr;
+ (BOOL)dataAuth;
+ (void)delAuthStr;
+ (NSString *)configURL;

+ (NSString *)getCookies;//获取Cookie
@end
