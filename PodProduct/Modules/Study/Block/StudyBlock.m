//
//  StudyBlock.m
//  PodProduct
//
//  Created by wzk on 2018/3/7.
//  Copyright © 2018年 wzk. All rights reserved.
//

#import "StudyBlock.h"
//---------------------单例的写法
/*
 dispatch_once:
 作用：对于某个任务执行一次，且只执行一次。
 参数：第一个参数predicate用来保证执行一次，第二个参数是要执行一次的任务block.
 可以看考；https://www.jianshu.com/p/8c4d0ee1f1bd
 
*/
static StudyBlock* _studyBlock = nil;
@implementation StudyBlock

+(instancetype)shareStudyBlock
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        _studyBlock = [[super allocWithZone:NULL] init];
        [_studyBlock functionBlock];
    });
    return _studyBlock;
}

+(id)allocWithZone:(struct _NSZone *)zone
{
    return [StudyBlock shareStudyBlock];
}

-(id) copyWithZone:(struct _NSZone *)zone
{
    return [StudyBlock shareStudyBlock];
}
//----------------------------------单例End

- (void)functionBlock
{
    
    self.name = @"a";
    __weak StudyBlock *weakSelf = self;
    
    void (^block)(void) = ^{
        
        weakSelf.name = @"b";
        
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
//    NSLog(@"%p---%p--%@",i,&i,i);
    void (^blk)(void) = ^{
        //        i = @"wode";
        NSLog(@"%p---%p--%@",i,&i,i);
    };
//    NSLog(@"%p---%p--%@",i,&i,i);
    blk();
//    NSLog(@"%p---%p--%@",i,&i,i);
    
    
    self.blockTest = ^(NSString* s){
        
//        NSLog(@"对象地址：%p，指针的地址：%p",s,&s);
    };
    
    
    
}

@end
