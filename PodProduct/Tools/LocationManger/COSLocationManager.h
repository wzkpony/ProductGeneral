//
//  COSLocationManager.h
//  COSCOEBProject
//
//  Created by Eve on 2018/11/26.
//  Copyright © 2018 COSCO. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^LocationSuccessBlock)(float lat, float lng, NSError * __nullable error);
@interface COSLocationManager : NSObject
SINGLETON_FOR_HEADER(COSLocationManager)
/// 开始定位
- (void)startLocation:(LocationSuccessBlock)locationBlock;
/// 停止进行定位
- (void)stopLocation;
@end

NS_ASSUME_NONNULL_END
