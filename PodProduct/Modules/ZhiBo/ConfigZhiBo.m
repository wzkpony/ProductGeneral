//
//  ConfigZhiBo.m
//  PodProduct
//
//  Created by wzk on 2018/1/10.
//  Copyright © 2018年 wzk. All rights reserved.
//

#import "ConfigZhiBo.h"

@implementation ConfigZhiBo
+ (void)initZhiBo
{
    NIMSDKOption *option    = [NIMSDKOption optionWithAppKey:@"appKey"];
    //    option.apnsCername      = // APNS 推送证书名
    //    option.pkCername        = //Pushkit 证书名
    [[NIMSDK sharedSDK] registerWithOption:option];
}
- (NSString* )loginGetUserid
{
    [[[NIMSDK sharedSDK] loginManager] login:@"account"
                                       token:@"token"
                                  completion:^(NSError *error) {}];
    NSString *userID = [NIMSDK sharedSDK].loginManager.currentAccount;
    return userID;
}

//APP主动发起自动登录
- (void)autoLogin:(NIMAutoLoginData *)loginData
{
    
}
//和手动登录不同，自动登录通过委托通知登录状态。 APP 需要实现如下回调 (手动登录也会收到同样的委托回调)
- (void)onLogin:(NIMLoginStep)step
{
    
}
//自动登录失败的回调
- (void)onAutoLoginFailed:(NSError *)error
{
    
}
//登出
-(void)logout
{
    [[[NIMSDK sharedSDK] loginManager] logout:^(NSError *error){}];
}


//被踢的回调
-(void)onKick:(NIMKickReason)code
   clientType:(NIMLoginClientType)clientType
{
    
}
//当用户在某个客户端登录时，其他没有被踢掉的端会触发回调:
- (void)onMultiLoginClientsChanged
{
    
}

@end
