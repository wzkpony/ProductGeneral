//
//  LTSCalendarAppearance.m
//  LTSCalendar
//
//  Created by leetangsong_macbk on 16/5/24.
//  Copyright © 2016年 leetangsong. All rights reserved.
//  日历外观样式

#import "LTSCalendarAppearance.h"

@implementation LTSCalendarAppearance


+ (instancetype)share{
    static dispatch_once_t onceToken;
    static LTSCalendarAppearance *appearance;
    dispatch_once(&onceToken, ^{
        appearance = [LTSCalendarAppearance new];
    });
    return  appearance;
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setDefaultValues];
    }
    return self;
}
- (void)setFirstWeekday:(NSInteger)firstWeekday{
    _firstWeekday = firstWeekday;
    self.calendar.firstWeekday = firstWeekday;
}

- (void)setDefaultValues{
    self.dayCircleSize = 40;
    self.dayDotSize= self.dayCircleSize*1. / 9. ;
    self.weekDayFormat = LTSCalendarWeekDayFormatSingle;
    self.weekDayTextFont = [UIFont systemFontOfSize:11];
     self.weekDayTextColor = [UIColor colorWithRed:200./256. green:200./256. blue:200./256. alpha:1.];
    self.weeksToDisplay = 6;
    self.weekDayHeight = 44;
    self.isShowSingleWeek = NO;
    self.firstWeekday = 1;
    self.dayTextFont = PFMFONT(16);
    self.lunarDayTextFont = PFMFONT(10);
    
    [self setDayDotColorForAll:[UIColor colorWithRed:43./256. green:88./256. blue:134./256. alpha:1.]];
    [self setDayTextColorForAll:[UIColor whiteColor]];
    
   
    self.dayTextColor = UIColorFromRGB(0x262626);
    self.lunarDayTextColor = UIColorFromRGB(0x8A8A8A);
    
    self.dayTextColorOtherMonth  = UIColorFromRGB(0xBDBDBD);
    self.lunarDayTextColorOtherMonth = UIColorFromRGB(0xBDBDBD);
    
    self.dayTextColorSelected = [UIColor whiteColor];
    self.lunarDayTextColorSelected = [UIColor whiteColor];
    
    
    self.dayBorderColorToday = [UIColor colorWithRed:133./256. green:205./256. blue:243./256. alpha:1.];
    self.dayCircleColorSelected  = UIColorFromRGB(0x4CBCE1);
    self.dayCircleColorToday = UIColorFromRGB(0x38CCB3);
    self.dayTextColorToday = [UIColor whiteColor];
    self.dayDotColor = [UIColor redColor];
  
    
    
    self.weekDayBgColor = [UIColor whiteColor];
    self.calendarBgColor = [UIColor whiteColor];
    self.scrollBgcolor = [UIColor whiteColor];
    self.isShowLunarCalender = YES;
}

- (NSCalendar *)calendar
{
    static NSCalendar *calendar;
    static dispatch_once_t once;
    
    dispatch_once(&once, ^{
#ifdef __IPHONE_8_0
        calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
#else
        calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
#endif
        calendar.timeZone = [NSTimeZone localTimeZone];
    });
    
    return calendar;
}
- (NSCalendar *)chineseCalendar{
    static NSCalendar *calendar;
    static dispatch_once_t once;
    
    dispatch_once(&once, ^{
#ifdef __IPHONE_8_0
        calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierChinese];
#else
        calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSChineseCalendar];
#endif
        calendar.timeZone = [NSTimeZone localTimeZone];
    });
    
    return calendar;
}

- (void)setDayDotColorForAll:(UIColor *)dotColor
{
    self.dayDotColor = dotColor;
//    self.dayDotColorSelected = dotColor;
    
//    self.dayDotColorOtherMonth = dotColor;
//    self.dayDotColorSelectedOtherMonth = dotColor;
    
    
//    self.dayDotColorTodayOtherMonth = dotColor;
}

- (void)setDayTextColorForAll:(UIColor *)textColor
{
    self.dayTextColor = textColor;
    self.dayTextColorSelected = textColor;
    self.lunarDayTextColor = textColor;
    self.lunarDayTextColorSelected = textColor;
    
    self.dayTextColorOtherMonth = textColor;
    self.lunarDayTextColorOtherMonth = textColor;
//    self.dayTextColorSelectedOtherMonth = textColor;
    
    self.dayTextColorToday = textColor;
//    self.dayTextColorTodayOtherMonth = textColor;
}

@end
