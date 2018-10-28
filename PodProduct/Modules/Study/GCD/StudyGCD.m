//
//  StudyGCD.m
//  PodProduct
//
//  Created by wzk on 2018/3/7.
//  Copyright © 2018年 wzk. All rights reserved.
//
/*
 UI主线程队列:dispatch_get_main_queue()
 并行队列:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
 串行队列:dispatch_queue_create("minggo.app.com", NULL);
 
 */
#import "StudyGCD.h"

@implementation StudyGCD
//后台执行线程创建
-(void)funcStudyGCD_Dispatch_Async
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        for (int i = 0; i < 100000; i++) {
            if (i == 99999) {
                NSLog(@"dispatch_async(dispatch_get_global_queue) 999");
            }
        }
        
    });
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"dispatch_async(dispatch_get_global_queue)");
    });
    
    
}
//UI线程执行(只是为了测试，长时间加载内容不放在主线程)--虽然是异步线程，但是是在主线程，依然会卡死主线程。
- (void)funcStudyGCDMain
{
    dispatch_async(dispatch_get_main_queue(), ^{
        sleep(5);
        NSLog(@"dispatch_get_main_queue");
    });
}
//执行一次，一般会用于单例的写法
- (void)funcStudyGCDOnce
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        NSLog(@"只执行一次");
    });
}
//循环调用
-(void)funcStudyGCDApply
{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    size_t t = 10;
    dispatch_apply(t, queue, ^(size_t i) {
        NSLog(@"循环次数：%zu",i);
    });
}
//延迟调用--异步调用，虽然在在main线程中，但不会卡死main线程.
- (void)funcStudyGCDDelay
{
    double delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        NSLog(@"延迟加载");
    });
}
//自定义dispatch_queue_t
- (void)funcStudyGCDMyQueue
{
    dispatch_queue_t urls_queue = dispatch_queue_create("wzk", NULL);
    dispatch_async(urls_queue, ^{
        NSLog(@"我的自己，定义的queue");
    });
}


/*
 barrier
 队列必须是自行创建的串行/并行队列，才可以达到顺序执行的效果。注意，用主队列(get_main_queue)还是会阻塞主线程
 */
- (void)funcStudyGCDBarrier
{
    dispatch_queue_t queue = dispatch_queue_create("my", DISPATCH_QUEUE_CONCURRENT);
    dispatch_barrier_async(queue, ^{
        for (int i = 0; i < 100000; i++) {
            if (i == 99999) {
                NSLog(@"barrier1");
            }
        }
        
    });
    dispatch_barrier_async(queue, ^{
        for (int i = 0; i < 10000000; i++) {
            if (i == 9999999) {
                NSLog(@"barrier2");
            }
        }
    });
    dispatch_barrier_async(queue, ^{
        for (int i = 0; i < 1000; i++) {
            if (i == 999) {
                NSLog(@"barrier3");
            }
        }
    });
    dispatch_barrier_async(queue, ^{
        NSLog(@"barrier4");
    });
    NSLog(@"barrier 完成");
}

/*
 dispatch_group
 dispatch_get_global_queue 全局队列，是并行的
 DISPATCH_QUEUE_SERIAL 创建一个串行队列
 DISPATCH_QUEUE_CONCURRENT 创建一个并行队列
 dispatch_get_main_queue 主队列主线程
 
 dispatch_queue_t serialqueue = dispatch_queue_create("serialqueue", DISPATCH_QUEUE_SERIAL);//串行线程队列
 dispatch_queue_t concurrentqueue = dispatch_queue_create("concurrent", DISPATCH_QUEUE_CONCURRENT);//并行线程队列
 
 
 */
- (void)funcStudyGCDGroup
{
    
    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_t gp = dispatch_group_create();
    // ---------------dipatch_group------------
    dispatch_group_async(gp, globalQueue, ^{
//        sleep(2);//会阻塞主线程
        NSLog(@"globalQueue1");
    });
    
    dispatch_group_async(gp, globalQueue, ^{
        //等待线程完成之后调用，在notify之前调用
        //暂停当前线程（阻塞当前线程，但是不会阻塞其他线程和主线程），等待指定的 group 中的任务执行完成后，才会往下继续执行。
        dispatch_group_wait(gp, dispatch_time(DISPATCH_TIME_NOW, 20 * NSEC_PER_SEC));

        NSLog(@"globalQueue2");
    });
    
    dispatch_group_async(gp, globalQueue, ^{
        NSLog(@"globalQueue3");
    });
    
    //group 完成时，会调用
    dispatch_group_notify(gp, globalQueue, ^{
        NSLog(@"globalQueue 已完成");
    });
    
    dispatch_async(globalQueue, ^{
        sleep(1);
        NSLog(@"globalQueue4");
    });
    

}

/*
 来执行中间的内容:dispatch_group_enter(group)、dispatch_group_leave(group)，这来个一般都是成对存在
 dispatch_group_enter：标志着一个任务追加到 group，执行一次，相当于 group 中未执行完毕任务数+1,加入。
 
 dispatch_group_leave：标志着一个任务离开了 group，执行一次，相当于 group 中未执行完毕任务数-1，离开。
 */

- (void)funcGroupEnterAndLeave{
    // 打印当前线程NSLog(@"group---begin");
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0);
    
    
    dispatch_group_enter(group);
    dispatch_async(queue, ^{
        // 追加任务1
//        for(int i =0; i <2; ++i) {
//            [NSThread sleepForTimeInterval:0];
//            // 模拟耗时操作
//            NSLog(@"1---%@",[NSThread currentThread]);
//            // 打印当前线程
//
//        }
        NSLog(@"1111");
        dispatch_group_leave(group);
    });
    
    dispatch_group_enter(group);
    dispatch_async(queue, ^{
        // 追加任务2
//        __weak typeof(self)myself = self;
//        NSTimer *timer = [NSTimer timerWithTimeInterval:1 target:myself selector:@selector(timerFunctionForGCDGroup) userInfo:nil repeats:YES];
//        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
//        dispatch_group_leave(group);
//        [[NSRunLoop currentRunLoop] run];
        
    });
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        // 等前面的异步操作都执行完毕后，回到主线程.
//        for(int i =0; i <2; ++i) {
//            [NSThread sleepForTimeInterval:2];// 模拟耗时操作
//            NSLog(@"3---%@",[NSThread currentThread]);// 打印当前线程}NSLog(@"group---end");
//
//        }
        NSLog(@"%@",@"3333");
    });
    
    // 等待上面的任务全部完成后，会往下继续执行（会阻塞当前线程）//
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);////
    NSLog(@"group---end");
    
}


/*
 Dispatch Semaphore:
 
 
 GCD 中的信号量是指Dispatch Semaphore，是持有计数的信号。类似于过高速路收费站的栏杆。可以通过时，打开栏杆，不可以通过时，关闭栏杆。在Dispatch Semaphore中，使用计数来完成这个功能，计数为0时等待，不可通过。计数为1或大于1时，计数减1且不等待，可通过。
 
 Dispatch Semaphore提供了三个函数。
 
 dispatch_semaphore_create：创建一个Semaphore并初始化信号的总量
 
 dispatch_semaphore_signal：发送一个信号，让信号总量加1
 
 dispatch_semaphore_wait：可以使总信号量减1，当信号总量为0时就会一直等待（阻塞所在线程），否则就可以正常执行。
 */
- (void)funcSemaphoreSync {
    
//    NSLog(@"currentThread---%@",[NSThread currentThread]);
    // 打印当前线程
    NSLog(@"semaphore---begin");
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0);
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    __block int number =0;
    
    // 追加任务1
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:2];// 模拟耗时操作
        number =100;
        NSLog(@"1---%@",semaphore);
        dispatch_semaphore_signal(semaphore);
        NSLog(@"2---%@",semaphore);
        
    });
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    NSLog(@"semaphore---end,number = %zd",number);
    
    /*
     2018-03-08 11:01:42.734639+0800 PodProduct[60086:11900364] semaphore---begin
     2018-03-08 11:01:44.740771+0800 PodProduct[60086:11900399] 1---<OS_dispatch_semaphore: 0x170089010>
     2018-03-08 11:01:44.741182+0800 PodProduct[60086:11900364] semaphore---end,number = 100
     2018-03-08 11:01:44.741275+0800 PodProduct[60086:11900399] 2---<OS_dispatch_semaphore: 0x170089010>
     
     
     创建线程和信号量，在线程中加入异步线程1，代码从上往下执行，线程1和dispatch_semaphore_wait都会执行，当走到dispatch_semaphore_wait时，信号量-1，此时信号量=0，线程等待，当线程1，走到dispatch_semaphore_signal时，信号量+1，此时线程继续执行，输出semaphore---end,number。第一次输出的是：1---<OS_dispatch_semaphore: 0x170089010>。
     
     简单的说，信号量是控制线程是否停止执行的。如果停止，则不再执行，如果信号量突然变成可以执行，则继续原来的代码执行进度，继续执行。
     
     */
    
}

- (void)timerFunctionForGCDGroup
{
    NSLog(@"2222");
}

@end
