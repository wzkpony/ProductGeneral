//
//  LTSCalendarScrollView.h
//  LTSCalendar
//
//  Created by 李棠松 on 2018/1/13.
//  Copyright © 2018年 leetangsong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LTSCalendarContentView.h"
#import "LTSCalendarWeekDayView.h"
@interface LTSCalendarScrollView : UIScrollView
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic, strong) UILabel *tabTitleLabel;
@property (nonatomic, strong) UIView *tabHeadView;

@property (nonatomic, strong) NSMutableArray *weekNumLabels;
@property (nonatomic, strong) NSMutableArray *weekNums;//日历左侧当月的周数
@property (nonatomic,strong)LTSCalendarContentView *calendarView;

@property (nonatomic,strong)UIColor *bgColor;
- (void)scrollToSingleWeek;

- (void)scrollToAllWeek;
@end
