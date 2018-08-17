//
//  FactoryProducer.h
//  PodProduct
//
//  Created by WZK on 2018/8/17.
//  Copyright © 2018年 wzk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShapeFactory.h"
#import "ColorFactory.h"
/**<工厂创造器/生成器类
 可以根据这个工厂创造出遵循AbstractFactory协议的对象。目前有Shap和Color
 
 
 1.Rectangle、Square、Circle中的draw方法取出来，形成接口在Shape中，
 2.Red、Green、Blue中的fill方法抽取出来，形成接口，在Color中。
 3.ShapeFactory、ColorFactory两个都是工厂，所以可以抽象出来，形成抽象类：AbstractFactory。
 4.FactoryProducer工厂生成器，利用FactoryProducer可以生成对应的工厂。把生成出来的工厂，去生产对应的类，从而来使用生产出来的类。
 
 根据这个思想可以解决：
 例如：1.一个获取联系人的方法，在通讯录模块、创建会议中选择人员中都用到了，可以将获取联系人的方法抽象出来，形成一个接口，然后创建一个类（工厂），用来穿不同的参数获取对应的对象，从而来调用接口。这是一个简单工厂，
     2.在通讯录中都有打电话的需求，此时将打电话的方法，抽取出一个接口，然后创建一个类（工厂），用来选择不同的参数得到对应的类，来打电话。
 
     3.将这两个工厂抽象出来，形成一个抽象类，然后创建一个继承抽象类的子类，用来选择不同的工厂。
 
 
 
 */
typedef NS_ENUM(NSInteger,ChoiceType)
{
    SHAPE = 0,//SHAPE
    COLOR//COLOR
};

@interface FactoryProducer : NSObject

- (id)getFactory:(ChoiceType)choice;

@end
