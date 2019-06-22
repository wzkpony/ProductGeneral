//
//  LLLocalizedHelper.m
//  InternationalizationDemo
//
//  Created by Eve on 2018/9/6.
//  Copyright © 2018年 Adinnt. All rights reserved.
//

#import "COSLocalizedHelper.h"

static NSBundle *_bundle;

static NSString *const kUserLanguage = @"kUserLanguage";
NSString *const kChangelanguageNoticeName = @"kChangelanguageNoticeName";

@implementation COSLocalizedHelper

+ (instancetype)shareLocalizedHelper {
    static COSLocalizedHelper *helper;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        helper = [[COSLocalizedHelper alloc] init];
    });
    return helper;
}


- (instancetype)init {
    
    if (self = [super init]) {
        
        if (!_bundle) {
            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            
            NSString *userLanguage = [defaults valueForKey:kUserLanguage];
            
            //用户未手动设置过语言
            if (userLanguage.length == 0) {
                
                NSArray *languages = [[NSBundle mainBundle] preferredLocalizations];
                
                NSString *systemLanguage = languages.firstObject;
                
                userLanguage = systemLanguage;
            }
            
            if ([userLanguage isEqualToString:@"zh-HK"] || [userLanguage isEqualToString:@"zh-TW"]) {
                userLanguage = @"zh-Hant";
            }
            
            NSString *path = [[NSBundle mainBundle] pathForResource:userLanguage ofType:@"lproj"];
            
            _bundle = [NSBundle bundleWithPath:path];
        }
        
    }
    return self;
}

- (NSBundle *)bundle {
    return _bundle;
}

- (NSString *)currentLanguage {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *userLanguage = [defaults valueForKey:kUserLanguage];
    //用户未手动设置过语言
    if (userLanguage.length == 0) {
        // 汉语: zh-Hans  zh-Hans繁体字
        // 英语: en
        // 法语: fr
        // 俄语: ru-BY
        // 阿拉伯语: ar-DZ
        // 西班牙语: es-AI
        NSArray *languages = [[NSBundle mainBundle] preferredLocalizations];
        
        NSString *systemLanguage = languages.firstObject;
        
        return systemLanguage;
    }
    
    return userLanguage;
}


- (void)setUserLanguage:(NSString *)language {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:language ofType:@"lproj"];
    
    _bundle = [NSBundle bundleWithPath:path];
    
    [defaults setValue:language forKey:kUserLanguage];
    
    [defaults synchronize];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kChangelanguageNoticeName object:nil userInfo:@{@"language":language}];
}

- (NSString *)stringWithKey:(NSString *)key {
    
    if (_bundle) {
        return [_bundle localizedStringForKey:key value:nil table:@"Localizable"];
    }else {
        return NSLocalizedString(key, nil);
    }
}

@end

