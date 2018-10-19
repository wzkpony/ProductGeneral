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
    [dataSource addObjectsFromArray:@[@"二维码扫描",@"Excel表",@"GCD",@"Runtime",@"设计模式",@"Block",@"RAC",@"RunLoop",@"蓝牙"]];
    
        NSNumber *number = [NSNumber numberWithDouble:-1];
//    NSLog(@"%@",number.formateCountNum);
    self.label.text = number.formateCountNum;
//
//    for (id laer in [self.label.layer sublayers]) {
//        NSLog(@"%@",laer);
//    }
//

    
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
        
        
    }
    else if ([dataSource[indexPath.row] isEqualToString:@"Runtime"]){
        
    }
    else if ([dataSource[indexPath.row] isEqualToString:@"设计模式"]){
        
    }
    else if ([dataSource[indexPath.row] isEqualToString:@"Block"]){
        
    }
    else if ([dataSource[indexPath.row] isEqualToString:@"RAC"]){
        
    }
    else if ([dataSource[indexPath.row] isEqualToString:@"RunLoop"]){
        
    }
    else if ([dataSource[indexPath.row] isEqualToString:@"蓝牙"]){
        
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
