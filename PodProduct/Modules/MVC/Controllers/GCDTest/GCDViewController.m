//
//  GCDViewController.m
//  PodProduct
//
//  Created by wzk on 2018/10/19.
//  Copyright © 2018年 wzk. All rights reserved.
//

#import "GCDViewController.h"
#import "StudyGCD.h"
@interface GCDViewController ()
@property (nonatomic,strong)NSString *name;
@end

@implementation GCDViewController
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    /**必须invalidate，否则会导致内存泄漏，
     invalidate做了两件事，首先是把本身（定时器）从NSRunLoop中移除，然后就是释放对‘target’对象的强引用
     只有 invalidate了才会释放self，才会调用dealloc，不管是不是__weak，即使是__weak，不invalidate，依然会内存泄漏。
     所以在dealloc中不能invalidate，否则永远不会掉用invalidate。
     */
    [self.timer invalidate];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"GCD";
    /*
     GCD测试
     */
//    StudyGCD *gcd = [[StudyGCD alloc] init];
//    [gcd funcStudyGCD_Dispatch_Async];
//    [gcd funcStudyGCDMain];
//    [gcd funcStudyGCDOnce];
//    [gcd funcStudyGCDApply];
//    [gcd funcStudyGCDDelay];
//    [gcd funcStudyGCDGroup];
//    [gcd funcStudyGCDBarrier];
//    [gcd funcSemaphoreSync];
//    [gcd funcGroupEnterAndLeave];
    
    __weak typeof(self)myself = self;/**使用__weak 没用的，依然会内存泄漏，*/
    self.timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(timerFunctionForGCDGroup) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
//    [[NSRunLoop currentRunLoop] run];
}
- (void)timerFunctionForGCDGroup{
    self.name = @"wzk";
    NSLog(@"timerFunctionForGCDGroup");
}
- (void)dealloc{
    NSLog(@"dealloc");
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
