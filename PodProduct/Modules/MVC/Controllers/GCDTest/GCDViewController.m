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

@end

@implementation GCDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    /*
     GCD测试
     */
    StudyGCD *gcd = [[StudyGCD alloc] init];
    [gcd funcStudyGCD_Dispatch_Async];
    [gcd funcStudyGCDMain];
    [gcd funcStudyGCDOnce];
    [gcd funcStudyGCDApply];
    [gcd funcStudyGCDDelay];
    [gcd funcStudyGCDGroup];
    [gcd funcStudyGCDBarrier];
    [gcd funcSemaphoreSync];
    [gcd funcGroupEnterAndLeave];
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
