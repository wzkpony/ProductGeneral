//
//  IconFontLabel.h
//  QuarkCobraProject
//
//  Created by Zhengkui Wang  on 16/5/11.
//  Copyright © 2016年 Jingnan Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IconFontImageView : UILabel

@property(nonatomic,assign)IBInspectable NSInteger fontSize;//图片大小
@property(nonatomic,copy) NSString* imageName;//图片名字

-(void)boundsWidthOfContent;//自适应图片大小


-(void)addTargetTap:(id)obj action:(SEL)action;//添加事件
@end
