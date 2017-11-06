//
//  ExcelView.m
//  ExcelTabel
//
//  Created by wzk on 2017/9/6.
//  Copyright © 2017年 df. All rights reserved.
//
#import "ExcelView.h"


@interface ExcelView()<UIScrollViewDelegate>
{
    NSArray* rightArray;
    NSArray* leftArray;
    NSArray* topArray;
    NSString* topString;
    
}

@end
@implementation ExcelView
-(void)reloadDate:(NSMutableArray *)obj
{
    if (!obj || !obj.count) {
        [self.contentView.mj_footer endRefreshingWithNoMoreData];
    } else {
        [self.contentView.mj_footer endRefreshing];
    }
    [self.contentView.mj_header endRefreshing];
//    [self.contentView.mj_footer endRefreshing];
    [self reloadDateContent];
    [self reloadUI];
    [_contentView reloadDtaeForTableView];
    
}
-(void)reloadDateContent
{
    leftArray = [self.excel_delegate excelViewForLeftArr:self];
    rightArray = [self.excel_delegate excelViewForRightArr:self];
    topArray = [self.excel_delegate excelViewForTopArr:self];
    topString = [self.excel_delegate excelViewForRightTopString:self];
    
}
-(void)reloadUI
{
    _contentView.fontNumberLeftItem = _fontNumberLeftItem?_fontNumberLeftItem:[UIFont systemFontOfSize:12];
    _contentView.fontNumberRithtItem = _fontNumberRithtItem?_fontNumberRithtItem:[UIFont systemFontOfSize:12];
    
    _contentView.leftArr = leftArray;
    _contentView.rightArr = rightArray;
    _contentView.topNumber = topArray.count;
    _contentView.contentSize = CGSizeMake(self.frame.size.width, rightArray.count * cellHeight);
}
- (void)drawRect:(CGRect)rect {
    
    if (self.excel_delegate == nil) {
        return;
    }
    [self reloadDateContent];
    
    if (_contentView == nil) {
        _contentView  = [[ExcelContentView alloc] init];
        _contentView.backgroundColor = [UIColor whiteColor];
    }
    _contentView.delegate_content = self;
    _contentView.frame = CGRectMake(0, mHeight, self.frame.size.width, self.frame.size.height-mHeight);
    [self reloadUI];
    _contentView.leftTextColor = _leftTextColor;
    _contentView.rightTextColor = _rightTextColor;
    
    [self addSubview:_contentView];
    
    _contentView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if (self.excel_delegate !=nil) {
            if ([self.excel_delegate respondsToSelector:@selector(pullDownRefresh)]) {
                [self.excel_delegate pullDownRefresh];
            }
        }
    }];
    _contentView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        //Call this Block When enter the refresh status automatically
        if (self.excel_delegate !=nil) {
            if ([self.excel_delegate respondsToSelector:@selector(addInMore)]) {
                [self.excel_delegate addInMore];
            }
        }
       
    }];


    NSInteger columnNumber =  topArray.count;
    //mWidth * columnNumber
    if (_headview == nil) {
         _headview = [[UIScrollView alloc] initWithFrame:CGRectMake(leftWidth, 0, self.frame.size.width-leftWidth, mHeight)];
    }
    _headview.backgroundColor = [UIColor whiteColor];//边框颜色
    for(int i = 0; i < columnNumber; i++){

        SubtypeView *head=[[SubtypeView alloc]initWithFrame:CGRectMake(i * (mWidth + 0.5), 0, mWidth - 0.5, mHeight - 1)];
        head.textColor = self.topTextColor;
        head.font = self.fontNumberTopItem?self.fontNumberTopItem:[UIFont systemFontOfSize:15];
        head.text = [NSString stringWithFormat:@"%@",topArray[i]];
        [_headview addSubview:head];
    }
    _headview.delegate = self;
    _headview.showsVerticalScrollIndicator = NO;
    _headview.showsHorizontalScrollIndicator = NO;
    _headview.contentSize = CGSizeMake(mWidth * columnNumber + layerRightWidth, mHeight);
    [self addSubview:_headview];
    
    //左上角用label呈现
    SubtypeView* label = [[SubtypeView alloc] initWithFrame:CGRectMake(0, 0, leftWidth, mHeight)];
    label.text = [NSString stringWithFormat:@"%@",topString];
    label.font = _fontNumberTopItem?_fontNumberTopItem:[UIFont systemFontOfSize:14];
    label.textColor = self.topTextColor;
    [self addSubview:label];
    CAGradientLayer* layer_ = [self generateLayerSubTypeView];
    [self.layer addSublayer:layer_];
    //左上角label的阴影
    CAGradientLayer* waveline = [self generateLayer];
    [self.layer addSublayer:waveline];
    
    
    
    UIView * line = [[UIView alloc] initWithFrame:CGRectMake(0, mHeight, self.frame.size.width, 1)] ;
    line.backgroundColor = [UIColor groupTableViewBackgroundColor] ;
    [self addSubview:line] ;
    
 
}
- (CAGradientLayer *)generateLayerSubTypeView{
    CAGradientLayer *gradientLayer1 = [CAGradientLayer layer];
    gradientLayer1.frame = CGRectMake(leftWidth-layerLineWidth, 0, layerLineWidth,  mHeight);
    gradientLayer1.colors = @[(__bridge id)[UIColor colorWithRed:219/255.0 green:219/255.0 blue:219/255.0 alpha:1].CGColor, (__bridge id)[UIColor colorWithRed:219/255.0 green:219/255.0 blue:219/255.0 alpha:0].CGColor];
    
    gradientLayer1.startPoint = CGPointMake(0, 0);
    gradientLayer1.endPoint = CGPointMake(1, 0);
    return gradientLayer1;
}
- (CAGradientLayer *)generateLayer{
    CAGradientLayer *gradientLayer1 = [CAGradientLayer layer];
    gradientLayer1.frame = CGRectMake(self.frame.size.width-layerRightWidth, 0, layerRightWidth,  self.frame.size.height-0);
    gradientLayer1.colors = @[(__bridge id)[UIColor colorWithRed:1 green:1 blue:1 alpha:0].CGColor, (__bridge id)[UIColor colorWithRed:1 green:1 blue:1 alpha:1].CGColor];

    gradientLayer1.startPoint = CGPointMake(0, 0);
    gradientLayer1.endPoint = CGPointMake(1, 0);
    return gradientLayer1;
}



- (void)didTableViewSlidingForContentView:(ExcelContentView *)contentView
{
    CGFloat offsetX =  _contentView.rightView.myScrollView.contentOffset.x;
    
    CGPoint timeOffsetX = _headview.contentOffset;
    
    timeOffsetX.x = offsetX;
    
    _headview.contentOffset = timeOffsetX;
    
    if(offsetX == 0) {
        
        _headview.contentOffset=CGPointZero;
        
    }

}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetX = scrollView.contentOffset.x;
    
    CGPoint timeOffsetX = _contentView.rightView.myScrollView.contentOffset;
    
    timeOffsetX.x = offsetX;
    
    _contentView.rightView.myScrollView.contentOffset = timeOffsetX;
    
    if(offsetX == 0) {
        
        _contentView.rightView.myScrollView.contentOffset=CGPointZero;
        
    }
  
    

}
@end
