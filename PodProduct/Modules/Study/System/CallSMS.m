//
//  CallSMS.m
//  PodProduct
//
//  Created by wzk on 2018/3/15.
//  Copyright © 2018年 wzk. All rights reserved.
//

#import "CallSMS.h"

@implementation CallSMS
- (void)callActionWithNumberER:(NSString* )number{
    NSString *num = [[NSString alloc] initWithFormat:@"tel://%@",number]; //number为号码字符串 如果使用这个方法 结束电话之后会进入联系人列表
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:num]]; //拨号
}

- (void)callActionWithNumber:(NSString* )number{
    
    NSString *num = [[NSString alloc] initWithFormat:@"telprompt://%@",number]; //而这个方法则打电话前先弹框  是否打电话 然后打完电话之后回到程序中 网上说这个方法可能不合法 无法通过审核
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:num]]; //拨号
    
}


//  第三种方式打电话



-(void)CallPhoneWithPhoneNum:(NSString* )phoneNum
{
    
    NSURL *phoneURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",phoneNum]];
    
    if ( !phoneCallWebView ) {
        
        phoneCallWebView = [[UIWebView alloc] initWithFrame:CGRectZero];// 这个webView只是一个后台的容易 不需要add到页面上来  效果跟方法二一样 但是这个方法是合法的
        
    }
    
    [phoneCallWebView loadRequest:[NSURLRequest requestWithURL:phoneURL]];
    
}

- (void)smsActionWithNumberER:(NSString* )number{
    NSString *num = [[NSString alloc] initWithFormat:@"sms://%@",number];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:num]];
}

-(void)smsPhoneWithPhoneNum:(NSString* )phoneNum
{
    
    NSURL *phoneURL = [NSURL URLWithString:[NSString stringWithFormat:@"sms:%@",phoneNum]];
    
    if ( !phoneCallWebView ) {
        
        phoneCallWebView = [[UIWebView alloc] initWithFrame:CGRectZero];
        
    }
    
    [phoneCallWebView loadRequest:[NSURLRequest requestWithURL:phoneURL]];
    
}
-(MFMessageComposeViewController*)displaySMSComposerSheetnum:(NSString* )num withROOLneirong:(NSString* )neirong

{
    
    MFMessageComposeViewController *picker = [[MFMessageComposeViewController alloc] init];
    
    picker.messageComposeDelegate = self;
    picker.body=neirong;
    picker.recipients = [NSArray arrayWithObject:num];
    return picker;
    
    
}
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    [controller dismissViewControllerAnimated:YES completion:^{
        
    }];
}

@end
