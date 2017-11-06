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
//@property (nonatomic, strong) UIView *headView;
@end
@implementation ExcelRightView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [self prepareLayout];
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
    }
    
    return self;
}
- (void)prepareLayout {
    
    NSInteger columnNumber =  self.headerNumber;    
    //    右部
    self.rightTableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, mWidth * columnNumber+addWidthSize, _rightArray.count*cellHeight) style:(UITableViewStylePlain)];
    self.rightTableV.backgroundColor = [UIColor whiteColor];
   
    self.rightTableV.delegate = self;
    self.rightTableV.dataSource = self;


    
    [self.rightTableV registerClass:[ExcelCell class] forCellReuseIdentifier:@"ExcelCell"];
    self.rightTableV.scrollEnabled = NO;
    self.rightTableV.showsVerticalScrollIndicator = NO;
    self.rightTableV.showsHorizontalScrollIndicator = NO;
    self.rightTableV.separatorStyle = UITableViewCellSeparatorStyleNone;
   
    self.myScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, _rightArray.count*cellHeight)];
    self.myScrollView.backgroundColor = [UIColor whiteColor];
    for (UIView *view in self.myScrollView.subviews) {
        view.backgroundColor = [UIColor whiteColor];
    }
    self.myScrollView.delegate = self;
    self.myScrollView.tag = 1;
  
    self.myScrollView.showsVerticalScrollIndicator = NO;
    self.myScrollView.showsHorizontalScrollIndicator = NO;
    self.myScrollView.backgroundColor = [UIColor whiteColor];
    [self.myScrollView addSubview: self.rightTableV];
    [self addSubview:self.myScrollView];
    self.myScrollView.contentSize=CGSizeMake(mWidth * columnNumber+addWidthSize+layerRightWidth, 0);
   
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _rightArray.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return cellHeight;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ExcelCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ExcelCell" forIndexPath:indexPath];
    cell.fontType = self.fontType;
    cell.sourceArr = _rightArray[indexPath.row];
    cell.textColors = _rightTextColor;
    if (indexPath.row % 2 == 0) {
        cell.contentView.backgroundColor = pairNumber ;
         cell.backgroundColor = pairNumber ;
    } else {
        cell.contentView.backgroundColor = singleNumber ;
        cell.backgroundColor = singleNumber ;
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"点击tableviewcell");
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.tag == 1) {
        if (self.delegate != nil) {
            if ([self.delegate respondsToSelector:@selector(rightTableViewDidScroll:)]) {
                [self.delegate rightTableViewDidScroll:self];
            }
        }
    }
}
@end
