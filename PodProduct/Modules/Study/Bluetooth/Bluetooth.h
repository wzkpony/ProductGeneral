//
//  Bluetooth.h
//  PodProduct
//
//  Created by wzk on 2018/10/19.
//  Copyright © 2018年 wzk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
NS_ASSUME_NONNULL_BEGIN


@protocol BluetoothDeletate <NSObject>

//搜索结果
- (void)bluetoothSearchResult:(NSArray<CBPeripheral *> *)array;
//链接成功
- (void)bluetoothConnectSuccess;
//连接失败
- (void)bluetoothConnectError:(NSError *)error;
//接收数据
- (void)bluetoothGetData:(id)obj;

//发送成功
- (void)bluetoothSendSuccess;


@end



@interface Bluetooth : NSObject
/* 中心管理者 */
@property (nonatomic, strong) CBCentralManager *cMgr;

/* 连接到的外设 */
@property (nonatomic, strong) CBPeripheral *peripheral;

@property (nonatomic, weak) id<BluetoothDeletate> delegate;

- (id)initWithDelegate:(id<BluetoothDeletate>)delegate;

//连接设备
- (void)bluetoothConnect:(CBPeripheral *)peripheral;
//发送数据
- (void)bluetoothSendData:(NSData *)data;
@end



NS_ASSUME_NONNULL_END
