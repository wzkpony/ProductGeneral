//
//  BaseNavigationController.m
//  TodayGo
//
//  Created by Felix on 2017/7/16.
//
//

#import "BaseNavigationController.h"
#import <UserNotifications/UserNotifications.h>
#import "AppDelegate.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //设置导航栏背景图片
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"top.png"] forBarMetrics:UIBarMetricsDefault];
    //去掉透明后导航栏下边的黑边
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
//    self.view.backgroundColor = [UIColor whiteColor];
    

}
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count > 0) {
        if ([viewController isKindOfClass:NSClassFromString(@"FiltVC")] ) {
//            viewController.navigationItem.hidesBackButton = YES;
        }else{
            CGFloat width = 44;
            if ([viewController isKindOfClass:NSClassFromString(@"ContactOrganizationVC")]) {
                width = 24;
            }
//            viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(backAction) image:@"返回" highImage:@"返回" btnWidth:width];
        }
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:YES];
}

- (void)backAction{
    [self popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    NSLog(@"%s",__func__);
}




@end
