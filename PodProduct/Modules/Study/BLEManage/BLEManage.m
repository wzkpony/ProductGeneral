//
//  BLEManage.m
//  V1_BaseProject
//
//  Created by wzk on 2018/10/9.
//  Copyright © 2018年 wzk. All rights reserved.
//

#import "BLEManage.h"

#define kSECharacter    @"character"
#define kSEType         @"type"

static BLEManage *instance = nil;

@interface BLEManage()<CBPeripheralDelegate>

@property (copy, nonatomic)   SEScanPerpheralSuccess             scanPerpheralSuccess;  /**< 扫描设备成功的回调 */
@property (copy, nonatomic)   SEScanPerpheralFailure             scanPerpheralFailure;  /**< 扫描设备失败的回调 */
@property (copy, nonatomic)   SEConnectCompletion                connectCompletion;    /**< 连接完成的回调 */
@property (copy, nonatomic)   SEFullOptionCompletion             optionCompletion;    /**< 连接、扫描、搜索 */

@property (copy, nonatomic)   SEDisconnect                       disconnectBlock;    /**< 断开连接的回调 */
@property (strong, nonatomic)   SESendResult                   sendResult;  /**< 打印结果的回调 */

@property (strong, nonatomic)   CBCentralManager            *centralManager;        /**< 中心管理器 */
@property (strong, nonatomic)   CBPeripheral                *connectedPerpheral;    /**< 当前连接的外设 */
@property (strong, nonatomic)   NSMutableArray              *perpherals;  /**< 搜索到的蓝牙设备列表 */

@property (strong, nonatomic)   NSMutableArray              *writeChatacters;  /**< 可写入数据的特性 */

@property (assign, nonatomic)   NSTimeInterval              timeout;  /**< 默认超时时间 */

@property (assign, nonatomic)   BOOL             autoConnect;  /**< 自动连接上次的外设 */

@property (assign, nonatomic)   NSInteger         writeCount;   /**< 写入次数 */
@property (assign, nonatomic)   NSInteger         responseCount; /**< 返回次数 */

@end
@implementation BLEManage

+ (instancetype)sharedInstance
{
    return [[self alloc] init];
}

+ (NSString *)UUIDStringForLastPeripheral
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *UUIDString = [userDefaults objectForKey:@"peripheral"];
    return UUIDString;
}

- (instancetype)init
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [super init];
        instance.perpherals = [[NSMutableArray alloc] init];
        instance.writeChatacters = [[NSMutableArray alloc] init];
        instance.timeout = 30;
    });
    return instance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [super allocWithZone:zone];
    });
    
    return instance;
}

#pragma mark - bluetooth method
- (void)setTimeout:(NSTimeInterval)timeout
{
    _timeout = timeout;
    
    if (_timeout > 0) {
        [self performSelector:@selector(timeoutAction) withObject:nil afterDelay:timeout];
    }
}

- (void)timeoutAction
{
    [_centralManager stopScan];
    if (_perpherals.count == 0) {
        //分发错误信息
        if (_delegate && [_delegate respondsToSelector:@selector(manager:scanError:)]) {
            [_delegate manager:self scanError:SEScanErrorTimeout];
        }
        
        if (_scanPerpheralFailure) {
            _scanPerpheralFailure(SEScanErrorTimeout);
        }
    } else {
        if (_delegate && [_delegate respondsToSelector:@selector(manager:perpherals:isTimeout:)]) {
            [_delegate manager:self perpherals:_perpherals isTimeout:YES];
        }
        if (_scanPerpheralSuccess) {
            _scanPerpheralSuccess(_perpherals,YES);
        }
    }
}

- (BOOL)isConnected
{
    if (!_connectedPerpheral) {
        return NO;
    }
    
    if (_connectedPerpheral.state != CBPeripheralStateConnected && _connectedPerpheral.state != CBPeripheralStateConnecting) {
        return NO;
    }
    
    return YES;
}

- (void)resetBLEModel
{
    NSDictionary * dict = [[NSDictionary alloc] initWithObjectsAndKeys:@NO,CBCentralManagerOptionShowPowerAlertKey, nil];
    _centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:dispatch_get_main_queue() options:dict];
    
    [_perpherals removeAllObjects];
    _connectedPerpheral = nil;
}

- (void)startScanPerpheralTimeout:(NSTimeInterval)timeout
{
    self.timeout = timeout;
    if (_centralManager.state == CBCentralManagerStatePoweredOn) {
        [_centralManager scanForPeripheralsWithServices:nil options:nil];
        return;
    }
    
    [self resetBLEModel];
}

- (void)startScanPerpheralTimeout:(NSTimeInterval)timeout Success:(SEScanPerpheralSuccess)success failure:(SEScanPerpheralFailure)failure
{
    self.timeout = timeout;
    _scanPerpheralSuccess = success;
    _scanPerpheralFailure = failure;
    
    if (_centralManager.state == CBCentralManagerStatePoweredOn) {
        [_centralManager scanForPeripheralsWithServices:nil options:nil];
        return;
    }
    
    [self resetBLEModel];
}

- (void)stopScan
{
    [_centralManager stopScan];
}

- (void)connectPeripheral:(CBPeripheral *)peripheral
{
    [_centralManager connectPeripheral:peripheral options:nil];
    peripheral.delegate = self;
}

- (void)connectPeripheral:(CBPeripheral *)peripheral completion:(SEConnectCompletion)completion
{
    _connectCompletion = completion;
    [self connectPeripheral:peripheral];
}

- (void)fullOptionPeripheral:(CBPeripheral *)peripheral completion:(SEFullOptionCompletion)completion
{
    _optionCompletion = completion;
    [self connectPeripheral:peripheral];
}

- (void)cancelPeripheral:(CBPeripheral *)peripheral
{
    if (!peripheral) {
        return;
    }
    [_centralManager cancelPeripheralConnection:peripheral];
    _connectedPerpheral = nil;
    [_writeChatacters removeAllObjects];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:@"peripheral"];
    [userDefaults synchronize];
}

- (void)autoConnectLastPeripheralTimeout:(NSTimeInterval)timeout completion:(SEConnectCompletion)completion
{
    self.timeout = timeout;
    
    _autoConnect = YES;
    
    _connectCompletion = completion;
    
    [_centralManager scanForPeripheralsWithServices:nil options:nil];
}

- (void)setDisconnect:(SEDisconnect)disconnectBlock
{
    _disconnectBlock = disconnectBlock;
}

- (void)sendWithResult:(SESendResult)result
{
    // lixinke
    NSData *finalData = nil;
    if (finalData.length == 0) {
        if (result) {
            result(_connectedPerpheral,NO,@"打印数据格式出错");
        }
        return;
    }
    
    [self sendData:finalData completion:result];
}


- (void)sendData:(NSData *)data completion:(SESendResult)result;
{
    if (!self.connectedPerpheral) {
        if (result) {
            result(_connectedPerpheral,NO,@"未连接蓝牙设备");
        }
        return;
    }
    
    if (self.writeChatacters.count == 0) {
        if (result) {
            result(_connectedPerpheral,NO,@"该蓝牙设备不能写入数据");
        }
        return;
    }
}

#pragma mark - CBCentralManagerDelegate
- (void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    if (central.state != CBCentralManagerStatePoweredOn) {
        if (_delegate && [_delegate respondsToSelector:@selector(manager:scanError:)]) {
            [_delegate manager:self scanError:(SEScanError)central.state];
        }
        
        if (_scanPerpheralFailure) {
            _scanPerpheralFailure((SEScanError)central.state);
        }
        
    } else {
        [central scanForPeripheralsWithServices:nil options:nil];
    }
}

- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary<NSString *, id> *)advertisementData RSSI:(NSNumber *)RSSI
{
    if (peripheral.name.length <= 0) {
        return ;
    }
    if (_perpherals.count == 0) {
        [_perpherals addObject:peripheral];
    } else {
        BOOL isExist = NO;
        for (int i = 0; i < _perpherals.count; i++) {
            CBPeripheral *per = [_perpherals objectAtIndex:i];
            if ([per.identifier.UUIDString isEqualToString:peripheral.identifier.UUIDString]) {
                isExist = YES;
                [_perpherals replaceObjectAtIndex:i withObject:peripheral];
            }
        }
        
        if (!isExist) {
            [_perpherals addObject:peripheral];
        }
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(manager:perpherals:isTimeout:)]) {
        [_delegate manager:self perpherals:_perpherals isTimeout:NO];
    }
    
    if (_scanPerpheralSuccess) {
        _scanPerpheralSuccess(_perpherals,NO);
    }
    
    if (_autoConnect) {
        NSString *UUIDString = [BLEManage UUIDStringForLastPeripheral];
        
        if ([peripheral.identifier.UUIDString isEqualToString:UUIDString]) {
            [_centralManager connectPeripheral:peripheral options:nil];
            peripheral.delegate = self;
        }
    }
}

#pragma mark ---------------- 连接外设成功和失败的代理 ---------------
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral
{
    _connectedPerpheral = peripheral;
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:peripheral.identifier.UUIDString forKey:@"peripheral"];
    [userDefaults synchronize];
    
    [_centralManager stopScan];
    
    if (_connectCompletion) {
        _connectCompletion(peripheral,nil);
    }
    
    if (_optionCompletion) {
        _optionCompletion(SEOptionStageConnection,peripheral,nil);
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(manager:completeConnectPerpheral:error:)]) {
        [_delegate manager:self completeConnectPerpheral:peripheral error:nil];
    }
    
    peripheral.delegate = self;
    [peripheral discoverServices:nil];
}

- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(nullable NSError *)error
{
    if (_connectCompletion) {
        _connectCompletion(peripheral,error);
    }
    
    if (_optionCompletion) {
        _optionCompletion(SEOptionStageConnection, peripheral,error);
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(manager:completeConnectPerpheral:error:)]) {
        [_delegate manager:self completeConnectPerpheral:peripheral error:error];
    }
}
#pragma mark --- 获取热点强度
-(void)peripheral:(CBPeripheral *)peripheral didReadRSSI:(NSNumber *)RSSI error:(NSError *)error {
    
    NSLog(@"%s,%@",__PRETTY_FUNCTION__,peripheral);
    
    int rssi = abs([RSSI intValue]);
    NSString *length = [NSString stringWithFormat:@"发现BLT4.0热点:%@,强度:%.1ddb",peripheral,rssi];
    NSLog(@"距离：%@", length);
    
}

- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(nullable NSError *)error
{
    _connectedPerpheral = nil;
    [_writeChatacters removeAllObjects];
    
    if (_delegate && [_delegate respondsToSelector:@selector(manager:disConnectPeripheral:error:)]) {
        [_delegate manager:self disConnectPeripheral:peripheral error:error];
    }
    
    if (_disconnectBlock) {
        _disconnectBlock(peripheral,error);
    }
}

#pragma mark ---------------- 发现服务的代理 -----------------
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(nullable NSError *)error
{
    if (error) {
        if (_optionCompletion) {
            _optionCompletion(SEOptionStageSeekServices,peripheral,error);
        }
        return;
    }
    
    for (CBService *service in peripheral.services) {
        [peripheral discoverCharacteristics:nil forService:service];
    }
    if (_optionCompletion) {
        _optionCompletion(SEOptionStageSeekServices,peripheral,nil);
    }
}

#pragma mark ---------------- 服务特性的代理 --------------------
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(nullable NSError *)error
{
    if (error) {
        if ([service isEqual:peripheral.services.lastObject]) {
            if (_writeChatacters.count > 0) {
                _optionCompletion(SEOptionStageSeekCharacteristics,peripheral,nil);
            } else {
                _optionCompletion(SEOptionStageSeekCharacteristics,peripheral,error);
            }
        }
        return;
    }
    
    for (CBCharacteristic *character in service.characteristics) {
        CBCharacteristicProperties properties = character.properties;
        //如果我们需要回调，则就不要使用没有返回的特性来写入数据
        //        if (properties & CBCharacteristicPropertyWriteWithoutResponse) {
        //            NSDictionary *dict = @{kSECharacter:character,kSEType:@(CBCharacteristicWriteWithoutResponse)};
        //            [_writeChatacters addObject:dict];
        //        }
        
        
//         [self.connectedPerpheral readValueForCharacteristic:character];
        
        
        CBCharacteristic *character1 = service.characteristics.lastObject;
        
        [peripheral readValueForCharacteristic:character1];
        [peripheral setNotifyValue:YES forCharacteristic:character1];
        
        // 获取电池电量
        unsigned char send[4] = {0x5d, 0x08, 0x01, 0x3b};
        NSData *sendData = [NSData dataWithBytes:send length:4];
        
        // 这里的type类型有两种 CBCharacteristicWriteWithResponse CBCharacteristicWriteWithoutResponse，它的属性枚举可以组合
        [self.connectedPerpheral writeValue:sendData forCharacteristic:character type:CBCharacteristicWriteWithoutResponse];
        
        NSLog(@"%lu",(unsigned long)properties);
        
        
//        if (properties & CBCharacteristicPropertyRead) {
//             NSDictionary *dict = @{kSECharacter:character,kSEType:@(CBCharacteristicWriteWithResponse)};
//            NSLog(@"dict ====  %@ ",dict);
//        }
//
//        if (properties & CBCharacteristicPropertyWrite) {
//            NSDictionary *dict = @{kSECharacter:character,kSEType:@(CBCharacteristicWriteWithResponse)};
//            [_writeChatacters addObject:dict];
//        }
    }
    
    if ([service isEqual:peripheral.services.lastObject]) {
        if (_optionCompletion) {
            _optionCompletion(SEOptionStageSeekCharacteristics,peripheral,nil);
        }
    }
}

/**
 * 数据更新的回调
 */
- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    // 这里收到的数据都是16进制，有两种转换，一种就直接转字符串，另一种是转byte数组，看用哪种方便
    NSData * data = characteristic.value;
    Byte * resultByte = (Byte *)[data bytes];
    
    if (data) {
        NSString * str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                
    }
    // 此处的byte数组就是接收到的数据
    NSLog(@"%s", resultByte);

}

- (void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
    if (error) {
        NSLog(@"Error changing notification state: %@", error.localizedDescription);
    }
    
    // Notification has started
    if (characteristic.isNotifying) {
        [peripheral readValueForCharacteristic:characteristic];
    } else { // Notification has stopped
        // so disconnect from the peripheral
        NSLog(@"Notification stopped on %@.  Disconnecting", characteristic);
        
        [self.centralManager cancelPeripheralConnection:peripheral];
    }
    
}

#pragma mark ---------------- 写入数据的回调 --------------------
- (void)peripheral:(CBPeripheral *)peripheral didWriteValueForCharacteristic:(CBCharacteristic *)characteristic error:(nullable NSError *)error
{
    if (!_sendResult) {
        return;
    }
    _responseCount ++;
    if (_writeCount != _responseCount) {
        return;
    }
    
    if (error) {
        _sendResult(_connectedPerpheral,NO,@"发送失败");
    } else {
        _sendResult(_connectedPerpheral,YES,@"已成功发送至蓝牙设备");
    }
}


@end
