//
//  IconFontLabel.m
//  QuarkCobraProject
//
//  Created by Zhengkui Wang  on 16/5/11.
//  Copyright © 2016年 Jingnan Zhang. All rights reserved.
//

#import "IconFontImageView.h"

@implementation IconFontImageView

-(void)setFontSize:(NSInteger)fontSize
{
    _fontSize = fontSize;
    UIFont *iconfont = [UIFont fontWithName:@"IconFont" size: _fontSize];
    self.font = iconfont;
    self.text = [NSString stringWithFormat:@"%@",_imageName];
}
-(NSInteger)getFontSize
{
    return _fontSize;
}

-(void)setImageName:(NSString *)imageName
{
    _imageName = imageName;
    if (_fontSize == 0) {
        _fontSize = 14;
    }
 
    UIFont *iconfont = [UIFont fontWithName:@"IconFont" size: _fontSize];
    self.font = iconfont;
    self.text = [NSString stringWithFormat:@"%@",imageName];
}
-(void)boundsWidthOfContent
{
    CGSize size = [self sizeThatFits:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    CGRect rectlabel = self.frame;
    rectlabel.size.width = size.width;
    rectlabel.size.height = size.height;
    self.bounds = rectlabel;
    
}

-(void)addTargetTap:(id)obj action:(SEL)action
{
    if (obj != nil) {
        if ([obj respondsToSelector:action]) {
            UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:obj action:action];
            self.userInteractionEnabled = YES;
            [self addGestureRecognizer:tap];
            
        }
        
    }
}
@end
