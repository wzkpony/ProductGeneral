//
//  ViewController.m
//  PodProduct
//
//  Created by wzk on 2017/6/12.
//  Copyright © 2017年 wzk. All rights reserved.
//

#import "ViewController.h"
#import "IconFontImageView.h"
#import "ConfigHead.h"
#import "NSNumber+Format.h"
#import <MediaPlayer/MediaPlayer.h>

#import "ScanQRCodeViewController.h"
#import "ExcelViewController.h"
#import "GCDViewController.h"
#import "RuntimeViewController.h"
#import "BlockViewController.h"
#import "RACViewController.h"
#import "RunLoopViewController.h"
#import "BlueToothViewController.h"
#import "AVVoiceTestViewController.h"

//UI
#import "GifViewController.h"
#import "SinusBarChartViewController.h"
//
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *dataSource;
}
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    dataSource = [[NSMutableArray alloc] init];
    [dataSource addObjectsFromArray:@[@"二维码扫描",@"Excel表",@"GCD",@"Runtime",@"设计模式",@"Block",@"RAC",@"RunLoop",@"蓝牙",@"声音",@"UI"]];
    
        NSNumber *number = [NSNumber numberWithDouble:-1];
//    NSLog(@"%@",number.formateCountNum);
    self.label.text = number.formateCountNum;
//
//    for (id laer in [self.label.layer sublayers]) {
//        NSLog(@"%@",laer);
//    }
//

    
//    NSString *string = @"1  2   3   4\nwzk  wzk wzk";
    NSString *path = [NSString stringWithFormat:@"%@/Documents/test.xlsx",NSHomeDirectory()];
    
    NSData *data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"WechatIMG110" ofType:@"jpeg"]];
//    BOOL bol = [data writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];
    BOOL bol = [data writeToFile:path atomically:YES];

    NSLog(@"%d",bol);
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *simpleTableIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier forIndexPath:indexPath];
    cell.textLabel.text = dataSource[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if ([dataSource[indexPath.row] isEqualToString:@"二维码扫描"]) {
        ScanQRCodeViewController *scanVC = [[ScanQRCodeViewController alloc] init];
        [self.navigationController pushViewController:scanVC animated:YES];
    }
    else if ([dataSource[indexPath.row] isEqualToString:@"Excel表"]){
        ExcelViewController *excelVC = [[ExcelViewController alloc] init];
        [self.navigationController pushViewController:excelVC animated:YES];
    }
    else if ([dataSource[indexPath.row] isEqualToString:@"GCD"]){
        GCDViewController *gcdVC = [[GCDViewController alloc] init];
         [self.navigationController pushViewController:gcdVC animated:YES];
        
    }
    else if ([dataSource[indexPath.row] isEqualToString:@"Runtime"]){
        RuntimeViewController *runtimeVC = [[RuntimeViewController alloc] init];
        [self.navigationController pushViewController:runtimeVC animated:YES];
    }
    else if ([dataSource[indexPath.row] isEqualToString:@"设计模式"]){
        
    }
    else if ([dataSource[indexPath.row] isEqualToString:@"Block"]){
        BlockViewController *blockVC = [[BlockViewController alloc] init];
        [self.navigationController pushViewController:blockVC animated:YES];
    }
    else if ([dataSource[indexPath.row] isEqualToString:@"RAC"]){
        RACViewController *racVC = [[RACViewController alloc] init];
        [self.navigationController pushViewController:racVC animated:YES];
    }
    else if ([dataSource[indexPath.row] isEqualToString:@"RunLoop"]){
        RunLoopViewController *runloopVC = [[RunLoopViewController alloc] init];
        [self.navigationController pushViewController:runloopVC animated:YES];
    }
    else if ([dataSource[indexPath.row] isEqualToString:@"蓝牙"]){
        BlueToothViewController *blueTooth = [[BlueToothViewController alloc] init];
        [self.navigationController pushViewController:blueTooth animated:YES];

    }
    else if ([dataSource[indexPath.row] isEqualToString:@"声音"]){
        AVVoiceTestViewController *av = [[AVVoiceTestViewController alloc] init];
        [self.navigationController pushViewController:av animated:YES];

    }
    else if ([dataSource[indexPath.row] isEqualToString:@"UI"]){
//        GifViewController *gif = [[GifViewController alloc] init];
//        [self.navigationController pushViewController:gif animated:YES];
        
        SinusBarChartViewController *sinus = [[SinusBarChartViewController alloc] init];
        [self.navigationController pushViewController:sinus animated:YES];

        
        
        
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
