//
//  BlueToothViewController.m
//  PodProduct
//
//  Created by wzk on 2018/10/19.
//  Copyright © 2018年 wzk. All rights reserved.
//

#import "BlueToothViewController.h"
#import "BLEManage.h"

#import "BlueSuccessViewController.h"

@interface BlueToothViewController ()<BLEManageDelegate,UITableViewDelegate,UITableViewDataSource>
{
    BOOL isreload;
}
@property (nonatomic ,strong)BLEManage *blueTooth;
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@property (nonatomic, strong)NSArray<CBPeripheral *> *dataSource;
@end

@implementation BlueToothViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"蓝牙列表";
    _blueTooth = [BLEManage sharedInstance];
    _blueTooth.delegate = self;
    [_blueTooth startScanPerpheralTimeout:30];

    /**
     [HUDView showWhiteToastWith:@"正在搜索。。。" allowUserInteractions:NO];

     
    [_blueTooth startScanPerpheralTimeout:30 Success:^(NSArray<CBPeripheral *> *perpherals, BOOL isTimeout) {

    } failure:^(SEScanError error) {

    }];
    
     __weak typeof(self)mySelf = self;

    [_blueTooth autoConnectLastPeripheralTimeout:30 completion:^(CBPeripheral *perpheral, NSError *error) {
        if (error ==nil) {
            BlueSuccessViewController *success = [[BlueSuccessViewController alloc] init];
            success.sendData = ^(NSString *dataString){
                [mySelf.blueTooth sendData:[dataString dataUsingEncoding:NSUTF8StringEncoding] completion:^(CBPeripheral *connectPerpheral, BOOL completion, NSString *error) {
                    [HUDView showTip:@"发送成功"];
                }];
            };
            [self.navigationController pushViewController:success animated:YES];
        }
    }];
    */
    

    
    
}
/** 返回扫描到的蓝牙 设备列表
 *  因为蓝牙模块一次返回一个设备，所以该方法会调用多次
 */
- (void)manager:(BLEManage *)manager perpherals:(NSArray<CBPeripheral *> *)perpherals isTimeout:(BOOL)isTimeout{
    self.dataSource = perpherals;
    NSIndexSet *set = [NSIndexSet indexSetWithIndex:0];
    [self.tableView reloadSections:set withRowAnimation:UITableViewRowAnimationNone];
}

/** 扫描蓝牙设备失败
 *
 */
- (void)manager:(BLEManage *)manager scanError:(SEScanError)error{
    
}

/**
 *  连接蓝牙外设完成
 *
 *  @param manager
 *  @param perpheral 蓝牙外设
 *  @param error
 */
- (void)manager:(BLEManage *)manager completeConnectPerpheral:(CBPeripheral *)perpheral error:(NSError *)error{
    [HUDView showTip:@"连接成功"];
    __weak typeof(self)mySelf = self;
    BlueSuccessViewController *success = [[BlueSuccessViewController alloc] init];
    success.sendData = ^(NSString *dataString){
        [mySelf.blueTooth sendData:[dataString dataUsingEncoding:NSUTF8StringEncoding] completion:^(CBPeripheral *connectPerpheral, BOOL completion, NSString *error) {
            [HUDView showTip:@"发送成功"];

        }];
    };
    [self.navigationController pushViewController:success animated:YES];
    
}

/**
 *  断开连接
 *
 *  @param manager
 *  @param peripheral 设备
 *  @param error      错误信息
 */
- (void)manager:(BLEManage *)manager disConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error{
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellid = @"blueToothCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    CBPeripheral *per = self.dataSource[indexPath.row];
    cell.textLabel.text = per.name;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CBPeripheral *per = self.dataSource[indexPath.row];
    [self.blueTooth connectPeripheral:per];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
