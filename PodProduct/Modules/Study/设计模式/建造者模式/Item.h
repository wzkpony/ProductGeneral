//
//  Item.h
//  PodProduct
//
//  Created by WZK on 2018/8/20.
//  Copyright © 2018年 wzk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Packing.h"
@protocol Item <NSObject>

- (NSString *)name;
- (Packing *)packing;
- (float)price;
@end
