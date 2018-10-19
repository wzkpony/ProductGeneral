//
//  BlockViewController.m
//  PodProduct
//
//  Created by wzk on 2018/10/19.
//  Copyright © 2018年 wzk. All rights reserved.
//

#import "BlockViewController.h"
#import "StudyBlock.h"
@interface BlockViewController ()

@end

@implementation BlockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
     StudyBlock *block = [StudyBlock shareStudyBlock];
     NSMutableString* s = [[NSMutableString alloc] initWithString:@"a"];
     NSLog(@"对象地址：%p，指针指向的地址：%p",s,&s);
     block.blockTest(s);
     NSLog(@"对象地址：%p，指针指向的地址：%p",s,&s);
    
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
