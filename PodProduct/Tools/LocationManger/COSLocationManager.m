//
//  COSLocationManager.m
//  COSCOEBProject
//
//  Created by Eve on 2018/11/26.
//  Copyright © 2018 COSCO. All rights reserved.
//

#import "COSLocationManager.h"
#import <CoreLocation/CoreLocation.h>

@interface COSLocationManager ()<CLLocationManagerDelegate>
@property (nonatomic, copy) LocationSuccessBlock locationBlock; /** 定位block */
@property (nonatomic,strong ) CLLocationManager *locationManager;//定位服务
@property (nonatomic,copy)    NSString *currentCity;//城市
@property (nonatomic,copy)    NSString *strLatitude;//经度
@property (nonatomic,copy)    NSString *strLongitude;//维度

@end

@implementation COSLocationManager
SINGLETON_FOR_CLASS(COSLocationManager)


- (void)startLocation:(LocationSuccessBlock)locationBlock {
    
    if ([CLLocationManager locationServicesEnabled]) {
        _locationManager = [[CLLocationManager alloc]init];
        _locationManager.delegate = self;
        [_locationManager requestAlwaysAuthorization];
        _currentCity = [[NSString alloc]init];
        [_locationManager requestWhenInUseAuthorization];
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        _locationManager.distanceFilter = 5.0;
        [_locationManager startUpdatingLocation];
    }
    
    self.locationBlock = locationBlock;
}

- (void)stopLocation
{
    [self.locationManager stopUpdatingLocation];
}

#pragma mark - 定位失败
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    
    _locationBlock ? _locationBlock(0, 0, error) : nil;
    
//    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请在设置中打开定位" preferredStyle:UIAlertControllerStyleAlert];
//    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"打开定位" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        NSURL *settingURL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
//        [[UIApplication sharedApplication]openURL:settingURL];
//    }];
//    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//
//    }];
//    [alert addAction:cancel];
//    [alert addAction:ok];
//    [self presentViewController:alert animated:YES completion:nil];
}
#pragma mark - 定位成功
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    
    [_locationManager stopUpdatingLocation];
    CLLocation *currentLocation = [locations lastObject];
    CLGeocoder *geoCoder = [[CLGeocoder alloc]init];
    //当前的经纬度
    NSLog(@"当前的经纬度 %f,%f",currentLocation.coordinate.latitude,currentLocation.coordinate.longitude);
    
    _locationBlock ? _locationBlock(currentLocation.coordinate.latitude, currentLocation.coordinate.longitude, nil) : nil;
    
    //这里的代码是为了判断didUpdateLocations调用了几次 有可能会出现多次调用 为了避免不必要的麻烦 在这里加个if判断 如果大于1.0就return
//    NSTimeInterval locationAge = -[currentLocation.timestamp timeIntervalSinceNow];
//    if (locationAge > 1.0){//如果调用已经一次，不再执行
//        return;
//    }
//    kWeakSelf(self);
//    //地理反编码 可以根据坐标(经纬度)确定位置信息(街道 门牌等)
//    [geoCoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
//        if (placemarks.count >0) {
//            CLPlacemark *placeMark = placemarks[0];
//            weakself.currentCity = placeMark.locality;
//            if (!weakself.currentCity) {
//                weakself.currentCity = @"无法定位当前城市";
//            }
//            //看需求定义一个全局变量来接收赋值
//            NSLog(@"当前国家 - %@",placeMark.country);//当前国家
//            NSLog(@"当前城市 - %@",weakself.currentCity);//当前城市
//            NSLog(@"当前位置 - %@",placeMark.subLocality);//当前位置
//            NSLog(@"当前街道 - %@",placeMark.thoroughfare);//当前街道
//            NSLog(@"具体地址 - %@",placeMark.name);//具体地址
//            NSString *message = [NSString stringWithFormat:@"%@,%@,%@,%@,%@",placeMark.country,weakself.currentCity,placeMark.subLocality,placeMark.thoroughfare,placeMark.name];
//
////            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:message delegate:self cancelButtonTitle:nil otherButtonTitles:@"好", nil];
////            [alert show];
//        }else if (error == nil && placemarks.count){
//
//            NSLog(@"NO location and error return");
//        }else if (error){
//
//            NSLog(@"loction error:%@",error);
//        }
//    }];
}

@end
