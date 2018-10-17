//
//  RequestUtil.m
//  JJShipping
//
//  Created by Mr.Han on 2017/4/25.
//  Copyright © 2017年 Adinnet_Mac. All rights reserved.
//

#import "RequestUtil.h"

@implementation RequestUtil
+ (nullable RequestUtil *)manager{
    static dispatch_once_t once;
    static id instance;
    dispatch_once(&once, ^{
        instance = [self new];
    });
    return instance;
}

#warning 开发环境设置默认值为 YES,省的切来切去
#ifdef DEBUG
- (BOOL)testType
{
    return YES;
}
#endif


+ (NSString *)configURL
{
    if ([RequestUtil manager].testType == YES) {
        return @"";
    }
    else
    {
        return @"";
    }
}

//普通POST请求 json 提交
+(void)requestPost:(NSString *)action para:(id)params completionBlock:(void(^)(NSInteger statusCode,id errorString, id responseObject ))completionBlock{
    if ([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus==0){
        [self dismiss_t];
        [MHTToast showCenterWithText:@"网络连接失败,请检查您的网络"];
        completionBlock(0,nil,nil);
        return;
    }
    //拼接url
    NSString *url = [NSString stringWithFormat:@"%@%@",[self configURL],action];
    //
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    if ([url containsString:@"api/workflow/saveWrokFlow"]) {
//        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
//    }
//    else{
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
//    }
    manager.requestSerializer.timeoutInterval = 30;
    [manager.requestSerializer setValue:[self authStr] forHTTPHeaderField:@"Authorization"];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"image/jpeg",@"image/png",@"text/plain",@"application/json",@"text/json",nil];
    
    
    [manager POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {} success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
        
        @try {
            completionBlock(response.statusCode,nil,dic);
        } @catch (NSException *exception) {
            NSLog(@"接口解析报错了!!! crash ------- action: %@, reason : %@",action,exception.description);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        @try {
            NSDictionary *userInfo = error.userInfo;
            if (userInfo[@"com.alamofire.serialization.response.error.data"] != nil) {
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:userInfo[@"com.alamofire.serialization.response.error.data"] options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
                if (dic != nil) {
                    [MHTToast showCenterWithText:dic[@"message"]];
                }

            }
        } @catch (NSException *exception) {
            NSLog(@"请求失败解析报错了!!! crash ------- action: %@, reason : %@",action,exception.description);
        }
        NSInteger statusCode = [response statusCode];
        if (statusCode==403) {
            [self dismiss_t];
            [self reLogin];
            return ;
        }
//        [self dismiss_t];
        NSLog(@"请求失败 url = %@\nerror = %@",url,error.description);
        completionBlock(statusCode,error.description,nil);
    }];

    
}

//普通Get请求
+(void)requestGet:(NSString *)action para:(id)params completionBlock:(void(^)(NSInteger statusCode,id errorString, id responseObject ))completionBlock{
    if ([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus==0){
        [self dismiss_t];
        [MHTToast showCenterWithText:@"网络连接失败,请检查您的网络"];
        completionBlock(0,@"网络连接失败,请检查您的网络",nil);
        return;
    }
    NSString *url = [NSString stringWithFormat:@"%@%@",[self configURL],action];
    // 初始化Manager
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.requestSerializer.timeoutInterval = 30;
    [manager.requestSerializer setValue:[self authStr] forHTTPHeaderField:@"Authorization"];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"image/jpeg",@"image/png",@"text/plain",@"application/json",nil];
    
    [manager GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        NSInteger statusCode = [response statusCode];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
        if (dic == nil) {
            dic = @{};
        }
        completionBlock(statusCode,nil,dic);
     
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        NSDictionary *userInfo = error.userInfo;
        if (userInfo[@"com.alamofire.serialization.response.error.data"] != nil) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:userInfo[@"com.alamofire.serialization.response.error.data"] options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
            if (dic != nil) {
                [MHTToast showCenterWithText:dic[@"message"]];
            }
        }
        
        NSInteger statusCode = [response statusCode];
        if (statusCode==403) {
            [self dismiss_t];
            [self reLogin];
            return ;
        }
//        [self dismiss_t];
        NSLog(@"请求失败 url = %@\nerror = %@",url,error.description);
        completionBlock(statusCode,error.description,nil);
    }];
}

//普通Patch请求
+(void)requestPatch:(NSString *)action para:(id)params completionBlock:(void(^)(NSInteger statusCode,id errorString, id responseObject ))completionBlock{
    if ([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus==0){
        [self dismiss_t];
        [MHTToast showCenterWithText:@"网络连接失败,请检查您的网络"];
        completionBlock(0,@"网络连接失败,请检查您的网络",nil);
        return;
    }
    NSString *url = [NSString stringWithFormat:@"%@%@",[self configURL],action];
    // 初始化Manager
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.requestSerializer.timeoutInterval = 30;
    [manager.requestSerializer setValue:[self authStr] forHTTPHeaderField:@"Authorization"];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"image/jpeg",@"image/png",@"text/plain",@"application/json",nil];
    [manager PATCH:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
        
        @try {
            completionBlock(response.statusCode,nil,dic);
        } @catch (NSException *exception) {
            NSLog(@"接口解析报错了!!! crash ------- action: %@, reason : %@",action,exception.description);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        @try {
            NSDictionary *userInfo = error.userInfo;
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:userInfo[@"com.alamofire.serialization.response.error.data"] options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
            [MHTToast showCenterWithText:dic[@"message"]];
        } @catch (NSException *exception) {
            NSLog(@"请求失败解析报错了!!! crash ------- action: %@, reason : %@",action,exception.description);
        }
        NSInteger statusCode = [response statusCode];
        if (statusCode==403) {
            [self dismiss_t];
            [self reLogin];
            return ;
        }
//        [self dismiss_t];
        NSLog(@"请求失败 url = %@\nerror = %@",url,error.description);
        completionBlock(statusCode,error.description,nil);
    }];
}


//普通Delete请求
+ (void)requestDelete:(NSString *)action para:(id)params completionBlock:(void(^)(NSInteger statusCode,id errorString, id responseObject ))completionBlock {
    
    if ([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus==0){
        [self dismiss_t];
        [MHTToast showCenterWithText:@"网络连接失败,请检查您的网络"];
        completionBlock(0,@"网络连接失败,请检查您的网络",nil);
        return;
    }
    NSString *url = [NSString stringWithFormat:@"%@%@",[self configURL],action];
    // 初始化Manager
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.requestSerializer.timeoutInterval = 30;
    [manager.requestSerializer setValue:[self authStr] forHTTPHeaderField:@"Authorization"];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"image/jpeg",@"image/png",@"text/plain",@"application/json",nil];
    
    
    [manager DELETE:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
        
        @try {
            completionBlock(response.statusCode,nil,dic);
        } @catch (NSException *exception) {
            NSLog(@"接口解析报错了!!! crash ------- action: %@, reason : %@",action,exception.description);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        @try {
            NSDictionary *userInfo = error.userInfo;
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:userInfo[@"com.alamofire.serialization.response.error.data"] options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
            [MHTToast showCenterWithText:dic[@"message"]];
        } @catch (NSException *exception) {
            NSLog(@"请求失败解析报错了!!! crash ------- action: %@, reason : %@",action,exception.description);
        }
        NSInteger statusCode = [response statusCode];
        if (statusCode==403) {
            [self dismiss_t];
            [self reLogin];
            return ;
        }
        //        [self dismiss_t];
        NSLog(@"请求失败 url = %@\nerror = %@",url,error.description);
        completionBlock(statusCode,error.description,nil);
    }];    
}


+(void)requestPostForFiles:(NSString *)action para:(id)params fileArray:(NSArray *)fileArray completionBlock:(void(^)(NSInteger statusCode,id errorString, id responseObject ))completionBlock{
    if ([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus==0){
        [MHTToast showCenterWithText:@"网络连接失败,请检查您的网络"];
        return;
    }
    NSString *url = [NSString stringWithFormat:@"%@%@",[self configURL],action];
    //
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.requestSerializer.timeoutInterval = 60;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"image/jpeg",@"image/png",@"text/plain",@"application/json",@"text/json",nil];
    
    NSDictionary *temp = (NSDictionary *)params;
    
    //*****构造参数
    NSMutableDictionary *paramM = temp.mutableCopy;
    BOOL needManageToast;
    if ([[paramM allKeys]containsObject:@"noToast"]) {
        needManageToast = NO;
        [paramM removeObjectForKey:@"noToast"];
    }else{
        needManageToast = YES;
    }
    if (needManageToast) {
        [SVProgressHUD showWithStatus:@"加载中"];
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    }
    
//    BOOL isLogin = [XZZUserManager isLogin];
//    if (isLogin) {
//        [paramM setValue:[XZZUserManager manager].user.mkey forKey:@"mkey"];
//    }
    [paramM setValue:[self getTheCurrentTimestamp] forKey:@"ts"];
    if ([[paramM allKeys]containsObject:@"auth"]) {
        NSString *auth = paramM[@"auth"];
        if ([auth isEqualToString:@"guest"]) {
            [paramM removeObjectForKey:@"auth"];
            [paramM removeObjectForKey:@"mkey"];
        }
    }
    
    
    
    
    
    [manager POST:url parameters:paramM constructingBodyWithBlock:^(id  _Nonnull formData) {
        // 拼接data到请求体，这个block的参数是遵守AFMultipartFormData协议的。
        for (int i = 0; i < fileArray.count; i++) {
            UIImage *image = fileArray[i];
            NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
            // 在网络开发中，上传文件时，是文件不允许被覆盖，文件重名
            // 要解决此问题，
            // 可以在上传时使用当前的系统事件作为文件名
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            // 设置时间格式
            [formatter setDateFormat:@"yyyyMMddHHmmss"];
            NSString *dateString = [formatter stringFromDate:[NSDate date]];
            NSString *fileName = [NSString  stringWithFormat:@"%@.jpg", dateString];
            /*
             *该方法的参数
             1. appendPartWithFileData：要上传的照片[二进制流]
             2. name：对应网站上[upload.php中]处理文件的字段（比如upload）
             3. fileName：要保存在服务器上的文件名
             4. mimeType：上传的文件的类型
             */
//            if ([action isEqualToString:@"m/uploadCertificate"]) {
                [formData appendPartWithFileData:imageData name:[NSString stringWithFormat:@"file%d",i] fileName:fileName mimeType:@"image/jpeg"];
//            }else{
//                [formData appendPartWithFileData:imageData name:@"order_delivery_img" fileName:fileName mimeType:@"image/jpeg"];
//            }
            //
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        // 这里可以获取到目前的数据请求的进度
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (needManageToast) [SVProgressHUD dismiss];
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
        NSInteger code = [dic[@"code"] integerValue];
        NSString *message = [NSString stringWithFormat:@"%@",dic[@"message"]];
        @try {
            if (code==1) {
                completionBlock(code,message,dic);
            }else{
                [MHTToast showCenterWithText:message];
                completionBlock(code,message,nil);
            }
        } @catch (NSException *exception) {
            NSLog(@"接口解析报错了!!! crash ------- action: %@, reason : %@",action,exception.description);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (needManageToast) [SVProgressHUD dismiss];
        // 请求失败
        NSLog(@"%@", [error localizedDescription]);
        [MHTToast showCenterWithText:[error localizedDescription]];
    }];
}
+(void)requestPostForFile:(NSString *)action para:(id)params fileArray:(NSArray *)fileArray completionBlock:(void(^)(NSInteger statusCode,id errorString, id responseObject ))completionBlock{
    if ([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus==0){
        [MHTToast showCenterWithText:@"网络连接失败,请检查您的网络"];
        return;
    }
    NSString *url = [NSString stringWithFormat:@"%@%@",[self configURL],action];
    // 初始化Manager
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 不加上这句话，会报“Request failed: unacceptable content-type: text/plain”错误，因为我们要获取text/plain类型数据
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"image/jpeg",@"image/png",@"text/plain",@"application/json",nil];
   
    // post请求
    [SVProgressHUD showWithStatus:@"加载中"];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
    [manager POST:url parameters:params constructingBodyWithBlock:^(id  _Nonnull formData) {
        // 拼接data到请求体，这个block的参数是遵守AFMultipartFormData协议的。
        if(fileArray !=nil&&fileArray.count>0){
            NSInteger count = fileArray.count;
            for(int i=0;i<count;i++){
                id tmpFileData =[fileArray objectAtIndex:i];
                NSData *fileData;
                if ([tmpFileData isKindOfClass:[NSData class]]) {
                    fileData = tmpFileData;
                }else if([tmpFileData isKindOfClass:[NSString class]]){
                    NSString *filePathStr = tmpFileData;
                    fileData = [NSData dataWithContentsOfFile:filePathStr];
                }else if([tmpFileData isKindOfClass:[NSURL class]]){
                    fileData =[NSData dataWithContentsOfURL:tmpFileData];
                }
                //目前仅支持单张图片上传
                [formData appendPartWithFileData:fileData name:@"Filedata" fileName:@"myFile.jpg" mimeType:@"image/jpeg"];
                
            }
            [params setObject:@{@"Filedata":formData} forKey:@"body"];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        // 这里可以获取到目前的数据请求的进度
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
        NSInteger code = [dic[@"code"] integerValue];
        NSString *message = [NSString stringWithFormat:@"%@",dic[@"message"]];
        if (code==3000) {
            completionBlock(code,nil,dic);
        }else{
            completionBlock(code,message,dic);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        NSLog(@"---%@",response.allHeaderFields);
        NSLog(@"error ==%@", [[error userInfo] objectForKey:@"com.alamofire.serialization.response.error.string"]);
        NSLog(@"%@", [error localizedDescription]);
        [MHTToast showCenterWithText:[error localizedDescription]];
    }];
}

+ (void)getTgtBack:(void(^)(void))completionBlock{
    NSString *urlString = [NSString stringWithFormat:@"%@/sso/api/login",DefineZhaoCheUrl];
    XZZUser *user = [XZZUserManager manager].user;
    NSDictionary *parameters = @{@"username":user.mobile?user.mobile:@"",
                                 @"password":user.password?user.password:@"",
                                 @"service":@"http://dubhe.zhaochewisdom.com/"};
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.requestSerializer.timeoutInterval = 30;
    [manager.requestSerializer setValue:@"5a9cb35668d85500019e5bf17071320863b7470996a76b69f807c598" forHTTPHeaderField:@"ZC-Authorization"];
    //            [manager.requestSerializer setValue:[RequestUtil authStr] forHTTPHeaderField:@"ZC-Authorization"];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"image/jpeg",@"image/png",@"text/plain",@"application/json",@"text/json",nil];
    
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //                NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
        if ([dic[@"code"] integerValue] != 0) {
            [MHTToast showCenterWithText:[NSString stringWithFormat:@"用户中心登录失败 = > %@",dic[@"msg"]]];
            NSLog(@"用户中心登录失败 = > %@",dic[@"msg"]);
        }else{
            NSDictionary *userData = dic[@"results"];
            [[NSUserDefaults standardUserDefaults]setObject:userData forKey:DefineUserDataKey];
            [[NSUserDefaults standardUserDefaults]synchronize];
        }
        
        NSDictionary *cookie = [[NSUserDefaults standardUserDefaults]objectForKey:DefineUserDataKey];
        
        
        
        
        NSMutableDictionary *cookieProperties = [NSMutableDictionary dictionary];//配置cookie的map
        [cookieProperties setObject:@"tgt" forKey:NSHTTPCookieName];//cookie的名字，也就是服务的json数据中的
        [cookieProperties setObject:cookie[@"tgt"] forKey:NSHTTPCookieValue];//cookie的数值，cookie是键值对（相当于map），也就是服务的json数据中的
        [cookieProperties setObject:@"sso.zhaochewisdom.com" forKey:NSHTTPCookieDomain];//设置域名、也是服务器json返回的
        [cookieProperties setObject:@"/" forKey:NSHTTPCookiePath];//路径
        [cookieProperties setObject:[NSDate dateWithTimeIntervalSinceNow:60 * 60 * 24 * 2]  forKey:NSHTTPCookieExpires];//60 * 60 * 24 * 365，两天有效期
        NSHTTPCookie *cookieuser = [NSHTTPCookie cookieWithProperties:cookieProperties];//讲cookieProperties（也就是map）配置到HttpCookie中，得到NSHTTPCookie对象。
        [[NSHTTPCookieStorage sharedHTTPCookieStorage]  setCookie:cookieuser];//配置httpCookie。配置好，cookie就有了，访问web的时候，就会把cookie带过去。
        completionBlock();
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}

/**扫码登录*/
+ (void)sendRequestForZhaoChe:(NSDictionary *)parameters url:(NSString *)urlPath completionBlock:(void(^)(NSInteger statusCode,id errorString, id responseObject ))completionBlock
{
    [self showToastWith:nil allowUserInteractions:NO];
    NSString *urlString = [NSString stringWithFormat:@"%@/%@",DefineZhaoCheUrl,urlPath];//
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.requestSerializer.timeoutInterval = 30;
    [manager.requestSerializer setValue:@"5a9cb35668d85500019e5bf17071320863b7470996a76b69f807c598" forHTTPHeaderField:@"ZC-Authorization"];
    //            [manager.requestSerializer setValue:[RequestUtil authStr] forHTTPHeaderField:@"ZC-Authorization"];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"image/jpeg",@"image/png",@"text/plain",@"application/json",@"text/json",nil];
    
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //                NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
        //        NSLog(@"%@",dic);
        if ([dic[@"code"] integerValue] != 0) {
            [MHTToast showCenterWithText:[NSString stringWithFormat:@"用户中心登录失败 = > %@",dic[@"msg"]]];
            NSLog(@"用户中心登录失败 = > %@",dic[@"msg"]);
        }else{
            completionBlock([dic[@"code"] integerValue],nil,dic);
        }
        
        [self dismiss_t];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self dismiss_t];
    }];
}
//使用NSURLSession 发起一个get请求
+ (void)requestGetURLSession:(NSString *)urlString completionBlock:(void(^)(NSInteger statusCode,id errorString, id responseObject ))completionBlock
{
    
   
    NSArray *cookies = [NSHTTPCookieStorage sharedHTTPCookieStorage].cookies;

    __block NSMutableArray *useCookies = [[NSMutableArray alloc] init];
    [cookies enumerateObjectsUsingBlock:^(NSHTTPCookie * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.domain isEqualToString:@"dubhe.zhaochewisdom.com"]) {
            [useCookies addObject:obj];
        }
    }];
    
    NSDictionary *headers=[NSHTTPCookie requestHeaderFieldsWithCookies:useCookies];
    
    //将cookie塞进Request请求
 
    
    NSURL *url = [NSURL URLWithString:urlString];
    //2.构造Request
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    //(1)设置为POST请求
    [request setHTTPMethod:@"GET"];
    //(2)超时
    [request setTimeoutInterval:60];
    //(3)设置请求头
    
    [request setValue:[headers objectForKey:@"Cookie"]forHTTPHeaderField:@"Cookie"];
    
    NSString *contentType = [NSString stringWithFormat:@"text/html;image/jpeg;text/plain;application/json"];
    [request setAllHTTPHeaderFields:@{@"Authorization":[RequestUtil authStr],@"Content-Type":contentType}];
    
    //(4)设置请求体
    //    NSString *bodyStr = @"user_name=admin&user_password=admin";
    //    NSData *bodyData = [bodyStr dataUsingEncoding:NSUTF8StringEncoding];
    //设置请求体
    [request setHTTPBody:nil];
    //3.构造Session
    NSURLSession *session = [NSURLSession sharedSession];        //4.task
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
        NSInteger responseStatusCode = [httpResponse statusCode];
        NSDictionary *dic = @{};
        if (data != nil) {
            dic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        }
        completionBlock(responseStatusCode,nil,dic);
        
    }];
    [task resume];
}

+ (NSString *)getTheCurrentTimestamp
{
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%.f", a];
    return timeString;
}

+ (NSString *)authStr{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"ql_Auth_key"];
}
+ (BOOL)dataAuth{
    return [[[NSUserDefaults standardUserDefaults] objectForKey:@"ql_dataAuth_key"] boolValue];
}
+ (void)setDataAuth:(BOOL)auth{
    [[NSUserDefaults standardUserDefaults]setObject:@(auth) forKey:@"ql_dataAuth_key"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}
+ (void)saveAuthStr:(NSString *)str{
    [[NSUserDefaults standardUserDefaults]setObject:str forKey:@"ql_Auth_key"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

+ (void)delAuthStr{
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"ql_Auth_key"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}
+ (void)reLogin{
    AppDelegate *dele = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [dele logOut];
}
+ (NSString *)getCookies
{
    NSArray *arr = [NSHTTPCookieStorage sharedHTTPCookieStorage].cookies;
    NSString *cookieStr = @"";
    
    for (NSHTTPCookie *cookie in arr) {
        if ([cookie.name isEqualToString:@"ecology_JSessionId"]) {
            cookieStr = [NSString stringWithFormat:@"%@=%@",cookie.name, cookie.value];
            break;
        }
    }
    return cookieStr;
}
@end
