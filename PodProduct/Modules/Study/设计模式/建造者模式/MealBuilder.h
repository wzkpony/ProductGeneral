//
//  MealBuilder.h
//  PodProduct
//
//  Created by WZK on 2018/8/20.
//  Copyright © 2018年 wzk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Meal.h"
#import "VegBurger.h"
#import "Coke.h"
#import "ChickenBurger.h"
#import "Pepsi.h"
@interface MealBuilder : NSObject
/**<两种套餐>*/
- (Meal *)prepareVegMeal;
- (Meal *)prepareNonVegMeal;
@end
