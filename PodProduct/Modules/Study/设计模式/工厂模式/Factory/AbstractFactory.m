//
//  AbstractFactory.m
//  PodProduct
//
//  Created by WZK on 2018/8/17.
//  Copyright © 2018年 wzk. All rights reserved.
//

#import "AbstractFactory.h"

@implementation AbstractFactory
- (instancetype)init
{
    /**
     isMemberOfClass:判断一个对象（self）是不是当前类（AbstractFactory）的实例。
     isKindOfClass：判断一个对象（self）是不是当前类（AbstractFactory）、父类、类祖的实例。
     */
    if ([self isMemberOfClass:[AbstractFactory class]]) {
        [self doesNotRecognizeSelector:_cmd];
        return nil;
    }
    else
    {
        self = [super init];
        if (self) {
            return self;
        }
    }
    return nil;
}





@end
