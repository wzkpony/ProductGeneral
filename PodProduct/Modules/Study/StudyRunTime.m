//
//  StudyRunTime.m
//  PodProduct
//
//  Created by wzk on 2018/3/7.
//  Copyright © 2018年 wzk. All rights reserved.
//

#import "StudyRunTime.h"

@implementation StudyRunTime
/*
 SEL:类成员方法的指针.SEL只是方法编号.
 
 IMP:函数指针，保存了方法地址.
 
 isa指针指向对象所属的类。
 
 someObject叫做接收者(receiver)。
 
 messageName叫做选择器(selector)
 
 选择器和参数合起来成为消息(message)
 
 消息派发系统:接收者类中找到和选择器名字相符的方法，就跳出递归寻找。如果没有找到，则在父类中找，以此类推，直到找到为止，如果都没有找到，就会开始进行消息转发。首先看下所属类，是否能动态添加方法，这个过程叫做“动态方法解析”
 
 
 消息机制原理：对象根据方法编号SEL去映射表查找对应的方法实现。
 
 
 */

#pragma mark -- 消息派送 --
void gotoSchool(id self,SEL cmd,id value) {
    printf("go to school");
    
}
//对象在收到无法解读的消息后，首先将调用所属类的该方法。
+ (BOOL)resolveInstanceMethod:(SEL)sel {
    NSString *selectorString = NSStringFromSelector(sel);
    if ([selectorString isEqualToString:@"gotoSchool"]) {
        //给当前类添加函数
        class_addMethod(self, sel, (IMP)gotoSchool, "@@:");
    }
    return [super resolveInstanceMethod:sel];
}
//当动态方法解析和备援接收者都没有进行处理的话，就会执行
- (void)forwardInvocation:(NSInvocation *)anInvocation {
    NSLog(@"%@ can't handle by People",NSStringFromSelector([anInvocation selector]));
}
/*
 对一个你的对象不识别的消息进行相应，你必须重写methodSignatureForSelector:方法，该方法返回一个NSMethodSIgnature对象，该对象包含了给定选择器所标识方法的描述。主要包含返回值的信息和参数信息
 */
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    NSMethodSignature *sign = [NSMethodSignature signatureWithObjCTypes:"@@:"];
    return sign;
    
}
//获取所有属性list
-(void)funGetAllProperty
{
    unsigned int count = 0;
    objc_property_t *propertyList = class_copyPropertyList([LoginModel class], &count);
    for (unsigned int i = 0; i < count; i++) {
        const char *propertyName = property_getName(propertyList[i]);
        const char *caicai = property_getAttributes(propertyList[i]);
        NSLog(@"property----="">%s", caicai);
    }
    const char *name = "name";
    
    NSLog(@"property----="">%@", [NSString stringWithUTF8String:class_getProperty([LoginModel class], name)]);
}


#pragma mark -- 方法交换 动态加载--
-(void)functionOne
{
    NSLog(@"functionOne");
}

// 加载图片 且 带判断是否加载成功
-(void)functionTwo
{
    //不会死循环，由于交换了两个方法，所以调用ln_imageNamed其实是调用imageNamed。可以作为原方法的扩展
//    [self functionTwo];
    NSLog(@"functionTwo");
}
- (void)loadChange {
    // 1.获取方法地址
    // class_getClassMethod（获取某个类的方法）
    Method imageNamedMethod = class_getInstanceMethod([self class],@selector(functionOne));
    // 2.获取 ln_imageNamed方法地址
    Method ln_imageNamedMethod = class_getInstanceMethod([self class],@selector(functionTwo));
    // 3.交换方法地址，相当于交换实现方式;「method_exchangeImplementations 交换两个方法的实现」
    method_exchangeImplementations(imageNamedMethod, ln_imageNamedMethod);
}

@end
