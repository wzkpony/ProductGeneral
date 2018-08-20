//
//  SingleObject.m
//  PodProduct
//
//  Created by WZK on 2018/8/20.
//  Copyright © 2018年 wzk. All rights reserved.
//

#import "SingleObject.h"
@interface SingleObject()
+(instancetype) alloc __attribute__((unavailable("call sharedInstance instead")));
+(instancetype) new __attribute__((unavailable("call sharedInstance instead")));
-(instancetype) copy __attribute__((unavailable("call sharedInstance instead")));
-(instancetype) mutableCopy __attribute__((unavailable("call sharedInstance instead")));
@end



static  SingleObject *instance;
@implementation SingleObject



+(SingleObject *)shareSingleObject
{
    static dispatch_once_t oneToken;
    
    dispatch_once(&oneToken, ^{
        instance = [[super alloc]init];
    });
    
    return instance;
}

@end
