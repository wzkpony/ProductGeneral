//
//  RuntimeViewController.m
//  PodProduct
//
//  Created by wzk on 2018/10/19.
//  Copyright © 2018年 wzk. All rights reserved.
//

#import "RuntimeViewController.h"
#import "StudyRunTime.h"
@interface RuntimeViewController ()

@end

@implementation RuntimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"RunTime";
     StudyRunTime* runtime_ = [[StudyRunTime alloc] init];
     [runtime_ gotoSchool];
     [runtime_ funGetAllProperty];
     [runtime_ loadChange];
     [runtime_ functionOne];
     
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
