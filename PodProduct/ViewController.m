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
#import "AppDelegate.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    NSNumber *number = [NSNumber numberWithDouble:-1];
    NSLog(@"%@",number.formateCountNum);
    self.label.text = number.formateCountNum;
    AppDelegate* app = (AppDelegate* )[UIApplication sharedApplication].delegate;
    NSMutableString* s = [[NSMutableString alloc] initWithString:@"a"];
    NSLog(@"对象地址：%p，指针指向的地址：%p",s,&s);
    app.blockTest(s);
    NSLog(@"对象地址：%p，指针指向的地址：%p",s,&s);
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
