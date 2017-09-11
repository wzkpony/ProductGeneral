//
//  ExcelViewRightView.h
//  PodProduct
//
//  Created by wzk on 2017/9/11.
//  Copyright © 2017年 wzk. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "SubtypeView.h"

@interface ExcelRightView : UIView
@property (nonatomic, strong) UIScrollView *myScrollView;
@property (nonatomic, strong) UITableView *rightTableV;//右边列表
@property (nonatomic, strong)UIFont *fontType;
@property (nonatomic, strong)UIFont *fontNumberTopItem;
@property (nonatomic, strong) NSArray *rightArray;

@property (nonatomic, assign)id delegate;


- (instancetype)initWithFrame:(CGRect)frame withTopArr:(NSArray*)topArray;

@end
@protocol ExcelRightViewDelegate <NSObject>

- (void)rightTableViewDidScroll:(ExcelRightView *)rightView;

@end

