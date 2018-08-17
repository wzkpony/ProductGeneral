//
//  StudyRunTime.h
//  PodProduct
//
//  Created by wzk on 2018/3/7.
//  Copyright © 2018年 wzk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoginModel.h"
@interface StudyRunTime : NSObject
//检验消息转发
- (void)gotoSchool;

//过去所有属性list，并且遍历获取属性类型，名称等相关属性信息。
- (void)funGetAllProperty;


/*
 * 方法交换
 */
- (void)loadChange;
- (void)functionOne;


/*
 *
 */
@end
