//
//  TimeStampToString.h
//  DuoRongApp
//
//  Created by Panda on 16/10/31.
//  Copyright © 2016年 Panda. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimeStampToString : NSObject

/**
 *  将时间戳转换成需要显示的日期字符串
 *
 *  @param timeStamp 时间戳
 *  @param dateType  显示字符串的样式 例如@"yyyy/MM/dd"
 *
 *  @return 格式化完成的字符串
 */
+(NSString *)timeStampToString:(NSTimeInterval)timeStamp
                      withType:(NSString *)dateType;

/**
 *  将时间戳转换成需要显示的日期字符串 yyyy-MM-dd
 *
 *  @param timeStamp 时间戳
 *
 *  @return 格式化完成的字符串
 */
+(NSString *)timeStampToString:(NSTimeInterval)timeStamp;

/**
 *  将时间戳转换成需要显示的日期字符串 yyyy-MM-dd hh:mm:ss
 *
 *  @param timeStamp 时间戳
 *
 *  @return 格式化完成的字符串
 */
+(NSString *)timeStampToStringWithTime:(NSTimeInterval)timeStamp;
/**
 *  将时间戳转换成需要显示的日期字符串 yyyy-MM-dd HH:mm:ss
 *
 *  @param timeStamp 时间戳
 *
 *  @return 格式化完成的字符串
 */
+(NSString *)timeStampToStringWithTime24H:(NSTimeInterval)timeStamp;

/**
 *  将NSDate转成时间戳
 *
 *
 *
 *
 */
+(NSInteger)integerStampDate:(NSDate* )date;

@end
