//
//  RunLoopTime.m
//  PodProduct
//
//  Created by wzk on 2018/4/3.
//  Copyright © 2018年 wzk. All rights reserved.
//

#import "RunLoopTime.h"
/*
 
 RunLoop定义：运行循环。runloop就是处理线程的事件的。管理线程的一种机制。当线程的事件结束时，runloop将会自动休眠，app主线程中的runloop处于抑制唤醒状态。
 
 1  NSRunLoop(线程不安全，对CFRunLoopRef的封装)和CFRunLoopRef(线程安全)
 
 
 
 2 苹果不允许直接创建RunLoop, 它只提供两个自动获取的函数
 
 CFRunLoopGetMain() 和 CFRunLoopGetCurrent()
 
 
 
 线程和RunLoop之间是一一对应的, 其关系是保存在一个全局的Dictionary里
 
 线程刚创建时,并没有RunLoop, 如果你不主动获取, 那么它一直都不会有
 
 RunLoop的创建是发生在第一次获取时, RunLoop的销毁发生在线程结束时. 你只能在一个线程内部获取其RunLoop
 
 
 
 3 一个RunLoop包含若干Mode, 每个Mode又包含若干个Source/Timer/Observer
 
 每次调用RunLoop的主函数时, 只能指定其中一个Mode, 这个Mode被称为CurrentMode. 如果需要切换Mode, 只能退出Loop,在重新指定一个Mode进入
 
 
 runloop
 CFRunLoop的几种模式：
 1.kCFRunLoopDefaultMode，默认模式。
 2.UITrackingRunLoopDefaultMode：界面跟踪Mode，用于scrollView追踪触摸滑动，保证界面滑动时不受其他Mode影响。
 3.UIInitializationRunLoopMode：在刚启动App时的第一个Mode，启动完成后就不再使用。
 4.GSEventReceiveRunLoopMode：接受系统内部事件的Mode，通常用不到。
 5.NSRunLoopCommonMode：这是一个占位用的Mode，不是一种真正的Mode。

 
 定时器默认添加到NSDefaultRunLoopMode中。而当我们滑动UITableView时，RunLoop会切换UITrackingRunLoopDefaultMode，因此定时器失效。
 NSRunLoop的两种模式：
 NSDefaultRunLoopMode：默认的
 NSRunLoopCommonModes：kCFRunLoopDefaultMode和UITrackingRunLoopDefaultMode这两个的封装。

 
 
 运行状态：
 typedef CF_OPTIONS(CFOptionFlags, CFRunLoopActivity) {
 kCFRunLoopEntry        = (1UL << 0), // 即将进入Loop
 kCFRunLoopBeforeTimers  = (1UL << 1), // 即将处理 Timer
 kCFRunLoopBeforeSources = (1UL << 2), // 即将处理 Source
 kCFRunLoopBeforeWaiting = (1UL << 5), // 即将进入休眠
 kCFRunLoopAfterWaiting  = (1UL << 6), // 刚从休眠中唤醒
 kCFRunLoopExit          = (1UL << 7), // 即将退出Loop
 };
 
 运作流程：
 
 

 */
@implementation RunLoopTime
-(void)studyRunloop
{
    NSRunLoop
}
@end
