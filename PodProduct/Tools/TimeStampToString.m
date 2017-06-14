//
//  TimeStampToString.m
//  DuoRongApp
//
//  Created by Panda on 16/10/31.
//  Copyright © 2016年 Panda. All rights reserved.
//

#import "TimeStampToString.h"

@implementation TimeStampToString
+(NSString *)timeStampToString:(NSTimeInterval)timeStamp
                      withType:(NSString *)dateType{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:dateType];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeStamp];
    return [dateFormatter stringFromDate:date];
}
+(NSString *)timeStampToString:(NSTimeInterval)timeStamp{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeStamp];
    return [dateFormatter stringFromDate:date];
}
+(NSString *)timeStampToStringWithTime:(NSTimeInterval)timeStamp{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeStamp];
    return [dateFormatter stringFromDate:date];
}
+(NSInteger)integerStampDate:(NSDate* )date
{
    NSTimeInterval i = [date timeIntervalSince1970];
    return i;
}
+(NSString *)timeStampToStringWithTime24H:(NSTimeInterval)timeStamp{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeStamp];
    return [dateFormatter stringFromDate:date];
}
@end
