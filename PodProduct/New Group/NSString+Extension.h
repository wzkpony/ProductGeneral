//
//  NSString+Extension.h
//  DuoRongApp
//
//  Created by Panda on 16/10/8.
//  Copyright © 2016年 Panda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>
@interface NSString (Extension)
/**
 *  验证是否手机号码
 *
 *  @return YES为手机号码
 */
- (BOOL) isPhoneNum;
/**
 *  验证是否数字
 *
 *  @return YES为数字
 */
-(BOOL)isNumber;
/**
 *  验证是否数字和小数点
 *
 *  @return YES为正确
 */
- (BOOL)isNumPoint;
/**
 *  验证是否银行卡号
 *
 *  @return YES为正确
 */
- (BOOL)isVerifyBankCardNum;
/**
 *  验证是否身份证号码
 *
 *  @return YES为正确
 */
- (BOOL)isVerifyIDCardNum;
- (BOOL)isVerifyNumber;

- (BOOL)isPassword;
/**
 *  密码加密
 *
 *  @param str 加密的字符串
 *
 *  @return 加密后的字符串
 */
-(NSString *)sbjm;

/**
 *  数字标准化千分位显示
 *
 *  @param typeNum        小数点是否需要显示  测试数字：8623.300000
 0为不显示小数点 输出结果为: 8,623
 1为显示小数点后2位，如果小数点后为0就不显示 输出结果为8,623.3
 2为必需显示小数点后2位，如果不足2位则补0 输出结果为8,623.30
 *  @param isVerification isVerification为YES的时候，数字小于1的时候就显示为1，当数字大于99的时候就显示为99
 *
 *  @return 返回标准化以后的字符串
 */
- (NSString *)numDisplayStandard:(NSInteger )typeNum
                 numVerification:(BOOL)isVerification;

/**
 *  获取字符串的rect大小
 *
 *  @return 字符串的rect
 */
- (CGRect)getTextRectSizeWithFont:(UIFont *)font andSize:(CGSize)size;

/**
 *  处理手机号，中间4位为“*”
 */
- (NSString *)phoneNoAddAsterisk;



@end
