//
//  AppDelegate.m
//  PodProduct
//
//  Created by wzk on 2017/6/12.
//  Copyright © 2017年 wzk. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginModel.h"


@interface AppDelegate ()
{
    
}
@property (nonatomic,copy)NSString* name;

@end

@implementation AppDelegate

void gotoSchool(id self,SEL cmd,id value) {
    printf("go to school");
    
}
//对象在收到无法解读的消息后，首先将调用所属类的该方法。
+ (BOOL)resolveInstanceMethod:(SEL)sel {
    NSString *selectorString = NSStringFromSelector(sel);
    if ([selectorString isEqualToString:@"gotoschool"]) {
        class_addMethod(self, sel, (IMP)gotoSchool, "@@:");
    }
    return [super resolveInstanceMethod:sel];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    NSLog(@"%@ can't handle by People",NSStringFromSelector([anInvocation selector]));
}
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
      NSMethodSignature *sign = [NSMethodSignature signatureWithObjCTypes:"@@:"];
        return sign;
        
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    unsigned int count = 0;
    objc_property_t *propertyList = class_copyPropertyList([LoginModel class], &count);
    for (unsigned int i=0; i<count; i++) {
        const char *propertyName = property_getName(propertyList[i]);
       const char *caicai = property_getAttributes(propertyList[i]);
//        NSLog(@"property----="">%s", caicai);
    }
    const char *name = "name";
    
    NSLog(@"property----="">%@", [NSString stringWithUTF8String:class_getProperty([LoginModel class], name)]);
    
    
    self.name = @"a";
   __weak AppDelegate *appdel = self;
    
    void (^block)(void) = ^{
        
        appdel.name = @"b";
        
    };
    
    block();
    
//    NSLog(@"val = %@", self.name);
    
    /*
     进入block指针就会被拷贝。
     
     __block 修饰：在block一下的代码，都是i都是被拷贝过的指针。对象地址是不变的。知识拷贝了指针
     不用__block修饰：知识block内部的i是被拷贝过的，外部的依然是外部的。
     
     如果block作为成员变量，使用copy或者strong经过检验是一样的，没有发现什么区别。
     */
    NSString* i = @"10";
    NSLog(@"%p---%p--%@",i,&i,i);
    void (^blk)(void) = ^{
//        i = @"wode";
        NSLog(@"%p---%p--%@",i,&i,i);
    };
    NSLog(@"%p---%p--%@",i,&i,i);
    blk();
    NSLog(@"%p---%p--%@",i,&i,i);
    
    
    self.blockTest = ^(NSString* s){
        
        NSLog(@"对象地址：%p，指针的地址：%p",s,&s);
    };
    
    
    
    return YES;
}




- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
