//
//  LTSCircleView.h
//  LTSCalendar
//
//  Created by Jonathan Tribouharet
//

#import "LTSCircleView.h"

@implementation LTSCircleView

- (instancetype)init
{
    self = [super init];
    if(!self){
        return nil;
    }
    
    self.backgroundColor = [UIColor clearColor];
    self.color = [UIColor whiteColor];
    
    return self;
}


- (void)drawRect:(CGRect)rect
{
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(ctx, [self.backgroundColor CGColor]);
    CGContextFillRect(ctx, rect);

    CGContextSetStrokeColorWithColor(ctx, [self.color CGColor]);
    CGContextSetFillColorWithColor(ctx, [self.color CGColor]);
    
    if (rect.size.width==38) {
        /*画圆角矩形*/
        float fw = rect.size.width;
        float fh = rect.size.height;
        
        CGContextMoveToPoint(ctx, fw, fh-2);  // 开始坐标右边开始
        CGContextAddArcToPoint(ctx, fw, fh, fw-2, fh, 2);  // 右下角角度
        CGContextAddArcToPoint(ctx, 2, fh, 2, fh-2, 2); // 左下角角度
        CGContextAddArcToPoint(ctx, 2, 0, fw-2, 0, 2); // 左上角
        CGContextAddArcToPoint(ctx, fw, 0, fw, fh-2, 2); // 右上角
        CGContextClosePath(ctx);
        CGContextDrawPath(ctx, kCGPathFillStroke); //根据坐标绘制路径
    }else{
        rect = CGRectInset(rect, .5, .5);
        CGContextAddEllipseInRect(ctx, rect);
        CGContextFillEllipseInRect(ctx, rect);
    }
    
    
    
    
    CGContextFillPath(ctx);
}

- (void)setColor:(UIColor *)color
{
    self->_color = color;
    
    [self setNeedsDisplay];
}

@end
