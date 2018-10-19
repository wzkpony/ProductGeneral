//
//  BlueToothViewController.m
//  PodProduct
//
//  Created by wzk on 2018/10/19.
//  Copyright © 2018年 wzk. All rights reserved.
//

#import "BlueToothViewController.h"
#import "Bluetooth.h"
@interface BlueToothViewController ()<BluetoothDeletate,UITableViewDelegate,UITableViewDataSource>
{
    BOOL isreload;
}
@property (nonatomic ,strong)Bluetooth *blueTooth;
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@property (nonatomic, strong)NSArray *dataSource;
@end

@implementation BlueToothViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _blueTooth = [[Bluetooth alloc] initWithDelegate:self];
    [HUDView showWhiteToastWith:@"正在搜索。。。" allowUserInteractions:NO];

    
}
- (void)reloadTableView
{
    [self.tableView reloadData];
    isreload = NO;
    [HUDView dismiss_t];

}
//搜索结果
- (void)bluetoothSearchResult:(NSArray<CBPeripheral *> *)array
{
    NSLog(@"%@",array);
    self.dataSource = array;
    if (isreload == NO) {
        [self performSelector:@selector(reloadTableView) withObject:self afterDelay:5];
        isreload = YES;
    }
}

//链接成功
- (void)bluetoothConnectSuccess{
    [HUDView showTip:@"连接成功"];
}
//连接失败
- (void)bluetoothConnectError:(NSError *)error{
    [HUDView showTip:error.localizedDescription];

}
//接收数据
- (void)bluetoothGetData:(id)obj{
    
}

//发送成功
- (void)bluetoothSendSuccess{
    [HUDView showTip:@"数据发送成功"];
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

    [_blueTooth bluetoothConnect:per];
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
