//
//  ShapeFactory.m
//  PodProduct
//
//  Created by WZK on 2018/8/17.
//  Copyright © 2018年 wzk. All rights reserved.
//

#import "ShapeFactory.h"

@implementation ShapeFactory
- (id<Color>)getColor:(ColorType)color{
    return nil;
}
- (id<Shape>)getShap:(ShapType)shap{
    switch (shap) {
        case CIRCLE:
        {
            return  [Circle new];
        }
            break;
        case RECTANGLE:
        {
            return [Rectangle new];
        }
            break;
        case SQUARE:
        {
            return [Rectangle new];
        }
            break;
            
        default:
            break;
    }
    return nil;
}
@end
