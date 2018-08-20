//
//  Meal.h
//  PodProduct
//
//  Created by WZK on 2018/8/20.
//  Copyright © 2018年 wzk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Item.h"
/**<
 套餐组装，将素材组装成套餐
 */
@interface Meal : NSObject
@property (nonatomic,strong)NSMutableArray *items;

- (void)addItemsFunc:(id<Item>)item;
- (CGFloat)goCost;
- (void)showItems;
@end
