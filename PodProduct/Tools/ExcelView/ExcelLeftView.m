//
//  ExcelLeftView.m
//
//
//  Created by df on 2017/6/21.
//  Copyright © 2017年 Dyf. All rights reserved.
//

#import "ExcelLeftView.h"

#import "Constant.h"

@interface ExcelLeftView ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation ExcelLeftView


- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self prepareLayout];
    }
    
    return self;
}

- (void)prepareLayout {
        
    self.tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) style:(UITableViewStylePlain)];
    
    self.tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:self.tableV];
    
    self.tableV.delegate = self;
    
    self.tableV.dataSource = self;
    self.tableV.backgroundColor = [UIColor whiteColor];
    
    self.tableV.showsVerticalScrollIndicator = NO;
    self.tableV.showsHorizontalScrollIndicator = NO;
        
    [self.tableV registerClass:[ExcelLeftCell class] forCellReuseIdentifier:@"ExcelLeftCell"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.leftArr.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    SubtypeView* label = [[SubtypeView alloc] initWithFrame:CGRectMake(0, 0, leftWidth, mHeight)];
    label.font = self.fontRightTop;
    label.text = _topString;
    [self addSubview:label];
    return label;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ExcelLeftCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ExcelLeftCell" forIndexPath:indexPath];
    cell.subtypeView.font = self.fontType;
    cell.subtypeView.text = self.leftArr[indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return mHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return cellHeight;
}

//同步左侧右侧
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (self.delegate != nil) {
        if ([self.delegate respondsToSelector:@selector(tableViewDidScroll:)]) {
            [self.delegate tableViewDidScroll:self];
        }
    }
}

@end

@implementation ExcelLeftCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        self.subtypeView = [[SubtypeView alloc] initWithFrame:CGRectMake(0, 0, leftWidth - 1, cellHeight - 1)];
        
        self.subtypeView.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self.contentView addSubview:self.subtypeView];
        
    }
    
    return self;
}

@end
