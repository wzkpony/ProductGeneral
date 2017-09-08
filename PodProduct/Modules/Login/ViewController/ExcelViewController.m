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


@interface ExcelViewController ()
{
    
}

//@property (nonatomic, strong) UITableView *rightTableV;
//
//@property (nonatomic, strong) ExcelLeftView *leftView;
//
//@property (nonatomic, strong) UIView *headView;
//
//@property (nonatomic, strong) NSMutableArray *topArr;
//
//@property (nonatomic, strong) NSArray *leftArr;
//
//@property (nonatomic, strong) NSMutableArray *sourceArray;

@end

@implementation ExcelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;

    ExcelView* e_view = [[ExcelView alloc] init];
    e_view.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    e_view.delegate = self;
    e_view.fontNumberTopItem = [UIFont systemFontOfSize:14];
    e_view.fontNumberLeftItem = [UIFont systemFontOfSize:14];
    e_view.fontNumberRithtItem = [UIFont systemFontOfSize:14];
    [self.view addSubview:e_view];
    
    
   
    
}
-(NSArray* )excelViewForTopArr:(ExcelView*)excelView
{
    return @[@"注册时间",@"手机号码",@"邀请码",@"身份证号"];
}
-(NSArray* )excelViewForLeftArr:(ExcelView*)excelView
{
    return @[@"周云",@"老董",@"王正魁",@"潘章宝",@"崔娜",@"熊素平",@"张文超",@"余昭阳",@"李志",@"张龙",@"结束啦",@"结束啦",@"结束啦",@"结束啦"];
}
-(NSArray* )excelViewForRightArr:(ExcelView*)excelView
{
    NSMutableArray *arrayS = [[NSMutableArray alloc] initWithCapacity:0];
    NSArray *array = @[@"周云",@"老董",@"王正魁",@"潘章宝",@"崔娜",@"熊素平",@"张文超",@"余昭阳",@"李志",@"张龙",@"结束啦",@"结束啦",@"结束啦",@"结束啦"];
    for (int i = 0; i<array.count; i++) {
        [arrayS addObject:@[@"2017-09-07",@"183****7143",@"aB84dgH0k9",@"410526*******6994"]];
    }
    return arrayS;
}
-(NSString* )excelViewForRightTopString:(ExcelView*)excelView
{
    return @"客户姓名";
}
@end
