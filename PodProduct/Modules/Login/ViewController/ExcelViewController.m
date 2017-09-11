//
//  ExcelViewController.m
//
//
//  Created by df on 2017/6/20.
//  Copyright © 2017年 Dyf. All rights reserved.
//

#import "ExcelViewController.h"
#import "SubtypeView.h"
#import "ExcelLeftView.h"
#import "Constant.h"
#import "ExcelView.h"
#import "MJRefresh.h"

@interface ExcelViewController ()<ExcelViewDelegate>
{
    ExcelView* e_view;
    NSMutableArray *dataArray;
}



@end

@implementation ExcelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //    self.automaticallyAdjustsScrollViewInsets = NO;
    dataArray = [[NSMutableArray alloc] initWithArray:@[@"周云",@"老董",@"王正魁",@"潘章宝",@"崔娜",@"熊素平",@"张文超",@"余昭阳",@"李志",@"张龙",@"结束啦",@"结束啦",@"结束啦",@"结束啦"]];
    e_view = [[ExcelView alloc] init];
    e_view.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    e_view.excel_delegate = self;
    e_view.contentSize = CGSizeMake(ScreenWidth, dataArray.count * cellHeight + mHeight);
    e_view.fontNumberTopItem = [UIFont systemFontOfSize:14];
    e_view.fontNumberLeftItem = [UIFont systemFontOfSize:14];
    e_view.fontNumberRithtItem = [UIFont systemFontOfSize:14];
    [self.view addSubview:e_view];
    
    
    e_view.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        NSLog(@"刷新了");
         dataArray = [[NSMutableArray alloc] initWithArray:@[@"周云",@"老董",@"王正魁",@"潘章宝",@"崔娜",@"熊素平",@"张文超",@"余昭阳",@"李志",@"张龙",@"结束啦",@"结束啦",@"结束啦",@"结束啦"]];
        [self performSelector:@selector(endMjrefresh) withObject:self afterDelay:2];
    }];
    e_view.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        //Call this Block When enter the refresh status automatically
        [dataArray addObjectsFromArray:@[@"周云",@"老董",@"王正魁",@"潘章宝",@"崔娜",@"熊素平",@"张文超",@"余昭阳",@"李志",@"张龙",@"结束啦",@"结束啦",@"结束啦",@"结束啦"]];
        
        [self performSelector:@selector(endMjrefresh) withObject:self afterDelay:2];
        NSLog(@"加载了");
    }];
    
    
}
-(void)endMjrefresh
{
    e_view.contentSize = CGSizeMake(ScreenWidth, dataArray.count * cellHeight + mHeight);
    [e_view.mj_header endRefreshing];
    [e_view.mj_footer endRefreshing];
    [e_view reloadDtaeForTableView];
    

}
-(NSArray* )excelViewForTopArr:(ExcelView*)excelView
{
    return @[@"注册时间",@"手机号码",@"邀请码",@"身份证号"];
}
-(NSArray* )excelViewForLeftArr:(ExcelView*)excelView
{
    return dataArray;
}
-(NSArray* )excelViewForRightArr:(ExcelView*)excelView
{
    NSMutableArray *arrayS = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i = 0; i<dataArray.count; i++) {
        [arrayS addObject:@[@"2017-09-07",@"183****7143",@"aB84dgH0k9",@"410526*******6994"]];
    }
    return arrayS;
}
-(NSString* )excelViewForRightTopString:(ExcelView*)excelView
{
    return @"客户姓名";
}
@end
