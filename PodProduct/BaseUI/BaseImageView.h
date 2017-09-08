//
//  BaseImageView.h
//  PodProduct
//
//  Created by wzk on 2017/6/13.
//  Copyright © 2017年 wzk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PodLibraryHeader.h"

/**
* netImageUrl      image的Url地址。
* defaultImageName  image加载网络图片时的默认图片。
*
*/

@interface BaseImageView : UIImageView

@property(nonatomic,strong)NSString* netImageUrl;
@property(nonatomic,strong)NSString* defaultImageName;
@end
