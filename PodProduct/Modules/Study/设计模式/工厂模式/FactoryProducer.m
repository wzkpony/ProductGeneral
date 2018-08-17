//
//  FactoryProducer.m
//  PodProduct
//
//  Created by WZK on 2018/8/17.
//  Copyright © 2018年 wzk. All rights reserved.
//

#import "FactoryProducer.h"

@implementation FactoryProducer
- (id)getFactory:(ChoiceType)choice
{
    switch (choice) {
        case SHAPE:
        {
            return [ShapeFactory new];
        }
            break;
        case COLOR:
        {
            return [ColorFactory new];
        }
            break;
            
        default:
            break;
    }
    return nil;
}
@end
