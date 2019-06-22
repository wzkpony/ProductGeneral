//
//  LLLocalizedHelper.h
//  InternationalizationDemo
//
//  Created by Eve on 2018/9/6.
//  Copyright © 2018年 Adinnt. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 多语言设置管理
 */
#define kLocalizedString(key,description) [[COSLocalizedHelper shareLocalizedHelper] stringWithKey:key]

extern NSString *const kChangelanguageNoticeName;

@interface COSLocalizedHelper : NSObject

+ (instancetype)shareLocalizedHelper;

- (NSBundle *)bundle;

- (NSString *)currentLanguage;

- (void)setUserLanguage:(NSString *)language;

- (NSString *)stringWithKey:(NSString *)key;

@end

