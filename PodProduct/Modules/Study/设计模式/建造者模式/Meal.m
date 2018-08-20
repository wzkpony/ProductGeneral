//
//  Meal.m
//  PodProduct
//
//  Created by WZK on 2018/8/20.
//  Copyright © 2018年 wzk. All rights reserved.
//

#import "Meal.h"

@implementation Meal
- (void)addItemsFunc:(id<Item>)item
{
    if (self.items == nil) {
        self.items = [[NSMutableArray alloc] init];
    }
    [self.items addObject:item];
}
- (CGFloat)goCost{
    CGFloat cost = 0;
    for (id<Item>item in self.items) {
        cost += item.price;
    }
    return cost;
}
- (void)showItems
{
    for (id<Item> item in self.items) {
        NSLog(@"Item :%@",item.name);
        NSLog(@"Packing : %@",item.packing);
        NSLog(@"Price :%f",item.price);
    }
}
@end
