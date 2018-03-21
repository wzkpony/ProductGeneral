//
//  StudyRACViewModel.m
//  PodProduct
//
//  Created by wzk on 2018/3/21.
//  Copyright © 2018年 wzk. All rights reserved.
//
/*
 基本技术点：
 bind(绑定):绑定一个信号，可以做中间层处理，返回值是信号，当value改变时，就会触发bing的block，执行完毕后，会才会调用订阅的限号。
 map和flattenMap 用于把源信号内容映射成新的内容，都是利用bing的方式，添加代码中间层，对数据中间处理，在订阅返回出操作后的信号。
 map：把源信号的值映射成一个新的值，返回值是一个值。
 flattenMap：把源信号的内容映射成一个新的信号，信号可以是任意类型，返回是RACReturnSignal。
 
 
 其他属性：
 concat:按一定顺序拼接信号，当多个信号发出的时候，有顺序的接收信号。
 then:用于连接两个信号，当第一个信号完成，才会连接then返回的信号。
 
 -----
 merge:把多个信号合并为一个信号，任何一个信号有新值的时候就会调用，把多个信号合并成一个信号(没有顺序)。
 merge：将数组合并成一个新的信号，当数组中的任一一个信号成功时，就会调用block。
 
 combineLatest:将多个信号合并起来，并且拿到各个信号的最新的值,必须每个合并的signal至少都有过一次sendNext，才会触发合并的信号。
 聚合
 combineLatest：将数组合并成一个新的信号，当数组中的所有信号都成功时，才会调用block
 常见的用法，（先组合在聚合）。combineLatest:(id<NSFastEnumeration>)signals reduce:(id (^)())reduceBlock
 reduce中的block简介:
 reduceblcok中的参数，有多少信号组合，reduceblcok就有多少参数，每个参数就是之前信号发出的内容
 reduceblcok的返回值：聚合信号之后的内容。
 -----
 
 zipWith:把两个信号压缩成一个信号，只有当两个信号同时发出信号内容时，并且把两个信号的内容合并成一个元组，才会触发压缩流的next事件::----夫妻关系。
 filter过滤信号，使用它可以获取满足条件的信号。
 ignore:忽略完某些值的信号。
 take:从开始一共取N次的信号。
 takeLast:取最后N次的信号,前提条件，订阅者必须调用完成，因为只有完成，就知道总共有多少信号。
 takeUntil:(RACSignal *):获取信号直到执行完这个信号,只要传入信号发送完成后或者发送任意数据,就不能再接受源信号的内容。
 distinctUntilChanged:当上一次的值和当前的值有明显的变化就会发出信号，否则会被忽略掉。
 skip:(NSUInteger):跳过几个信号,不接受。
 switchToLatest:用于signalOfSignals（信号的信号），有时候信号也会发出信号，会在signalOfSignals中，获取signalOfSignals发送的最新信号。
 doNext: 执行Next之前，会先执行这个Block。
 doCompleted: 执行sendCompleted之前，会先执行这个Block。
 deliverOn: 内容传递切换到制定线程中，副作用在原来线程中,把在创建信号时block中的代码称之为副作用。
 subscribeOn: 内容传递和副作用都会切换到制定线程中。
 timeout：超时，可以让一个信号在一定的时间后，自动报错。
 interval 定时：每隔一段时间发出信号。
 delay 延迟发送next。
 retry重试 ：只要失败，就会重新执行创建信号中的block,直到成功。
 replay重放：当一个信号被多次订阅,反复播放内容。
 throttle节流:当某个信号发送比较频繁时，可以使用节流，在某一段时间不发送信号内容，过了一段时间获取信号的最新内容发出。
 
 
 RACCommand讲解
 RACCommand：是对一个动作的触发以及它产生的后续事件的封装。
 executionSignals:事件执行的结果的回调
 executing:事件执行状态回调
 enabled:动作是否能发生。
 errors:执行失败的回调。
 allowsConcurrentExecution:多次触发这个动作，是否能同时执行。设置为NO，则一个执行完才能继续下一个执行。
 
 
 RACCommand创建表示UI动作的信号。例如，每个信号都可以代表一个按钮，并有与之相关的额外工作。

 self.button.rac_command = [[RACCommand alloc] initWithSignalBlock:^(id _) {
 NSLog(@"button was pressed!");
 return [RACSignal empty];
 }];
 
 
 宏：
 RAC:把一个对象的某个属性绑定一个信号,只要发出信号,就会把信号的内容给对象的属性赋值。例如：RAC(self.label, text) = self.textField.rac_textSignal，给label的text属性绑定了文本框改变的信号，如果textField改变，就会赋给text。
 RACObserve：快速的监听某个对象的某个属性改变，返回的是一个信号,对象的某个属性改变的信号。
 
*/

#import "StudyRACViewModel.h"
#import "StudyRACModel.h"
#import "StudyRACView.h"



@interface StudyRACViewModel()
@property(nonatomic,strong)StudyRACModel* model;
@end
@implementation StudyRACViewModel

-(id)init
{
    if (self = [super init]) {
      
        [self commandRac];
        //创建信号subjectRACView
        self.subjectRACView = [RACSubject subject];
        self.model = [[StudyRACModel alloc] init];
        [self addObserver];
    }
    return self;
}

-(void)changeModel
{
    //监听Model属性的变化，在此处重新复制，会回调到Model中的监听block中
    _model.userName = @"hwzk";
    
    _model.password = @"1234567";
    
    _model.passwordConfirmation = @"1234567";
}
- (void)addObserver
{
    
    /*
     self： 属性的归属者
     userName：属性名称
     newName： 改变过后的新值
     监听UserName的属性
     */
    [RACObserve(_model, userName) subscribeNext:^(NSString *newName) {
        NSLog(@"更改名称为：%@", newName);
    }];
    
    /*
     self: 属性的归属者
     userName： 监听的属性
     filter：符合要求的监听
     newName： 改变过后的新值
     
     监听 self.userName 如果时候以w开头的，则subscribeNext获取到消息。否则，不会调用subscribeNext的消息。
     */
    [[RACObserve(_model, userName)
      filter:^(NSString *newName) {
          return [newName hasPrefix:@"w"];
      }]
     subscribeNext:^(NSString *newName) {
         NSLog(@"%@", newName);
     }];
    
    
    /*
     接收一个信号数组,当其中任何一个信号发生变化时,从每个信号都会执行
     // 聚合
     // combineLatest
     merge：将数组合并成一个新的信号，当数组中的任一一个信号成功时，就会调用block。
     */
    RACSignal *reduceSignal = [RACSignal
                               combineLatest:@[ RACObserve(_model, password), RACObserve(_model, passwordConfirmation) ]
                               reduce:^(NSString *password, NSString *passwordConfirm) {
                                   //return @([passwordConfirm isEqualToString:password]);
                                   return [NSString stringWithFormat:@"%@%@",password,passwordConfirm];
                               }];
    [reduceSignal subscribeNext:^(id _Nullable x) {
        NSLog(@"%@",x);
    }];
    
    
    
    
    
}
#pragma  mark -- 订阅信号和观察方法调用 --
-(void)subscribeSignal
{
    //创建信号
    RACSubject *subject = [RACSubject subject];
    //订阅信号，这个block是一个函数：函数式编程思想（回调）。
    [subject subscribeNext:^(id _Nullable x) {
        NSLog(@"%@",x);
    }];
    //发送信号
    [subject sendNext:@"Test"];
}
#pragma mark -- flattenMap --

//Sequence的初步使用
-(void)SequenceRac
{
    RACSequence * s1 = [@[@(1), @(2), @(3)] rac_sequence];
    
    RACSequence * s2 = [@[@(1), @(3), @(9)] rac_sequence];
    
    RACSequence * s3 = [[@[s1,s2] rac_sequence]flattenMap:^__kindof RACSequence * _Nullable(id _Nullable value) {
        
        return [value filter:^BOOL(id _Nullable value) {
            
            return [value integerValue] % 3 == 0;
            
        }];
        
    }];
    
    NSLog(@"%@",[s3 array]);//打印3、3、9
}
//正确的写法
-(void)flattenMapForMy
{
    //创建信号
    RACSubject* subject = [RACSubject subject];
    //绑定信号
    RACSignal* signal = [subject flattenMap:^__kindof RACSignal * _Nullable(id  _Nullable value) {
        
        value = [NSString stringWithFormat:@"wzk经过flattenMap处理的:%@",value];
        NSLog(@"%@",value);
        return [RACReturnSignal return:value];
    }];
    //订阅信号
    [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"最终处理过的:%@",x);
    }];
    //发送信号 -->会回调绑定信号的block（对数据做了中间处理），然后再回调订阅信号的block（返回最终处理过的x）。
    [subject sendNext:@"signal"];
    
}

/*
 //错误的写法
 -(void)flattenMapError
 {
 RACSubject *subject = [RACSubject subject];
 
 //此flattenMap方法的block不回调用，因为订阅(subscribeNext)的对象不是flattenMap返回的对象，正确的写法如同：flattenMapForMy方法的写法
 [subject flattenMap:^__kindof RACSignal * _Nullable(id  _Nullable value) {
 value = [NSString stringWithFormat:@"数据处理:%@",value];
 return [RACReturnSignal return: value];
 }];
 [subject subscribeNext:^(id  _Nullable x) {
 NSLog(@"最终的：%@",x);
 }];
 [subject sendNext:@"wzk"];
 
 }
 */
#pragma mark -- Map --



-(void)mapForMy
{
    //创建信号
    RACSubject *subject = [RACSubject subject];
    //绑定信号
    RACSignal *signal = [subject map:^id _Nullable(id  _Nullable value) {
        value = [NSString stringWithFormat:@"wzk经过flattenMap处理的:%@",value];
        NSLog(@"%@",value);
        return value;
    }];
    //订阅信号
    [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"最终处理过的:%@",x);
    }];
    //发送信号
    [subject sendNext:@"signal"];
}

//map的使用
-(void)mapForTest:(UIControl *)button
{
    //发送信号
    
    if (button.selected == NO) {
        [self.subjectRACView sendNext:@"signalNO"];
    }
    else
    {
        [self.subjectRACView sendNext:@"signalYES"];
    }
    button.selected = !button.selected;
    
}
#pragma mark -- RACCommand --

//当操作UI层的控件时，loginCommand会接受信号，并执行耗时操作的block，当block执行完毕时，会调用executionSignals的信号。可以改变model等一系列操作，如果model改变，UI监听model或者发送信号，就会做出刷新UI操作，从而显示。
-(void)commandRac
{
   __weak StudyRACViewModel *mySelf = (StudyRACViewModel *)self;
    @weakify(self);
    self.loginCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        //这个假设的登录方法返回一个信号，当网络请求完成时发送一个值。
        @strongify(self)
        NSLog(@"耗时操作");
        [mySelf changeModel];
        
        return [RACSignal empty];
    }];
    
    [self.loginCommand.executionSignals subscribeNext:^(RACSignal *loginSignal) {
        //
        [loginSignal subscribeCompleted:^{
            NSLog(@"Logged in successfully!");
        }];
    }];
}

@end


