//
//  CustomConst.h
//  DuoRongApp
//
//  Created by Panda on 16/9/28.
//  Copyright © 2016年 Panda. All rights reserved.
//

#ifndef CustomConst_h
#define CustomConst_h


//获取系统版本号
#define SYSTEM_VERSION [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

//检查系统版本
#define SYSTEM_VERSION_EQUAL_TO(v) (［[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v) (［[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v) (［[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v) (［[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v) (［[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

//延迟
#define DELAYEXECUTE(delayTime,func) (dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{func;}))
//UserDefault
#define UserDefault [NSUserDefaults standardUserDefaults]


#endif /* CustomConst_h */
