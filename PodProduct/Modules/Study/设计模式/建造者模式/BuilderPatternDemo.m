//
//  BuilderPatternDemo.m
//  PodProduct
//
//  Created by WZK on 2018/8/20.
//  Copyright © 2018年 wzk. All rights reserved.
//

#import "BuilderPatternDemo.h"

@implementation BuilderPatternDemo
- (void)test
{
    MealBuilder *mealBuilder =  [[MealBuilder alloc] init];
    
    Meal *vegMeal = [mealBuilder prepareVegMeal];
    NSLog(@"Veg Meal");
    [vegMeal showItems];
    NSLog(@"Total Cost: %f",[vegMeal goCost]);
    
    Meal *nonVegMeal = [mealBuilder prepareNonVegMeal];
    NSLog(@"Non-Veg Meal");
    [nonVegMeal showItems];
    NSLog(@"Total Cost: %f",[nonVegMeal goCost]);
}
@end
