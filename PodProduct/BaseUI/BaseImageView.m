//
//  BaseImageView.m
//  PodProduct
//
//  Created by wzk on 2017/6/13.
//  Copyright © 2017年 wzk. All rights reserved.
//

#import "BaseImageView.h"

@implementation BaseImageView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)setNetImageUrl:(NSString *)netImageUrl
{
    if (_netImageUrl != netImageUrl) {
        _netImageUrl = netImageUrl;
        [self sd_setImageWithURL:[NSURL URLWithString:netImageUrl] placeholderImage:[UIImage imageNamed:_defaultImageName]];
    }
    
    
}
-(void)setDefaultImageName:(NSString *)defaultImageName
{
    if (_defaultImageName != defaultImageName) {
        _defaultImageName = defaultImageName;
        
        if ((_netImageUrl == nil)||([_netImageUrl isEqualToString:@""])) {
            self.image = [UIImage imageNamed:defaultImageName];
        }
       
    }
    
}
@end
