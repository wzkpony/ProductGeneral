//
//  AbstractFactory.h
//  PodProduct
//
//  Created by WZK on 2018/8/17.
//  Copyright © 2018年 wzk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Color.h"
#import "Shape.h"
#import "Square.h"
#import "Rectangle.h"
#import "Circle.h"
#import "Red.h"
#import "Green.h"
#import "Blue.h"
/**<抽象类---来获取工厂*/
typedef NS_ENUM(NSInteger,ColorType)
{
    RED = 0,
    GREEN,
    BLUE
};
typedef NS_ENUM(NSInteger,ShapType)
{
    CIRCLE = 0,
    RECTANGLE,
    SQUARE
};
@interface AbstractFactory :NSObject
- (id<Color>)getColor:(ColorType)color;
- (id<Shape>)getShap:(ShapType)shap;
@end
