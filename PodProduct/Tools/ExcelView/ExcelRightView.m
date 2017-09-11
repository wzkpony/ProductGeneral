//
//  ExcelViewRightView.m
//  PodProduct
//
//  Created by wzk on 2017/9/11.
//  Copyright © 2017年 wzk. All rights reserved.
//


#import "ExcelRightView.h"
#import "Constant.h"
#import "SubtypeView.h"
#import "ExcelCell.h"
#import "MJRefresh.h"

@interface ExcelRightView()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UIView *headView;
@property (nonatomic, strong) NSArray *topArr;
@end
@implementation ExcelRightView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    self.backgroundColor = [UIColor whiteColor];
    [self prepareLayout];
}

- (instancetype)initWithFrame:(CGRect)frame withTopArr:(NSArray*)topArray{
    
    if (self = [super initWithFrame:frame]) {
        self.topArr = topArray;
    }
    
    return self;
}
- (void)prepareLayout {
    //    头部
    NSInteger columnNumber =  _topArr.count;
    UIView *headview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, mWidth * columnNumber, mHeight)];
    
    self.headView = headview;
    
    self.headView.backgroundColor = [UIColor whiteColor];//边框颜色
    
    for(int i = 0; i < columnNumber; i++){
        
        SubtypeView *head=[[SubtypeView alloc]initWithFrame:CGRectMake(i * (mWidth + 0.5), 0, mWidth - 0.5, mHeight - 1)];
        
        head.font = self.fontNumberTopItem;
        head.text = self.topArr[i];
        [self.headView addSubview:head];
    }
    
    //    右部
    self.rightTableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, mWidth * columnNumber+addWidthSize, _rightArray.count*cellHeight + mHeight) style:(UITableViewStylePlain)];
    
    self.myScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, _rightArray.count*cellHeight + mHeight)];
    self.myScrollView.backgroundColor = [UIColor whiteColor];
    [self.myScrollView addSubview: self.rightTableV];
    self.rightTableV.delegate = self;
    self.rightTableV.dataSource = self;
    
    [self.rightTableV registerClass:[ExcelCell class] forCellReuseIdentifier:@"ExcelCell"];
    self.rightTableV.scrollEnabled = NO;
    self.rightTableV.showsVerticalScrollIndicator = NO;
    self.rightTableV.showsHorizontalScrollIndicator = NO;
    self.rightTableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:self.myScrollView];
    self.myScrollView.contentSize=CGSizeMake(mWidth * columnNumber+addWidthSize, 0);
    
}

//-(void)endMjrefresh
//{
//    [self.myScrollView.mj_header endRefreshing];
//    [self.myScrollView.mj_footer endRefreshing];
//}

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
    cell.fontType = self.fontType;
    cell.sourceArr = _rightArray[indexPath.row];
    return cell;
}

@end
