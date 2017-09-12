//
//  ExcelViewRightView.h
//  PodProduct
//
//  Created by wzk on 2017/9/11.
//  Copyright © 2017年 wzk. All rights reserved.
//
/**
 *
 *ExcelRightView  里面存放一个UIScrollView
 *UIScrollView中又存放一个tableView，使tableView可以左右滑动
 *
 *tableView是一列表呈现，上下话动并不在这个tableView上作用，而是在ExcelContentView作用滑动
 *
 *
 *
 */

#import <UIKit/UIKit.h>
#import "SubtypeView.h"

@interface ExcelRightView : UIView
@property (nonatomic, strong) UIScrollView *myScrollView;
@property (nonatomic, strong) UITableView *rightTableV;//右边列表
@property (nonatomic, strong)UIFont *fontType;
@property (nonatomic, strong)UIFont *fontNumberTopItem;
@property (nonatomic, strong) NSArray *rightArray;
@property (nonatomic, assign)NSInteger headerNumber;
@property (nonatomic, assign)id delegate;

@end
@protocol ExcelRightViewDelegate <NSObject>

- (void)rightTableViewDidScroll:(ExcelRightView *)rightView;

@end

