//
//  Burger.m
//  PodProduct
//
//  Created by WZK on 2018/8/20.
//  Copyright © 2018年 wzk. All rights reserved.
//

#import "Burger.h"

@implementation Burger

- (instancetype)init
{
    if ([self isMemberOfClass:[Burger class]]) {
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
- (NSString *)name{
    return @"";
}

- (id<Packing>)packing
{
    return [[Wrapper alloc] init];
}


- (float)price{
    return 0;
}
@end
