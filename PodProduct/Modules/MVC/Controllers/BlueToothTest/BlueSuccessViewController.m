//
//  BlueSuccessViewController.m
//  PodProduct
//
//  Created by wzk on 2018/10/22.
//  Copyright © 2018年 wzk. All rights reserved.
//

#import "BlueSuccessViewController.h"


@interface BlueSuccessViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation BlueSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"发送数据";
}
- (IBAction)selectButtonSend:(id)sender {
    if (self.sendData != nil) {
        self.sendData(self.textView.text);
    }
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
