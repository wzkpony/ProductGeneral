//
//  ExcelContentView.m
//  PodProduct
//
//  Created by wzk on 2017/9/12.
//  Copyright © 2017年 wzk. All rights reserved.
//

#import "ExcelContentView.h"

@interface ExcelContentView()<UIScrollViewDelegate>


@end

@implementation ExcelContentView

-(void)reloadDtaeForTableView
{
    
    [self addContentForTable];
    
    self.leftView.tableV.frame = CGRectMake(0, 0, self.frame.size.width, cellHeight * self.leftArr.count);
    
    self.rightView.rightTableV.frame = CGRectMake(0, 0, mWidth * _topNumber+addWidthSize, _rightArr.count*cellHeight);
    
    self.rightView.myScrollView.frame = CGRectMake(0, 0, self.frame.size.width - leftWidth, _rightArr.count*cellHeight);
    self.rightView.myScrollView.contentSize=CGSizeMake(mWidth * _topNumber+addWidthSize, _rightArr.count*cellHeight);
    
    [self.leftView.tableV reloadData];
    [self.rightView.rightTableV reloadData];
    
}

-(void)addContentForTable
{
    self.rightView.rightArray = self.rightArr;
    self.leftView.leftArr = self.leftArr;
    
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    for (UIView *view in self.subviews) {
        view.backgroundColor = [UIColor whiteColor];
        for (UIView *view_ in view.subviews) {
            view_.backgroundColor = [UIColor whiteColor];
            
        }
    }
    self.backgroundColor = [UIColor whiteColor];
    self.showsVerticalScrollIndicator = NO;
    self.showsHorizontalScrollIndicator = NO;
    self.clipsToBounds = YES;
   
    //   左部
    self.leftView = [[ExcelLeftView alloc] initWithFrame:CGRectMake(0, 0, leftWidth, self.frame.size.height)];
    self.leftView.tableV.bounces = NO;
//    self.leftView.topString = _topString;
    self.leftView.leftArr = self.leftArr;
    self.leftView.delegate = self;
    self.leftView.fontType = self.fontNumberLeftItem;
    self.leftView.fontRightTop = self.fontNumberTopItem;
    
    [self addSubview:self.leftView];
    
    //   右部
    self.rightView = [[ExcelRightView alloc] initWithFrame:CGRectMake(leftWidth, 0, self.frame.size.width - leftWidth, self.frame.size.height)];
    self.rightView.rightTableV.bounces = NO;
    self.rightView.rightArray = self.rightArr;
    self.rightView.headerNumber = self.topNumber;
    self.rightView.delegate = self;
    self.rightView.fontType = self.fontNumberRithtItem;
    self.rightView.fontNumberTopItem = self.fontNumberTopItem;
    [self addSubview:self.rightView];
    
    
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    UIView *view = [super hitTest:point withEvent:event];
    if (([view isKindOfClass:[ExcelContentView class]])) {
        return self.rightView.rightTableV;
    }
    return view;
    
    return self.leftView.tableV;//[super hitTest:point withEvent:event];
}

- (void)rightTableViewDidScroll:(ExcelRightView *)rightView
{
    if (self.delegate_content != nil) {
        if ([self.delegate_content respondsToSelector:@selector(didTableViewSlidingForContentView:)]) {
            [self.delegate_content didTableViewSlidingForContentView:self];
        }
    }
    
}


@end
