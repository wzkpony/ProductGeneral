//
//  ExcelLeftView.h
//  
//
//  Created by df on 2017/6/21.
//  Copyright © 2017年 Dyf. All rights reserved.
//

/**
 *
 *
 *ExcelLeftView 左侧列表 
 *
 *
 */



#import <UIKit/UIKit.h>
#import "SubtypeView.h"

@interface ExcelLeftView : UIView

@property (nonatomic, strong) UITableView *tableV;
@property (nonatomic, strong) NSArray *leftArr;
@property (nonatomic, assign)id delegate;
@property (nonatomic, strong)UIFont *fontType;
@property (nonatomic, strong) UIColor *leftTextColor;          //左边字体颜色



@end
@protocol ExcelLeftViewDelegate <NSObject>

@end
@interface ExcelTestCell : UITableViewCell

@property (nonatomic, strong) SubtypeView *subtypeView;
@end

