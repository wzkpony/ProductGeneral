//
//  Item.h
//  PodProduct
//
//  Created by WZK on 2018/8/20.
//  Copyright © 2018年 wzk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Packing.h"

/**<将商品（汉堡、可乐）的方法抽象出来。*/

@protocol Item <NSObject>

- (NSString *)name;
- (id<Packing>)packing;
- (float)price;
@end
