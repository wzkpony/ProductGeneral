//
//  NSNumber+Format.m
//  ShanLinCaiFu
//
//  Created by wuqh on 16/3/19.
//  Copyright © 2016年 ShanLinJinRong. All rights reserved.
//

#import "NSNumber+Format.h"

@implementation NSNumber (Format)

- (NSString *)formateCountNumChina {
    NSNumberFormatter *numFormate = [[NSNumberFormatter alloc] init];
    numFormate.numberStyle = NSNumberFormatterCurrencyStyle;

    NSDecimalNumber *num = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%lf",[self doubleValue]]];
    NSDecimalNumberHandler* roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown scale:2 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    NSDecimalNumber *roundedOunces = [num decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
    
    NSString *numStr = [numFormate stringFromNumber:roundedOunces];
    
    return [numStr stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:@"￥"];
}

- (NSString *)formateCountNum {
    
    return [[self formateCountNumChina] substringFromIndex:1];

}

- (NSString *)formateCountNumNoFloat {
    NSNumberFormatter *numFormat = [[NSNumberFormatter alloc] init] ;
    [numFormat setNumberStyle:NSNumberFormatterDecimalStyle];
    
    NSNumber *num = [NSNumber numberWithDouble:[self doubleValue]];
    return [numFormat stringFromNumber:num];
}

- (NSString *)formateDateYYYYMMDD {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    NSDate*confromTimesp = [NSDate dateWithTimeIntervalSince1970:(NSTimeInterval)([self doubleValue]/1000)];
    return [formatter stringFromDate:confromTimesp];
    
}
- (NSString *)formateDateYYYYMMDDHHMMSS {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate*confromTimesp = [NSDate dateWithTimeIntervalSince1970:(NSTimeInterval)([self doubleValue]/1000)];
    return [formatter stringFromDate:confromTimesp];
}

//斜线
- (NSString *)formateDateYYYYMMDDHHMMSSByDiagonal {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    
    NSDate*confromTimesp = [NSDate dateWithTimeIntervalSince1970:(NSTimeInterval)([self doubleValue]/1000)];
    return [formatter stringFromDate:confromTimesp];
}

- (NSString *)formateRate {
    
//    CGFloat rate = [self notRoundingAfterPoint:3] *100;
//    NSString *rateStr = [NSString stringWithFormat:@"%0.1f%%",rate];
//    return rateStr;
      return @"";
}

#pragma mark - 数字截取
- (double )notRoundingAfterPoint:(NSInteger)position {
    
    NSDecimalNumberHandler* roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown scale:position raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:YES];
    
    NSDecimalNumber *ouncesDecimal = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%lf",[self doubleValue]]];
    NSDecimalNumber *roundedOunces = [ouncesDecimal decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
    return roundedOunces.doubleValue;

    
}

- (NSString *)userRanking {
    
    switch ([self integerValue]) {
        case 0:
            return @"一星白金";
            break;
        case 1:
            return @"一星白金";
            break;
        case 2:
            return @"二星白金";
            break;
        case 3:
            return @"三星白金";
            break;
        case 4:
            return @"一星钻石";
            break;
        case 5:
            return @"二星钻石";
            break;
        case 6:
            return @"三星钻石";
            break;
        case 7:
            return @"黑钻";
            break;
        default:
            break;
    }
    return @"";
}


- (NSString *)userRankingGetImageNameWithShowHoldAmountRanking:(NSString *)showHoldAmountRanking {
    
    switch ([self integerValue]) {
        case 0:
            return @"白金1";
            break;
        case 1:
            return [NSString stringWithFormat:@"白金1%@", ([showHoldAmountRanking integerValue] ? @"亮" : @"")];
            break;
        case 2:
            return [NSString stringWithFormat:@"白金2%@", ([showHoldAmountRanking integerValue] ? @"亮" : @"")];
            break;
        case 3:
            return [NSString stringWithFormat:@"白金3%@", ([showHoldAmountRanking integerValue] ? @"亮" : @"")];
            break;
        case 4:
            return [NSString stringWithFormat:@"钻石1%@", ([showHoldAmountRanking integerValue] ? @"亮" : @"")];
            break;
        case 5:
            return [NSString stringWithFormat:@"钻石2%@", ([showHoldAmountRanking integerValue] ? @"亮" : @"")];
            break;
        case 6:
            return [NSString stringWithFormat:@"钻石3%@", ([showHoldAmountRanking integerValue] ? @"亮" : @"")];
            break;
        case 7:
            return [NSString stringWithFormat:@"大黑钻%@", ([showHoldAmountRanking integerValue] ? @"亮" : @"")];
            break;
        default:
            break;
    }
    return @"";
}
@end
