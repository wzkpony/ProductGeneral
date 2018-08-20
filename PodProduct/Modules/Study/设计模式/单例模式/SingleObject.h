//
//  SingleObject.h
//  PodProduct
//
//  Created by WZK on 2018/8/20.
//  Copyright © 2018年 wzk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SingleObject : NSObject
+(SingleObject *)shareSingleObject;



@property (nonatomic,assign)NSInteger index;
@end
