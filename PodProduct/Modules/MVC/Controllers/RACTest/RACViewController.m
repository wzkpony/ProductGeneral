//
//  RACViewController.m
//  PodProduct
//
//  Created by wzk on 2018/10/19.
//  Copyright © 2018年 wzk. All rights reserved.
//

#import "RACViewController.h"
#import "StudyRACView.h"

@interface RACViewController ()
{
    StudyRACView *_redVeiw;

}
@end

@implementation RACViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
        _redVeiw = [[StudyRACView alloc] initWithFrame:CGRectMake(0, 88, 100, 200)];
        [_redVeiw configView];
}
- (IBAction)selectButtonTest:(id)sender {
    
    /*
     ReactiveCocoa 测试
     */
    [self racTest];
}

-(void)racTest
{
    [self.view addSubview:_redVeiw];
    
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
