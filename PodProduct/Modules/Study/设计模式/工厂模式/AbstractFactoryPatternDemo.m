//
//  AbstractFactoryPatternDemo.m
//  PodProduct
//
//  Created by WZK on 2018/8/17.
//  Copyright © 2018年 wzk. All rights reserved.
//

#import "AbstractFactoryPatternDemo.h"

@implementation AbstractFactoryPatternDemo
/**测试ShapeFuntory*/
+ (void)testShapeFuntory
{
    /**<获取SHAPE抽象工程的实例*/
    ShapeFactory *shapeFactory = [[FactoryProducer new] getFactory:SHAPE];
    /**<获取CIRCLE对象，并调用方法*/
    Circle *circle = [shapeFactory getShap:CIRCLE];
    [circle draw];
    /**<获取RECTANGLE对象，并调用方法*/
    Rectangle *rectangle = [shapeFactory getShap:RECTANGLE];
    [rectangle draw];
    /**<获取SQUARE对象，并调用方法*/
    Square *square = [shapeFactory getShap:SQUARE];
    [square draw];

}
/**测试ColorFuntory*/
+ (void)testColorFuntory
{
    /**<获取COLOR抽象工程的实例*/
    ColorFactory *colorFactory = [[FactoryProducer new] getFactory:COLOR];
    /**<获取RED对象，并调用方法*/
    id<Color> red = [colorFactory getColor:RED];
    [red fill];
    /**<获取GREEN对象，并调用方法*/
    id<Color> green = [colorFactory getColor:GREEN];
    [green fill];
    /**<获取BLUE对象，并调用方法*/
    id<Color> blue = [colorFactory getColor:BLUE];
    [blue fill];
  
}
@end
