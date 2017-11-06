//
//  ExcelCell.m
//
//
//  Created by df on 2017/6/21.
//  Copyright © 2017年 Dyf. All rights reserved.
//

#import "ExcelCell.h"

#import "SubtypeView.h"

#import "Constant.h"

@interface ExcelCell ()

@end

@implementation ExcelCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor whiteColor];
    }
    
    return self;
}


- (void)setSourceArr:(NSArray *)sourceArr {
    for (UIView* view in self.contentView.subviews) {
        [view removeFromSuperview];
    }
    for (int i = 0; i < sourceArr.count; i++) {
        
        SubtypeView *headView=[[SubtypeView alloc]initWithFrame:CGRectMake(i * (mWidth), 0, mWidth, cellHeight)];
        
        headView.font = self.fontType;
        headView.textColor = self.textColors;
        headView.text = [NSString stringWithFormat:@"%@",sourceArr[i]];
        if (i == sourceArr.count - 1) {
            headView.frame = CGRectMake(i * (mWidth), 0, mWidth + addWidthSize, cellHeight);
            
        }
        headView.backgroundColor = [UIColor clearColor];
    
        [self.contentView addSubview:headView];
    }
    
}

@end
