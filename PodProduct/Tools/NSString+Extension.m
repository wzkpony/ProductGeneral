//
//  NSString+Extension.m
//  DuoRongApp
//
//  Created by Panda on 16/10/8.
//  Copyright © 2016年 Panda. All rights reserved.
//

#import "NSString+Extension.h"
#import<CommonCrypto/CommonDigest.h>

@implementation NSString (Extension)
- (BOOL) isPhoneNum{
//    [self rangeOfString:@"^1[3|4|5|7|8][0-9]{9}$" options:NSRegularExpressionSearch];
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"^1[3|4|5|7|8][0-9]{9}$" options:NSRegularExpressionCaseInsensitive error:&error];
    NSTextCheckingResult *result = [regex firstMatchInString:self options:0 range:NSMakeRange(0, [self length])];
    if (result) {
        return YES;
    }
    return NO;
}
- (BOOL)isNumber {
        NSString *number = @"^[0-9]+$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",number];
    return [predicate evaluateWithObject:self];
}
- (BOOL)isNumPoint{

    NSString* number=@"^\\-?([1-9]\\d*|0)(\\.\\d{0,2})?$";
    NSPredicate *numberPre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",number];
    return [numberPre evaluateWithObject:self];
}
/**
 *  是否有效金额字符
 *
 *  @return YES为是
 */
- (BOOL)isVerifyNumber{
    NSString* number=@"^\\d+(\\.\\d{1,2})?$";
    NSPredicate *numberPre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",number];
    return [numberPre evaluateWithObject:self];
}

- (BOOL)isVerifyBankCardNum{
    NSString* number=@"^([0-9]{16}|[0-9]{18}|[0-9]{19})$";
    NSPredicate *numberPre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",number];
    return [numberPre evaluateWithObject:self];
}

- (BOOL)isVerifyIDCardNum{
    NSString* number=@"(^[0-9]{15}$)|([0-9]{17}([0-9]|X)$)";
    NSPredicate *numberPre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",number];
    return [numberPre evaluateWithObject:self];
}

- (BOOL)isPassword{
    NSString *password = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,18}$";
    NSPredicate *passwordPre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",password];
    return [passwordPre evaluateWithObject:self];
}

- (NSString*)sha256:(NSString *)str
{
    const char *cstr = [str cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:str.length];
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH];
    
    CC_SHA256(data.bytes, (uint32_t)data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA256_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA256_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}
- (NSString *)getMd5_32Bit:(NSString *)str{
    const char *cStr = [str UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (uint32_t)str.length, digest );
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [result appendFormat:@"%02x", digest[i]];
    return result;
}

-(NSString *)sbjm{
    NSString * jm1 = [self getMd5_32Bit:self];
    return [self sha256:jm1];
}
- (NSString *)numDisplayStandard:(NSInteger )typeNum
                 numVerification:(BOOL)isVerification{
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle:1];
    
    if (typeNum == 0) {
        [numberFormatter setMaximumFractionDigits:0];
    } else if (typeNum == 1) {
        [numberFormatter setMinimumFractionDigits:0];
        [numberFormatter setMaximumFractionDigits:2];
    } else {
        [numberFormatter setMinimumFractionDigits:2];
        [numberFormatter setMaximumFractionDigits:2];
        
        
    }
    [numberFormatter setFormatterBehavior:NSNumberFormatterBehaviorDefault];
    numberFormatter.roundingMode = NSRoundDown;
    id num = [numberFormatter numberFromString:self];
   
    if (isVerification && num) {
        if ([num intValue] < 1 && [num floatValue] > 0.00) {
            num = [NSNumber numberWithInt:1];
        }
        if ([num intValue] == 99) {
            num = [NSNumber numberWithInt:99];
        }
    }
    NSString * numStr = [numberFormatter stringFromNumber:num];
    NSRange pointRange = [numStr rangeOfString:@"."];
    if (pointRange.location + 2 < numStr.length - 1) {
        
        return [numStr substringToIndex:pointRange.location + 2 + 1];
    } else {
        return numStr;
    }
    return numStr;
}

- (CGRect)getTextRectSizeWithFont:(UIFont *)font andSize:(CGSize)size {
    CGRect rect = [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:font} context:nil];
    return rect;
}

- (NSString *)phoneNoAddAsterisk {
    return [self stringByReplacingCharactersInRange:NSMakeRange(3,4) withString:@"****"];
}

@end
