//
//  LTSCalendarDayItem.h
//  LTSCalendar
//
//  Created by 李棠松 on 2018/1/9.
//  Copyright © 2018年 leetangsong. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger,HolidayType){
    HolidayTypeNone,
    HolidayTypeRest,
    HolidayTypeWork
};

@import UIKit;
@interface LTSCalendarDayItem : NSObject
@property (nonatomic, strong) NSDate *date;
@property (nonatomic, assign) BOOL isOtherMonth;
@property (nonatomic, assign) BOOL isSelected;
@property (nonatomic, strong) UIColor *eventDotColor;
@property (nonatomic, assign) BOOL showEventDot;
@property (nonatomic, assign) HolidayType holidayType;

@end
