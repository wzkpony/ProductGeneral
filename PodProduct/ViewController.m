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
    [dataSource addObjectsFromArray:@[@"二维码扫描",@"Excel表",@"GCD",@"Runtime",@"设计模式",@"Block",@"RAC",@"RunLoop",@"蓝牙",@"声音",@"UI",@"MoviePlayer"]];
    
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
        [self.navigationController pushViewController:sinus animated:NO];

        
        
        
    }
    
    else if ([dataSource[indexPath.row] isEqualToString:@"MoviePlayer"]){
//        NSString* localFilePath=[[NSBundle mainBundle]pathForResource:@"不能说的秘密" ofType:@"mp4"];
//        NSURL *localVideoUrl = [NSURL fileURLWithPath:localFilePath];
        //在线视频
//        NSString *webVideoPath = @"http://s8.wy6z50.cn/live/728695_9d7f52b3a128e417cb5c.flv?auth_key=1543184450-0-0-824e62f2aab2524c856c311fee611438";
//        NSURL *webVideoUrl = [NSURL URLWithString:webVideoPath];
//
//        //第二步:创建视频播放器
//        MPMoviePlayerViewController *playerViewController = [[MPMoviePlayerViewController alloc] initWithContentURL:webVideoUrl];
//
//        //第三步:设置播放器属性
//        //通过moviePlayer属性设置播放器属性(与MPMoviePlayerController类似)
//        playerViewController.moviePlayer.scalingMode = MPMovieScalingModeFill;
//
//        //第四步:跳转视频播放界面
//        [self presentViewController:playerViewController animated:YES completion:nil];
//        UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
//        [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://s8.wy6z50.cn/live/728695_9d7f52b3a128e417cb5c.flv?auth_key=1543184450-0-0-824e62f2aab2524c856c311fee611438"]]];
//        [self.view addSubview:webView];
        
      
      
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
