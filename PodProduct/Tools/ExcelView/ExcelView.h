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
#import "Constant.h"
@class ExcelView;
@protocol ExcelViewDelegate <NSObject>

@required
/*
 *  excelViewForTopArr                    顶部的数据源
 *  excelViewForLeftArr                   左边tableView的数据源
 *  excelViewForRightArr                  有边tableView的数据源
 *  excelViewForRightTopString            左上角的文本数据源
 *
 */
-(NSArray* )excelViewForTopArr:(ExcelView*)excelView;
-(NSArray* )excelViewForLeftArr:(ExcelView*)excelView;
-(NSArray* )excelViewForRightArr:(ExcelView*)excelView;

-(NSString* )excelViewForRightTopString:(ExcelView*)excelView;

@end



@interface ExcelView : UIScrollView


@property (nonatomic, assign) id<ExcelViewDelegate> excel_delegate;
@property (nonatomic, strong) UIFont *fontNumberTopItem;      //顶部文本字体大小
@property (nonatomic, strong) UIFont *fontNumberLeftItem;     //左边文本字体大小
@property (nonatomic, strong) UIFont *fontNumberRithtItem;    //右边文本字体大小



-(void)reloadDtaeForTableView;
@end




