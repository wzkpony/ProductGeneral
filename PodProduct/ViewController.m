//
//  ViewController.m
//  PodProduct
//
//  Created by wzk on 2017/6/12.
//  Copyright © 2017年 wzk. All rights reserved.
//

#import "ViewController.h"
#import "IconFontImageView.h"
#import "ConfigHead.h"
#import "NSNumber+Format.h"
#import "StudyBlock.h"
#import "StudyRunTime.h"
#import "StudyGCD.h"
#import "StudyRACView.h"

#import <MediaPlayer/MediaPlayer.h>
@interface ViewController ()
{
    StudyRACView *_redVeiw;
}
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

//    NSNumber *number = [NSNumber numberWithDouble:-1];
//    NSLog(@"%@",number.formateCountNum);
//    self.label.text = number.formateCountNum;
//
//    for (id laer in [self.label.layer sublayers]) {
//        NSLog(@"%@",laer);
//    }
//
//    _redVeiw = [[StudyRACView alloc] initWithFrame:CGRectMake(0, 88, 100, 200)];
//    [_redVeiw configView];
    
  
    
#pragma mark -- block Test Start--
    /*
    StudyBlock *block = [StudyBlock shareStudyBlock];
    NSMutableString* s = [[NSMutableString alloc] initWithString:@"a"];
//    NSLog(@"对象地址：%p，指针指向的地址：%p",s,&s);
    block.blockTest(s);
//    NSLog(@"对象地址：%p，指针指向的地址：%p",s,&s);
    */
    
#pragma mark -- block Test End --
    

#pragma mark -- runTime Start --
    /*
    StudyRunTime* runtime_ = [[StudyRunTime alloc] init];
    [runtime_ gotoSchool];
    [runtime_ funGetAllProperty];
    [runtime_ loadChange];
    [runtime_ functionOne];
    */
    
    
#pragma mark -- runTime End --
#pragma mark -- GCD --
//    [self selectButtonTest:nil];
#pragma mark -- RAC --
    
#pragma mark --  --
    
}
- (IBAction)selectButtonTest:(id)sender {
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
    
    
    /*
     ReactiveCocoa 测试
     */
    //[self racTest];
}

-(void)racTest
{
    [self.view addSubview:_redVeiw];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
