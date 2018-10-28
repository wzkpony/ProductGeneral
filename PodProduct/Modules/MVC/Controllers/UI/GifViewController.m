//
//  GifViewController.m
//  PodProduct
//
//  Created by wzk on 2018/10/25.
//  Copyright © 2018年 wzk. All rights reserved.
//

#import "GifViewController.h"
#import "UIImageView+Gif.h"
@interface GifViewController ()

@end

@implementation GifViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSString  *name = @"deskTop.gif";
    NSString  *filePath = [[NSBundle bundleWithPath:[[NSBundle mainBundle] bundlePath]] pathForResource:name ofType:nil];
    NSData *dataImage = [NSData dataWithContentsOfFile:filePath];
    
    UIImage *image = [UIImage sd_animatedGIFWithData:dataImage];
    self.imageView.image = image;


    
}
- (IBAction)selectButton:(id)sender {
    UIButton *button = (UIButton *)sender;
    if ([button.currentTitle isEqualToString:@"播放"]){
        [self.imageView resumeLayer:self.imageView.layer];
        [button setTitle:@"暂停" forState:UIControlStateNormal];
    }
    else{
        [self.imageView pauseLayer:self.imageView.layer];
        [button setTitle:@"播放" forState:UIControlStateNormal];
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
