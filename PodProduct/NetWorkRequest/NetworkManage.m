//
//  NetworkManage.m
//  DuoRongApp
//
//  Created by Panda on 16/9/28.
//  Copyright © 2016年 Panda. All rights reserved.
//

#import "NetworkManage.h"
#import "AFNetworking.h"
#import "RequestHead.h"

@implementation NetworkManage

static NetworkManage *netMsg;
static AFHTTPSessionManager *sessionManager;
+ (NetworkManage *) shareInstance{
    if (netMsg == nil) {
        netMsg = [[NetworkManage alloc] init];
        sessionManager = [AFHTTPSessionManager manager];
        sessionManager.requestSerializer.timeoutInterval = 30;
    }
    return netMsg;
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */
-(NSDictionary* )getPublicDictioary
{
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    [dict setObject:@"1" forKey:@"channel"];
    [dict setObject:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"] forKey:@"version"];
    [dict setObject:@"" forKey:@"token"];

    return dict;
}

- (void)postWithParameters:(NSDictionary *)parameters
                       api:apiStr
                   success:(void (^)(NSDictionary *responseObject))success
                   failure:(void (^)(NSDictionary *errorObject))failure{
    
    NSMutableDictionary *postDict = [NSMutableDictionary dictionaryWithDictionary:parameters];
    
    [postDict addEntriesFromDictionary:[self getPublicDictioary]];
    
    sessionManager.responseSerializer    = [AFHTTPResponseSerializer serializer];
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
                                                                @"text/json",
                                                                @"text/JavaScript",
                                                                @"text/html",
                                                                @"text/plain",
                                                                @"multipart/form-data",
                                                                nil];
    sessionManager.securityPolicy.allowInvalidCertificates = YES;
    sessionManager.securityPolicy.validatesDomainName = NO;
    [sessionManager POST:[NSString stringWithFormat:@"%@%@",BASE_URL,apiStr]
              parameters:postDict
                progress:^(NSProgress * _Nonnull uploadProgress) {
                  
              } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                  NSError *error;
                  NSDictionary *weatherDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:&error];
                  if (success) {
                      success(weatherDic);
                  }
              } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                  NSDictionary *dict = [NSDictionary dictionaryWithObject:error forKey:@"error"];
                  if (failure) {
                      failure(dict);
                  }
              }];
}


- (void)httpsTest{
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    
    //session.securityPolicy.allowInvalidCertificates = YES; // not recommended for production
    
    //session.responseSerializer = [AFJSONResponseSerializer serializer];
    
    //session.requestSerializer = [AFJSONRequestSerializer serializer];
    
    //允许非权威机构颁发的证书
    session.securityPolicy.allowInvalidCertificates = YES;
    session.securityPolicy.validatesDomainName = NO;
    
    
    session.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
                                                         @"text/json",
                                                         @"text/JavaScript",
                                                         @"text/html",
                                                         @"text/plain",
                                                         nil];
    
    [session POST:@"https://v.juhe.cn/toutiao/index"
       parameters:@{@"type":@"top", @"APPKEY":@"fa358e65d107bf2cf886b7332343e4a0"}
         progress:^(NSProgress*_NonnulluploadProgress) {
        
    }success:^(NSURLSessionDataTask* _Nonnulltask, id _Nullable responseObject) {
        
        NSLog(@"sucess = %@",responseObject);
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"https Post成功" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
        
    }failure:^(NSURLSessionDataTask *_Nullable task,NSError *_Nonnull error) {
        
        NSLog(@"error = %@",error);
    }];
    

}
@end
