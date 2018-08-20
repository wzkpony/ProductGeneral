//
//  MealBuilder.m
//  PodProduct
//
//  Created by WZK on 2018/8/20.
//  Copyright © 2018年 wzk. All rights reserved.
//

#import "MealBuilder.h"

@implementation MealBuilder
- (Meal *)prepareVegMeal
{
    //Meal meal = new Meal();
    Meal *meal = [[Meal alloc] init];
    [meal addItemsFunc:[[VegBurger alloc]init]];//素汉堡
    [meal addItemsFunc:[[Coke alloc]init]];//可口可乐
    return meal;
}


- (Meal *)prepareNonVegMeal
{
    Meal *meal = [[Meal alloc] init];
    [meal addItemsFunc:[[ChickenBurger alloc]init]];//香辣鸡腿堡
    [meal addItemsFunc:[[Pepsi alloc]init]];//百事可乐
    return meal;
}
@end
