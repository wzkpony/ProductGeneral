//
//  ExcelContentView.h
//  PodProduct
//
//  Created by wzk on 2017/9/12.
//  Copyright © 2017年 wzk. All rights reserved.
//
/**
 *
 *ExcelContentView 一个UIScrollView 里面存放ExcelRightView和ExcelLeftView
 *
 *ExcelContentView 为一个弹性页面，可以增加下拉刷新和加在更多实用
 *
 *ExcelContentView 是整个页面左右页面合在一起的页面，上下滑动和下拉刷新都在ExcelContentView上作用
 *
 *
 */

#import <UIKit/UIKit.h>
#import "ExcelLeftView.h"
#import "ExcelRightView.h"
#import "Constant.h"

@interface ExcelContentView : UIScrollView

@property (nonatomic, strong) ExcelLeftView *leftView;//左边列表
@property (nonatomic,strong)  ExcelRightView *rightView;//右边列表

@property (nonatomic, strong) UIFont *fontNumberLeftItem;     //左边文本字体大小
@property (nonatomic, strong) UIFont *fontNumberRithtItem;    //右边文本字体大小
@property (nonatomic, strong) UIColor *rightTextColor;         //右边字体颜色
@property (nonatomic, strong) UIColor *leftTextColor;          //左边字体颜色


@property (nonatomic, strong)NSArray* leftArr;//左边tableView的数据源
@property (nonatomic, strong)NSArray* rightArr;//右边tableView的数据源
//@property (nonatomic, copy)NSString* topString;//左上角的文本数据源
@property (nonatomic, assign) NSInteger topNumber;

@property (nonatomic, assign)id delegate_content;


-(void)reloadDtaeForTableView;//刷新数据源

@end
@protocol ExcelContentViewDelegate <NSObject>
/**
 *
 *滚动右边列表（左右滑动时）回调的方法
 *
 */
- (void)didTableViewSlidingForContentView:(ExcelContentView *)contentView;
@end
