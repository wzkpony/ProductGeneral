//
//  ExcelView.m
//  ExcelTabel
//
//  Created by wzk on 2017/9/6.
//  Copyright © 2017年 df. All rights reserved.
//

#import "ExcelView.h"
#import "SubtypeView.h"
#import "ExcelCell.h"

#import "MJRefresh.h"
#import "Constant.h"
@interface ExcelView()

@property (nonatomic, strong) UIView *headView;

@property (nonatomic, strong) NSArray *topArr;

@property (nonatomic, strong) NSArray *leftArr;

@property (nonatomic, strong) NSArray *rightArray;

@end
@implementation ExcelView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    self.backgroundColor = [UIColor whiteColor];
    
    
    if (self.delegate == nil) {
        return;
    }
    _topArr = [self.delegate excelViewForTopArr:self];
    _leftArr = [self.delegate excelViewForLeftArr:self];
    _rightArray = [self.delegate excelViewForRightArr:self];
    NSString* topString = [self.delegate excelViewForRightTopString:self];
    
    //    头部
    NSInteger columnNumber =  _topArr.count;
    UIView *headview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, mWidth * columnNumber, mHeight)];
    
    self.headView = headview;
    
    self.headView.backgroundColor = [UIColor whiteColor];//边框颜色
    
    for(int i = 0; i < columnNumber; i++){
        
        SubtypeView *head=[[SubtypeView alloc]initWithFrame:CGRectMake(i * (mWidth + 0.5), 0, mWidth - 0.5, mHeight - 1)];
        
        head.backgroundColor = [UIColor whiteColor];
        head.font = self.fontNumberTopItem;
        head.text = self.topArr[i];
        [self.headView addSubview:head];
    }
    
    //   左部
    self.leftView = [[ExcelLeftView alloc] initWithFrame:CGRectMake(0, 64, leftWidth, ScreenHeight-64)];
    self.leftView.leftArr = self.leftArr;
    self.leftView.delegate = self;
    self.leftView.fontType = self.fontNumberLeftItem;
    self.leftView.fontRightTop = self.fontNumberTopItem;
    self.leftView.backgroundColor = [UIColor whiteColor];
    self.leftView.topString = topString;
    [self addSubview:self.leftView];
    
    //    右部
    self.rightTableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, mWidth * columnNumber+addWidthSize, ScreenHeight - 64) style:(UITableViewStylePlain)];
    self.rightTableV.backgroundColor = [UIColor whiteColor];
    self.rightTableV.delegate = self;
    self.rightTableV.dataSource = self;
    self.rightTableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.rightTableV registerClass:[ExcelCell class] forCellReuseIdentifier:@"ExcelCell"];
    
    self.rightTableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        NSLog(@"刷新了");
    }];
    self.rightTableV.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        //Call this Block When enter the refresh status automatically
        NSLog(@"加载了");
    }];
    
    
    UIScrollView *myScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(leftWidth, 64, ScreenWidth - leftWidth, ScreenHeight)];
    myScrollView.backgroundColor = [UIColor whiteColor];
    [myScrollView addSubview: self.rightTableV];
    
    myScrollView.contentSize=CGSizeMake(self.rightTableV.frame.size.width, 0);
    
    [self addSubview:myScrollView];

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _rightArray.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return cellHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    return self.headView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return mHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ExcelCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ExcelCell" forIndexPath:indexPath];
    cell.fontType = self.fontNumberRithtItem;
    cell.sourceArr = _rightArray[indexPath.row];
    return cell;
}

//同步左侧右侧
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat offsetY = self.rightTableV.contentOffset.y;
    
    CGPoint timeOffsetY = self.leftView.tableV.contentOffset;
    
    timeOffsetY.y = offsetY;
    
    self.leftView.tableV.contentOffset = timeOffsetY;
    
    if(offsetY == 0) {
        
        self.leftView.tableV.contentOffset=CGPointZero;
    }
}
- (void)tableViewDidScroll:(ExcelLeftView *)leftView
{
    CGFloat offsetY = leftView.tableV.contentOffset.y;
    
    CGPoint timeOffsetY = self.rightTableV.contentOffset;
    
    timeOffsetY.y = offsetY;
    
    self.rightTableV.contentOffset = timeOffsetY;
    
    if(offsetY == 0) {
        
        self.rightTableV.contentOffset=CGPointZero;
    }
}


@end
