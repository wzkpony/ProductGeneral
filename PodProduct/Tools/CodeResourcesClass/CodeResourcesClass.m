//
//  CodeResourcesClass.m
//  CashLoan
//
//  Created by wzk on 2018/1/5.
//  Copyright © 2018年 com.shanlinfinance. All rights reserved.
//

#import "CodeResourcesClass.h"
@implementation CodeResourcesClass
+ (BOOL)codeResourcesTest
{
    BOOL same = YES;
    NSDictionary* dataCodeResource = [self getCodeResources];
    NSDictionary* dataRequest = [self getRequestCodeResources];
    
    for (NSString *diffValue in dataRequest) {
//        if ([diffValue isEqualToString:@"archived-expanded-entitlements.xcent"] || [diffValue isEqualToString:@"libswiftRemoteMirror.dylib"]) {}
//        else {
            id valueRequest = dataRequest[diffValue];
            id valueCodeResource = dataCodeResource[diffValue];
//            if ([valueRequest isKindOfClass:[NSData]]) {
//                <#statements#>
//            }
            if (![valueRequest isEqual:valueCodeResource]) {
                same = NO;
            }
            
//        }
    }
    
    return same;
}

//从CodeResources获取当前文件的hash
+ (NSDictionary* )getCodeResources
{
    NSString* bundlePath = [[NSBundle mainBundle] resourcePath];
//    NSFileManager* manager = [NSFileManager defaultManager];
    NSString* path = [NSString stringWithFormat:@"%@/_CodeSignature/CodeResources",bundlePath];
//    NSData* data = [manager contentsAtPath:path];
    
    NSDictionary* dict = [[NSDictionary alloc] initWithContentsOfFile:path];
    NSDictionary* dictFiled = dict[@"files"];
    return dictFiled;
}
//从本地服务获取 CodeResources的hash
+ (NSDictionary* )getRequestCodeResources
{
    NSString* path = [NSString stringWithFormat:@"%@/readFile.htm?path=api/static/ios/CodeResources.xml",@"你的url地址"];
    NSDictionary* dict = [[NSDictionary alloc] initWithContentsOfURL:[NSURL URLWithString:path]];
    NSDictionary* dictFiled = dict[@"files"];
    return dictFiled;
}

@end
