//
//  FontConfig.h
//  PodProduct
//
//  Created by wzk on 2018/1/16.
//  Copyright © 2018年 wzk. All rights reserved.
//

#import <Foundation/Foundation.h>
#define CONTEXT_TEXT_FONT [UIFont systemFontOfSize:12]
#define TABLEVIEW_GROUP_TITLE_FONT [UIFont systemFontOfSize:15]

/*
 字体格式设置
 */
#define HelveticaBold @"Helvetica-Bold"
#define Neue @"HelveticaNeue"
#define ArialBoldMT @"Arial-BoldMT"
#define PingFangSCRegular @"PingFangSC-Regular"
#define PingFangSCSemibold @"PingFangSC-Semibold"
#define PingFangSCBold @"PingFangSC-Bold"


/*
 设置字体样式和大小
 type ：字体格式
 f： 字体大小
 scale： 适配设别比例
 */
#define FontTypeAndSize(type,f,scale) [UIFont fontWithName:type size:((f)* (scale))]

@interface FontConfig : NSObject

@end
