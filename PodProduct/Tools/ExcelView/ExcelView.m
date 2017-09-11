//
//  ExcelView.m
//  ExcelTabel
//
//  Created by wzk on 2017/9/6.
//  Copyright © 2017年 df. All rights reserved.
//
#import "ExcelView.h"


@interface ExcelView()<UIScrollViewDelegate>

@property (nonatomic, strong) ExcelLeftView *leftView;//左边列表
@property (nonatomic,strong)  ExcelRightView *rightView;//右边列表


@property (nonatomic, strong) NSArray *topArr;

@property (nonatomic, strong) NSArray *leftArr;

@property (nonatomic, strong) NSArray *rightArray;

@property (nonatomic, copy)  NSString* topString;
@end
@implementation ExcelView

-(void)reloadDtaeForTableView
{
    
    [self getContents];
    [self addContentForTable];
    
    self.leftView.tableV.frame = CGRectMake(0, 0, self.frame.size.width, cellHeight * self.leftArr.count + mHeight);
    self.rightView.rightTableV.frame = CGRectMake(0, 0, mWidth * _topArr.count+addWidthSize, _rightArray.count*cellHeight + mHeight);
    self.rightView.myScrollView.frame = CGRectMake(0, 0, ScreenWidth - leftWidth, _rightArray.count*cellHeight + mHeight);
    
    [self.leftView.tableV reloadData];
    [self.rightView.rightTableV reloadData];
   
}
-(void)getContents
{
    
    _leftArr = [self.excel_delegate excelViewForLeftArr:self];
    _rightArray = [self.excel_delegate excelViewForRightArr:self];
    
}
-(void)addContentForTable
{
    self.rightView.rightArray = self.rightArray;
    self.leftView.leftArr = self.leftArr;
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    for (UIView *view in self.subviews) {
        view.backgroundColor = [UIColor whiteColor];
    }
    
    self.clipsToBounds = YES;
    if (self.excel_delegate == nil) {
        return;
    }
    _topArr = [self.excel_delegate excelViewForTopArr:self];
    _topString = [self.excel_delegate excelViewForRightTopString:self];
   [self getContents];
    
    //   左部
    self.leftView = [[ExcelLeftView alloc] initWithFrame:CGRectMake(0, 0, leftWidth, ScreenHeight-64)];
    self.leftView.tableV.bounces = NO;
    self.leftView.topString = _topString;
    self.leftView.leftArr = self.leftArr;
    self.leftView.delegate = self;
    self.leftView.fontType = self.fontNumberLeftItem;
    self.leftView.fontRightTop = self.fontNumberTopItem;
    [self addSubview:self.leftView];
    
    //   右部
    self.rightView = [[ExcelRightView alloc] initWithFrame:CGRectMake(leftWidth, 0, ScreenWidth - leftWidth, ScreenHeight-64) withTopArr:_topArr];
    self.rightView.rightTableV.bounces = NO;
    self.rightView.rightArray = self.rightArray;

    self.rightView.delegate = self;
    self.rightView.fontType = self.fontNumberRithtItem;
    self.rightView.fontNumberTopItem = self.fontNumberTopItem;
    [self addSubview:self.rightView];
    
    
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    UIView *view = [super hitTest:point withEvent:event];
    if (([view isKindOfClass:[UITableView class]])) {
        return self.leftView.tableV;
    }
    return view;
    
    return self.leftView.tableV;//[super hitTest:point withEvent:event];
}

@end
