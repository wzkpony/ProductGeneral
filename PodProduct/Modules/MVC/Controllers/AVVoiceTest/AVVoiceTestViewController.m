//
//  AVVoiceTestViewController.m
//  PodProduct
//
//  Created by wzk on 2018/10/23.
//  Copyright © 2018年 wzk. All rights reserved.
//

#import "AVVoiceTestViewController.h"
#import "SpeechString.h"
@interface AVVoiceTestViewController (){
}
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation AVVoiceTestViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[SpeechString sharedSpeech] stopTimer];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

}
- (IBAction)sendAVVoice:(id)sender {
    [[SpeechString sharedSpeech] speechSynthesizerString:self.textField.text langeuage:@"" rate:0 duration:1*60];
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
