//
//  TSRouter.m
//  QingLvProject
//
//  Created by Adinnet on 2018/10/12.
//  Copyright © 2018年 Adinnet. All rights reserved.
//

#import "TSRouter.h"

@implementation TSRouter
+ (TSRouter *)shareManager{
    static TSRouter *router=nil;
    static dispatch_once_t oncet;
    dispatch_once(&oncet, ^{
        router=[[self alloc]init];
    });
    return router;
}



@end
