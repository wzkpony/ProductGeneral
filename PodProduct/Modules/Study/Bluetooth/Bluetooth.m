//
//  Bluetooth.m
//  PodProduct
//
//  Created by wzk on 2018/10/19.
//  Copyright © 2018年 wzk. All rights reserved.
//

#import "Bluetooth.h"
@interface Bluetooth()<CBCentralManagerDelegate,CBPeripheralDelegate>
{
    
}
@property(nonatomic, strong) CBCharacteristic *characteristic;

@end
@implementation Bluetooth

- (id)initWithDelegate:(id<BluetoothDeletate>)delegate
{
    if (!self.cMgr) {
        self.delegate = delegate;
        [self createManager];
        
    }
    return self;
}
- (id)init{
    return nil;
}
- (CBCentralManager *)createManager
{
    if (self.cMgr == nil) {
        self.cMgr = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
    }
    return self.cMgr;
}

#pragma mark -- 发送检查蓝牙命令 --
- (void)bluetoothSendData:(NSData *)data
{
    // 发送下行指令(发送一条)
    //    NSData *data = [@"硬件工程师提供给你的指令, 类似于5E16010203...这种很长一串" dataUsingEncoding:NSUTF8StringEncoding];
    [self.peripheral writeValue:data forCharacteristic:self.characteristic type:CBCharacteristicWriteWithResponse];
}
#pragma mark -- 连接设备 --
- (void)bluetoothConnect:(CBPeripheral *)peripheral
{
    [self.cMgr connectPeripheral:peripheral options:nil];
    
}
#pragma mark 断开连接
- (void)disConnectPeripheral{
    /**
     -- 断开连接后回调didDisconnectPeripheral
     -- 注意断开后如果要重新扫描这个外设，需要重新调用[self.centralManager scanForPeripheralsWithServices:nil options:nil];
     */
    [self.cMgr cancelPeripheralConnection:self.peripheral];
}
#pragma mark 停止扫描外设
- (void)stopScanPeripheral{
    [self.cMgr stopScan];
}


#pragma  -- 蓝牙的代理方法 蓝牙开始 --
//只要中心管理者初始化 就会触发此代理方法 判断手机蓝牙状态
- (void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    switch (central.state) {
        case 0:
            NSLog(@"CBCentralManagerStateUnknown");
            break;
        case 1:
            NSLog(@"CBCentralManagerStateResetting");
            break;
        case 2:
            NSLog(@"CBCentralManagerStateUnsupported");//不支持蓝牙
            break;
        case 3:
            NSLog(@"CBCentralManagerStateUnauthorized");
            break;
        case 4:
        {
            NSLog(@"CBCentralManagerStatePoweredOff");//蓝牙未开启
        }
            break;
        case 5:
        {
            NSLog(@"CBCentralManagerStatePoweredOn");//蓝牙已开启
            // 在中心管理者成功开启后再进行一些操作
            // 搜索外设
            [self.cMgr scanForPeripheralsWithServices:nil // 通过某些服务筛选外设
                                              options:nil]; // dict,条件
           
        }
            break;
        default:
            break;
    }
}
//2.搜索外围设备 (我这里为了举例，采用了自己身边的一个手环)

// 发现外设后调用的方法
- (void)centralManager:(CBCentralManager *)central // 中心管理者
 didDiscoverPeripheral:(CBPeripheral *)peripheral // 外设
     advertisementData:(NSDictionary *)advertisementData // 外设携带的数据
                  RSSI:(NSNumber *)RSSI // 外设发出的蓝牙信号强度
{
    //NSLog(@"%s, line = %d, cetral = %@,peripheral = %@, advertisementData = %@, RSSI = %@", __FUNCTION__, __LINE__, central, peripheral, advertisementData, RSSI);
    
    /*
     peripheral = , advertisementData = {
     kCBAdvDataChannel = 38;
     kCBAdvDataIsConnectable = 1;
     kCBAdvDataLocalName = OBand;
     kCBAdvDataManufacturerData = <4c69616e 0e060678 a5043853 75>;
     kCBAdvDataServiceUUIDs =     (
     FEE7
     );
     kCBAdvDataTxPowerLevel = 0;
     }, RSSI = -55
     根据打印结果,我们可以得到运动手环它的名字叫 OBand-75
     
     */
    
    // 需要对连接到的外设进行过滤
    // 1.信号强度(40以上才连接, 80以上连接)
    // 2.通过设备名(设备字符串前缀是 OBand)
    // 在此时我们的过滤规则是:有OBand前缀并且信号强度大于35
    // 通过打印,我们知道RSSI一般是带-的
    NSLog(@"bluetooth_name = %@",peripheral.name);
    NSMutableArray *nameArr = [[NSMutableArray alloc] init];
    if (peripheral.name != nil) {
        [nameArr addObject:peripheral];
    }
    if ([self.delegate respondsToSelector:@selector(bluetoothSearchResult:)]) {
        //搜索数据
        [self.delegate bluetoothSearchResult:nameArr];
    }
//    if ([peripheral.name hasPrefix:@"wzk的MacBook Pro"]) {
//        // 在此处对我们的 advertisementData(外设携带的广播数据) 进行一些处理
//
//        // 通常通过过滤,我们会得到一些外设,然后将外设储存到我们的可变数组中,
//        // 这里由于附近只有1个运动手环, 所以我们先按1个外设进行处理
//
//        // 标记我们的外设,让他的生命周期 = vc
//
//
//        // 发现完之后就是进行连接
//        [self.cMgr connectPeripheral:peripheral options:nil];
//        NSLog(@"%s, line = %d", __FUNCTION__, __LINE__);
//    }
    
}
//3.连接外围设备

// 中心管理者连接外设成功
- (void)centralManager:(CBCentralManager *)central // 中心管理者
  didConnectPeripheral:(CBPeripheral *)peripheral // 外设
{
    NSLog(@"%s, line = %d, %@=连接成功", __FUNCTION__, __LINE__, peripheral.name);
    //连接成功后停止扫描，节省内存
    [central stopScan];
    peripheral.delegate = self;
    self.peripheral = peripheral;
    
    
//4.扫描外设的服务
    /**
     --     外设的服务、特征、描述等方法是CBPeripheralDelegate的内容，所以要先设置代理peripheral.delegate = self
     --     参数表示你关心的服务的UUID，比如我关心的是"FFE0",参数就可以为@[[CBUUID UUIDWithString:@"FFE0"]].那么didDiscoverServices方法回调内容就只有这两个UUID的服务，不会有其他多余的内容，提高效率。nil表示扫描所有服务
     --     成功发现服务，回调didDiscoverServices
     */
    [peripheral discoverServices:nil];//@[[CBUUID UUIDWithString:@"9FA480E0-4967-4542-9390-D343DC5D04AE"]]
    
    
    if ([self.delegate respondsToSelector:@selector(bluetoothConnectSuccess)]) {
        // 已经连接
        [self.delegate bluetoothConnectSuccess];
    }
}
// 外设连接失败
- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
    NSLog(@"%s, line = %d, %@=连接失败", __FUNCTION__, __LINE__, peripheral.name);
    if ([self.delegate respondsToSelector:@selector(bluetoothConnectError:)]) {
        // 已经连接
        [self.delegate bluetoothConnectError:error];
    }
}

// 丢失连接
- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
    NSLog(@"%s, line = %d, %@=断开连接", __FUNCTION__, __LINE__, peripheral.name);
    if ([self.delegate respondsToSelector:@selector(bluetoothConnectError:)]) {
        // 已经连接
        [self.delegate bluetoothConnectError:error];
    }
}
//4.获得外围设备的服务
#pragma mark 发现服务回调
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error{
    
    //NSLog(@"didDiscoverServices,Error:%@",error);
    CBService * __nullable findService = nil;
    // 遍历服务
    for (CBService *service in peripheral.services)
    {
        NSLog(@"UUID:%@",service.UUID);
        if ([[service UUID] isEqual:[CBUUID UUIDWithString:@"9FA480E0-4967-4542-9390-D343DC5D04AE"]])
        {
            findService = service;
        }
    }
    NSLog(@"Find Service:%@",findService);
    if (findService)
        [peripheral discoverCharacteristics:NULL forService:findService];
}

//5.获得服务的特征
// 发现外设服务里的特征的时候调用的代理方法(这个是比较重要的方法，你在这里可以通过事先知道UUID找到你需要的特征，订阅特征，或者这里写入数据给特征也可以)
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error
{
    for (CBCharacteristic *characteristic in service.characteristics) {
        if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AF0BADB1-5B99-43CD-917A-A77BC549E3CC"]]) {
            
            /**
             -- 读取成功回调didUpdateValueForCharacteristic
             */
            self.characteristic = characteristic;
            // 接收一次(是读一次信息还是数据经常变实时接收视情况而定, 再决定使用哪个)
            //            [peripheral readValueForCharacteristic:characteristic];
            // 订阅, 实时接收
            [peripheral setNotifyValue:YES forCharacteristic:characteristic];
            
            // 发送下行指令(发送一条)
//            NSData *data = [@"硬件工程师给我的指令, 发送给蓝牙该指令, 蓝牙会给我返回一条数据" dataUsingEncoding:NSUTF8StringEncoding];
//            // 将指令写入蓝牙
//            [self.peripheral writeValue:data forCharacteristic:characteristic type:CBCharacteristicWriteWithResponse];
        }
        /**
         -- 当发现characteristic有descriptor,回调didDiscoverDescriptorsForCharacteristic
         */
        [peripheral discoverDescriptorsForCharacteristic:characteristic];
    }
}
//6.从外围设备读数据
#pragma mark - 获取值
- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
    // characteristic.value就是蓝牙给我们的值(我这里是json格式字符串)
//    NSData *jsonData = [characteristic.value dataUsingEncoding:NSUTF8StringEncoding];
    if (characteristic.value == nil) {
        return;
    }
    NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:characteristic.value options:NSJSONReadingMutableContainers error:nil];
    // 将字典传出去就可以使用了
    if ([self.delegate respondsToSelector:@selector(bluetoothGetData:)]) {
        // 已经连接
        [self.delegate bluetoothGetData:dataDic];
    }
    NSLog(@"%@",dataDic);
}
#pragma mark - 中心读取外设实时数据
- (void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
    if (characteristic.isNotifying) {
        [peripheral readValueForCharacteristic:characteristic];
    } else {
        NSLog(@"Notification stopped on %@.  Disconnecting", characteristic);
        NSLog(@"%@", characteristic);
        [self.cMgr cancelPeripheralConnection:peripheral];
    }
}



#pragma mark 数据写入成功回调
- (void)peripheral:(CBPeripheral *)peripheral didWriteValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
    if ([self.delegate respondsToSelector:@selector(bluetoothSendSuccess)]) {
        // 已经连接
        [self.delegate bluetoothSendSuccess];
    }
    NSLog(@"写入成功");
//    if ([self.delegate respondsToSelector:@selector(didWriteSucessWithStyle:)]) {
//        [self.delegate didWriteSucessWithStyle:_style];
//    }
}







@end
