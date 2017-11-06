//
//  ExcelView.h
//  ExcelTabel
//
//  Created by wzk on 2017/9/6.
//  Copyright © 2017年 df. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExcelLeftView.h"
#import "ExcelRightView.h"
#import "ExcelContentView.h"
#import "Constant.h"
#import "MJRefresh.h"
@interface ExcelView : UIView
@property (nonatomic, assign)id excel_delegate;


@property (nonatomic, strong) ExcelContentView* contentView;
@property (nonatomic, strong) UIScrollView *headview;
@property (nonatomic, strong) UIFont *fontType;                //左上角文本字体
@property (nonatomic, strong) UIFont *fontNumberTopItem;      //顶部文本字体大小
@property (nonatomic, strong) UIFont *fontNumberLeftItem;     //左边文本字体大小
@property (nonatomic, strong) UIFont *fontNumberRithtItem;    //右边文本字体大小
@property (nonatomic, strong) UIColor *rightTextColor;         //右边字体颜色
@property (nonatomic, strong) UIColor *leftTextColor;          //左边字体颜色
@property (nonatomic, strong) UIColor *topTextColor;           //上边字体颜色
-(void)reloadDate:(NSMutableArray *)obj;                                            //刷新页面


@end

@protocol ExcelViewDelegate <NSObject>

/*
 *  excelViewForTopArr                    顶部的数据源
 *  excelViewForLeftArr                   左边tableView的数据源
 *  excelViewForRightArr                  有边tableView的数据源
 *  excelViewForRightTopString            左上角的文本数据源
 *
 */
-(NSArray* )excelViewForLeftArr:(ExcelView*)excelView;
-(NSArray* )excelViewForRightArr:(ExcelView*)excelView;
-(NSArray* )excelViewForTopArr:(ExcelView*)excelView;
-(NSString* )excelViewForRightTopString:(ExcelView*)excelView;

//下拉刷新加在更多代理回调
-(void)pullDownRefresh;//下拉刷新
-(void)addInMore;//加在更多


@end


