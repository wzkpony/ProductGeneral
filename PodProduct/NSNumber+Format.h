//
//  NSNumber+Format.h
//  ShanLinCaiFu
//
//  Created by wuqh on 16/3/19.
//  Copyright © 2016年 ShanLinJinRong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNumber (Format)

/**
 *  带￥符号，切包含小数
 */
- (NSString *)formateCountNumChina;
/**
 * 不带￥符号，但保留两位
 */
- (NSString *)formateCountNum;

- (NSString *)formateCountNumNoFloat;


/**
 *  转为百分比
 */
- (NSString *)formateRate;

- (NSString *)formateDateYYYYMMDD;
- (NSString *)formateDateYYYYMMDDHHMMSS;
- (NSString *)formateDateYYYYMMDDHHMMSSByDiagonal;

- (double )notRoundingAfterPoint:(NSInteger)position;


// 用户级别
- (NSString *)userRanking;

// 用户级别图片名称
- (NSString *)userRankingGetImageNameWithShowHoldAmountRanking:(NSString *)showHoldAmountRanking;

@end
