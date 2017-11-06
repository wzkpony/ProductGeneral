//
//  ExcelLeftView.m
//
//
//  Created by df on 2017/6/21.
//  Copyright © 2017年 Dyf. All rights reserved.
//

#import "ExcelLeftView.h"
#import "Constant.h"

@interface ExcelLeftView()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation ExcelLeftView

- (void)drawRect:(CGRect)rect {
    // Drawing code
    self.backgroundColor = [UIColor whiteColor];
    [self prepareLayout];
}
- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
    }
    
    return self;
}

- (void)prepareLayout {
    
    self.tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, cellHeight * self.leftArr.count) style:(UITableViewStylePlain)];
    
    self.tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:self.tableV];
    //    self.tableV.bounces = YES;
    self.tableV.delegate = self;
    self.tableV.dataSource = self;
    self.tableV.scrollEnabled = NO;
    self.tableV.showsVerticalScrollIndicator = NO;
    self.tableV.showsHorizontalScrollIndicator = NO;
    
    UIView * vi = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableV.frame.size.width, 1)] ;
    vi.backgroundColor = [UIColor groupTableViewBackgroundColor] ;
    [self.tableV addSubview:vi] ;
    
    

    
    [self.tableV registerClass:[ExcelTestCell class] forCellReuseIdentifier:@"ExcelTestCell"];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.leftArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ExcelTestCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ExcelTestCell" forIndexPath:indexPath];
    cell.subtypeView.font = self.fontType;
    cell.subtypeView.text = [NSString stringWithFormat:@"%@",self.leftArr[indexPath.row]];
    cell.subtypeView.textColor = self.leftTextColor;
    NSInteger index = indexPath.row%2;
    if (index == 0) {
        cell.backgroundColor = pairNumber;
        cell.contentView.backgroundColor = pairNumber;
    }
    else
    {
        cell.backgroundColor = singleNumber;
        cell.contentView.backgroundColor = singleNumber;
    }
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return cellHeight;
}

@end

@implementation ExcelTestCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        CAGradientLayer * vi1 = [self generateLayer];
//        vi1.shadowRadius = 4;
//        vi1.shadowColor = [UIColor grayColor].CGColor;
//        vi1.shadowOpacity = 1;
//        vi1.backgroundColor = [UIColor groupTableViewBackgroundColor].CGColor ;
//        vi1.shadowOffset = CGSizeMake(4,0);
        
        self.subtypeView = [[SubtypeView alloc] initWithFrame:CGRectMake(0, 0, leftWidth - 1, cellHeight - 1)];
        self.subtypeView.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self.contentView addSubview:self.subtypeView];
        [self.contentView.layer addSublayer:vi1];
        
    }
    
    return self;
}
- (CAGradientLayer *)generateLayer{
    CAGradientLayer *gradientLayer1 = [CAGradientLayer layer];
    gradientLayer1.frame = CGRectMake(leftWidth-layerLineWidth, 0, layerLineWidth,  cellHeight);
    gradientLayer1.colors = @[(__bridge id)[UIColor colorWithRed:219/255.0 green:219/255.0 blue:219/255.0 alpha:1].CGColor, (__bridge id)[UIColor colorWithRed:219/255.0 green:219/255.0 blue:219/255.0 alpha:0].CGColor];
    
    gradientLayer1.startPoint = CGPointMake(0, 0);
    gradientLayer1.endPoint = CGPointMake(1, 0);
    return gradientLayer1;
}
@end
