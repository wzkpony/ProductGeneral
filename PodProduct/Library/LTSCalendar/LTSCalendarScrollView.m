//
//  LTSCalendarScrollView.m
//  LTSCalendar
//
//  Created by 李棠松 on 2018/1/13.
//  Copyright © 2018年 leetangsong. All rights reserved.
//

#import "LTSCalendarScrollView.h"


@interface LTSCalendarScrollView()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UIView *line;
@property (nonatomic,strong)UIView *whiteSegView;
@property (nonatomic, strong) UIView *weekNumView;

@end
@implementation LTSCalendarScrollView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshWeekNum:) name:@"refreshWeekNumNoti" object:nil];
        [self initUI];
    }
    return self;
}
- (void)setBgColor:(UIColor *)bgColor{
    _bgColor = bgColor;
    self.backgroundColor = bgColor;
    self.tableView.backgroundColor = bgColor;
    self.line.backgroundColor = bgColor;
    self.whiteSegView.backgroundColor = [UIColor whiteColor];
}

- (void)initUI{
    //创建一年中周数label
    _weekNumLabels = @[].mutableCopy;
    
    UIView *weekNumView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 35, [LTSCalendarAppearance share].weekDayHeight*[LTSCalendarAppearance share].weeksToDisplay)];
//    weekNumView.backgroundColor = RGBA(0, 60, 70, 0.3);
    [self addSubview:weekNumView];
    _weekNumView = weekNumView;
    CGFloat itemHeight = weekNumView.height / [LTSCalendarAppearance share].weeksToDisplay * 1.f;
    
    for (int i = 0; i < [LTSCalendarAppearance share].weeksToDisplay; i++) {
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(0, i*itemHeight, weekNumView.width, itemHeight);
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont fontWithName:@"PingFangSC-Regular" size:10];
        label.textColor = [UIColor colorWithRed:138/255.0 green:138/255.0 blue:138/255.0 alpha:1/1.0];
        [weekNumView addSubview:label];
        [_weekNumLabels addObject:label];
    }
    UIView *vLine = [[UIView alloc] init];
    vLine.backgroundColor = [UIColor colorWithRed:225/255.0 green:225/255.0 blue:225/255.0 alpha:1/1.0];
    [weekNumView addSubview:vLine];
    [vLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weekNumView);
        make.top.equalTo(weekNumView).offset(10);
        make.bottom.equalTo(weekNumView).offset(-10);
        make.width.mas_equalTo(1);
    }];
    
    self.delegate = self;
    self.bounces = false;
    self.showsVerticalScrollIndicator = false;
    self.backgroundColor = [LTSCalendarAppearance share].scrollBgcolor;
    LTSCalendarContentView *calendarView = [[LTSCalendarContentView alloc]initWithFrame:CGRectMake(34, 0, KWIDTH-34-15, [LTSCalendarAppearance share].weekDayHeight*[LTSCalendarAppearance share].weeksToDisplay)];
    calendarView.currentDate = [NSDate date];
    [self addSubview:calendarView];
    self.calendarView = calendarView;
    
    self.whiteSegView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(calendarView.frame), CGRectGetWidth(self.frame),15)];
    
    self.line = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.whiteSegView.frame), CGRectGetWidth(self.frame),0.5)];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(calendarView.frame), CGRectGetWidth(self.frame), self.height-calendarView.height)];
    //CGRectGetHeight(self.frame)-CGRectGetMaxY(calendarView.frame))
    self.tableView.backgroundColor = RGB(245, 245, 245);
    
    self.tableView.alwaysBounceVertical = NO;
    self.tableView.bounces = NO;
//    self.tableView.delegate = self;
//    self.tableView.dataSource = self;
    self.tableView.rowHeight = 65;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.contentInset = UIEdgeInsetsMake(25, 0, 0, 0);
    self.tableView.scrollEnabled = [LTSCalendarAppearance share].isShowSingleWeek;
    [self addSubview:self.tableView];
    
    self.line.backgroundColor = self.backgroundColor;
    self.whiteSegView.backgroundColor = self.backgroundColor;
    [self addSubview:self.line];
    [self addSubview:self.whiteSegView];
    
    [LTSCalendarAppearance share].isShowSingleWeek ? [self scrollToSingleWeek]:[self scrollToAllWeek];
    
    UIView *tabHeadView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KWIDTH, 45)];
    tabHeadView.backgroundColor = [UIColor whiteColor];
    UILabel *tabTitleLabel = [[UILabel alloc] init];
    tabTitleLabel.frame = CGRectMake(15, 0, KWIDTH-30, 22);
    tabTitleLabel.centerY = tabHeadView.centerY;
    tabTitleLabel.text = @"今天";
    tabTitleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:16];
    tabTitleLabel.textColor = [UIColor colorWithRed:38/255.0 green:38/255.0 blue:38/255.0 alpha:1/1.0];
    [tabHeadView addSubview:tabTitleLabel];
    _tabHeadView = tabHeadView;
    _tabTitleLabel = tabTitleLabel;
    _tableView.tableHeaderView = tabHeadView;
    
    
    
}
- (void)refreshWeekNum:(NSNotification *)noti{
    if (!_weekNums) {
        _weekNums = @[].mutableCopy;
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDateComponents *comps = [calendar components:NSCalendarUnitWeekOfYear|NSCalendarUnitWeekday|NSCalendarUnitWeekdayOrdinal  fromDate:[NSDate date]];
//        NSInteger weekdayOrdinal = [comps weekdayOrdinal]; // 这个月的第几周
        NSInteger week = [comps weekOfYear]; // 今年的第几周
        NSInteger index = [noti.object integerValue];//今天在本月的第几周 从1开始
        NSMutableArray *arr = @[].mutableCopy;
        for (int i = 1; i < 7; i++) {
            NSInteger value = week + (i-index);
            [arr addObject:[NSString stringWithFormat:@"%ld",value]];
            UILabel *lab = _weekNumLabels[i-1];
            lab.text = [NSString stringWithFormat:@"%ld",value];
            [_weekNums addObject:[NSString stringWithFormat:@"%ld",value]];
        }
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}



- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
   
    CGFloat offsetY = scrollView.contentOffset.y;
    
    
    if (scrollView != self) {
        NSLog(@"滑动 tableview");
        return;
    }
  
    LTSCalendarAppearance *appearce =  [LTSCalendarAppearance share];
    ///表需要滑动的距离
    CGFloat tableCountDistance = appearce.weekDayHeight*(appearce.weeksToDisplay-1);
    ///日历需要滑动的距离
    CGFloat calendarCountDistance = self.calendarView.singleWeekOffsetY;
    
    CGFloat scale = calendarCountDistance/tableCountDistance;
    
    NSLog(@"offsetY = %.f",offsetY);
    CGRect calendarFrame = self.calendarView.frame;
    CGRect weekNumFrame = self.weekNumView.frame;
    self.calendarView.maskView.alpha = offsetY/tableCountDistance;
    self.calendarView.maskView.hidden = false;
    calendarFrame.origin.y = offsetY-offsetY*scale;
    weekNumFrame.origin.y = offsetY-offsetY*scale;
    if(ABS(offsetY) >= tableCountDistance) {
         self.tableView.scrollEnabled = true;
        self.calendarView.maskView.hidden = true;
        //为了使滑动更加顺滑，这部操作根据 手指的操作去设置
//         [self.calendarView setSingleWeek:true];
        
    }else{
        
        self.tableView.scrollEnabled = false;
        if ([LTSCalendarAppearance share].isShowSingleWeek) {
           
            [self.calendarView setSingleWeek:false];
        }
    }
    CGRect tableFrame = self.tableView.frame;
    tableFrame.size.height = CGRectGetHeight(self.frame)-CGRectGetHeight(self.calendarView.frame)+offsetY;
    self.tableView.frame = tableFrame;
    self.bounces = false;
    if (offsetY<=0) {
        return;
        self.bounces = true;
        calendarFrame.origin.y = offsetY;
        tableFrame.size.height = CGRectGetHeight(self.frame)-CGRectGetHeight(self.calendarView.frame);
        self.tableView.frame = tableFrame;
    }
    self.calendarView.frame = calendarFrame;
    self.weekNumView.frame = weekNumFrame;
    
    
    
}
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    LTSCalendarAppearance *appearce =  [LTSCalendarAppearance share];
    CGFloat tableCountDistance = appearce.weekDayHeight*(appearce.weeksToDisplay-1);
    if ( appearce.isShowSingleWeek) {
        if (self.contentOffset.y != tableCountDistance) {
            return  nil;
        }
    }
    if ( !appearce.isShowSingleWeek) {
        if (self.contentOffset.y != 0 ) {
            return  nil;
        }
    }

    return  [super hitTest:point withEvent:event];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    
    LTSCalendarAppearance *appearce =  [LTSCalendarAppearance share];
    CGFloat tableCountDistance = appearce.weekDayHeight*(appearce.weeksToDisplay-1);

    if (scrollView.contentOffset.y>=tableCountDistance) {
        [self.calendarView setSingleWeek:true];
    }
    
}


- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    if (self != scrollView) {
        return;
    }
   
    LTSCalendarAppearance *appearce =  [LTSCalendarAppearance share];
    ///表需要滑动的距离
    CGFloat tableCountDistance = appearce.weekDayHeight*(appearce.weeksToDisplay-1);
    //point.y<0向上
    CGPoint point =  [scrollView.panGestureRecognizer translationInView:scrollView];
    
    if (point.y<=0) {
       
        [self scrollToSingleWeek];
    }
    
    if (scrollView.contentOffset.y<tableCountDistance-20&&point.y>0) {
        [self scrollToAllWeek];
    }
}
//手指触摸完
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    if (self != scrollView) {
        return;
    }
    LTSCalendarAppearance *appearce =  [LTSCalendarAppearance share];
    ///表需要滑动的距离
    CGFloat tableCountDistance = appearce.weekDayHeight*(appearce.weeksToDisplay-1);
    //point.y<0向上
    CGPoint point =  [scrollView.panGestureRecognizer translationInView:scrollView];
    
    
    if (point.y<=0) {
        if (scrollView.contentOffset.y>=20) {
            if (scrollView.contentOffset.y>=tableCountDistance) {
                [self.calendarView setSingleWeek:true];
            }
            [self scrollToSingleWeek];
        }else{
            
            [self scrollToAllWeek];
        }
    }else{
        if (scrollView.contentOffset.y<tableCountDistance-20) {
            [self scrollToAllWeek];
        }else{
            [self scrollToSingleWeek];
        }
    }
  
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
     [self.calendarView setUpVisualRegion];
}


- (void)scrollToSingleWeek{
    LTSCalendarAppearance *appearce =  [LTSCalendarAppearance share];
    ///表需要滑动的距离
    self.whiteSegView.py_height = 20;
    self.tableView.contentInset = UIEdgeInsetsMake(30, 0, 0, 0);
    CGFloat tableCountDistance = appearce.weekDayHeight*(appearce.weeksToDisplay-1);
    [self setContentOffset:CGPointMake(0, tableCountDistance) animated:true];
}

- (void)scrollToAllWeek{
    
    self.weekNumView.frame = CGRectMake(self.weekNumView.py_x, 0, self.weekNumView.width, self.weekNumView.height);
    self.calendarView.frame = CGRectMake(self.calendarView.py_x, 0, self.calendarView.width, self.calendarView.height);
    self.whiteSegView.height = 15;
    self.tableView.contentInset = UIEdgeInsetsMake(25, 0, 0, 0);
    [self setContentOffset:CGPointMake(0, 0) animated:true];
}


- (void)layoutSubviews{
    [super layoutSubviews];

    self.contentSize = CGSizeMake(0, CGRectGetHeight(self.frame)+[LTSCalendarAppearance share].weekDayHeight*([LTSCalendarAppearance share].weeksToDisplay-1));
}

@end
