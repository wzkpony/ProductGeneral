//
//  StudyGCD.h
//  PodProduct
//
//  Created by wzk on 2018/3/7.
//  Copyright © 2018年 wzk. All rights reserved.
//GCD线程操作，包括线程调度

#import <Foundation/Foundation.h>

@interface StudyGCD : NSObject

/*
 后台执行线程创建
 */
-(void)funcStudyGCD_Dispatch_Async;


/*
 UI线程执行(只是为了测试，长时间加载内容不放在主线程)
 */
- (void)funcStudyGCDMain;

/*
 执行一次，一般会用于单例的写法
 */
- (void)funcStudyGCDOnce;


/*
循环调用
*/
-(void)funcStudyGCDApply;


/*
 延迟调用
 */
- (void)funcStudyGCDDelay;



/*
barrier
*/
- (void)funcStudyGCDBarrier;


/*
 dispatch_group
*/
- (void)funcStudyGCDGroup;


/*
dispatch_group_enter(group)、dispatch_group_leave(group)
*/
- (void)funcGroupEnterAndLeave;


/*
 信号量
 */
- (void)funcSemaphoreSync;


@end
