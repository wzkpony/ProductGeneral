//
//  StudyRAC.m
//  PodProduct
//
//  Created by wzk on 2018/3/16.
//  Copyright © 2018年 wzk. All rights reserved.
//

#import "StudyRAC.h"

@interface StudyRACModel()

@end
@implementation StudyRACModel
- (void)addObserver
{
    /*
     self： 属性的归属者
     userName：属性名称
     newName： 改变过后的新值
     监听UserName的属性
     */
    [RACObserve(self, userName) subscribeNext:^(NSString *newName) {
        NSLog(@"更改名称为：%@", newName);
    }];
    
    /*
     self: 属性的归属者
     userName： 监听的属性
     filter：符合要求的监听
     newName： 改变过后的新值
     
     监听 self.userName 如果时候以w开头的，则subscribeNext获取到消息。否则，不会调用subscribeNext的消息。
     */
    [[RACObserve(self, userName)
      filter:^(NSString *newName) {
          return [newName hasPrefix:@"w"];
      }]
     subscribeNext:^(NSString *newName) {
         NSLog(@"%@", newName);
     }];
    
    
    /*
     接收一个信号数组,当其中任何一个信号发生变化时,从每个信号都会执行
     
     
     // 聚合
     // 常见的用法，（先组合在聚合）。combineLatest:(id<NSFastEnumeration>)signals reduce:(id (^)())reduceBlock
     // reduce中的block简介:
     // reduceblcok中的参数，有多少信号组合，reduceblcok就有多少参数，每个参数就是之前信号发出的内容
     // reduceblcok的返回值：聚合信号之后的内容。
     
     
     */
    RACSignal *reduceSignal = [RACSignal
                                combineLatest:@[ RACObserve(self, password), RACObserve(self, passwordConfirmation) ]
                                reduce:^(NSString *password, NSString *passwordConfirm) {
//                                    return @([passwordConfirm isEqualToString:password]);
                                    return [NSString stringWithFormat:@"%@%@",password,passwordConfirm];
                                }];
    [reduceSignal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
    

}
@end



@interface StudyRACView()

@end
@implementation StudyRACView
-(void)configView
{
    self.backgroundColor = [UIColor redColor];
    self.button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width/2.0, self.frame.size.height/2.0)];
    self.button.backgroundColor = [UIColor blueColor];
    //button点击事件
    self.button.rac_command = [[RACCommand alloc] initWithSignalBlock:^(id _) {
        NSLog(@"button was pressed!");
        return [RACSignal empty];
    }];
    [self addSubview:self.button];
    
    
    RACSubject *subject = [RACSubject subject];//创建信号
    //订阅信号，这个block是一个函数：函数式编程思想（回调）。
    [subject subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
    //发送信号
    [subject sendNext:@"Test"];
}

@end



@interface StudyRACViewModel()

@end
@implementation StudyRACViewModel

@end

