//
//  ColorFactory.m
//  PodProduct
//
//  Created by WZK on 2018/8/17.
//  Copyright © 2018年 wzk. All rights reserved.
//

#import "ColorFactory.h"

@implementation ColorFactory

- (id<Color>)getColor:(ColorType)color{
    switch (color) {
        case RED:
        {
            return [Red new];
        }
            break;
        case GREEN:
        {
            return [Green new];
        }
            break;
        case BLUE:
        {
            return [Blue new];
        }
            break;
            
        default:
            break;
    }
    return nil;
}
- (id<Shape>)getShap:(ShapType)shap{
 
    return nil;
}

@end
