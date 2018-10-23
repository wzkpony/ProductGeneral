//
//  BlueSuccessViewController.h
//  PodProduct
//
//  Created by wzk on 2018/10/22.
//  Copyright © 2018年 wzk. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface BlueSuccessViewController : BaseViewController
@property (nonatomic, copy)void(^sendData)(NSString *dataString);
@end

NS_ASSUME_NONNULL_END
