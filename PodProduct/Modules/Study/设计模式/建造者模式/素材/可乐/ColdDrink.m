//
//  ColdDrink.m
//  PodProduct
//
//  Created by WZK on 2018/8/20.
//  Copyright © 2018年 wzk. All rights reserved.
//

#import "ColdDrink.h"

@implementation ColdDrink
- (instancetype)init
{
    if ([self isMemberOfClass:[ColdDrink class]]) {
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

- (id<Packing>)packing
{
    return [[Bottle alloc] init];
}
- (NSString *)name
{
    return @"";
}
- (float)price{
    return 0;
}
@end
