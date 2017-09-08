//
//  ScanQRCodeViewController.m
//  ELuTong
//
//  Created by wangzhengkui on 2017/4/17.
//  Copyright © 2017年 ELuTong. All rights reserved.
//

#import "ScanQRCodeViewController.h"
#import "ConfigHead.h"

@interface ScanQRCodeViewController ()<AVCaptureMetadataOutputObjectsDelegate>
{
    UIImageView* bgImgV;
    UIImageView* aniImgV;
    CGFloat scanWidth;
    NSString* sampleID;
    NSString* sampleCode;
    NSString* rfcID;
    NSString* rfcCode;
}

@end

@implementation ScanQRCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
     self.title = @"Scan QR Code";
    scanWidth = 260;
    // Device
    //1.原生扫描用到的几个类
    _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    // Input
    _input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    
    // Output
    _output = [[AVCaptureMetadataOutput alloc]init];
    [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    // Session
    _session = [[AVCaptureSession alloc]init];
    [_session setSessionPreset:AVCaptureSessionPreset1280x720];
    
    //连接输入和输出
    if ([_session canAddInput:self.input])
    {
        [_session addInput:self.input];
    }
    
    if ([_session canAddOutput:self.output])
    {
        [_session addOutput:self.output];
    }
   
    if ([self isGetAccess]) {
        _output.metadataObjectTypes=@[AVMetadataObjectTypeQRCode,AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code];
        //添加扫描画面
        _preview =[AVCaptureVideoPreviewLayer layerWithSession:_session];
        _preview.videoGravity =AVLayerVideoGravityResizeAspectFill;
        _preview.frame =self.view.layer.bounds;
        [self.view.layer insertSublayer:_preview atIndex:1];
        
        
        
        CGFloat outputW = scanWidth;
        CGFloat outputH = outputW;
        CGFloat x = (SCREEN_WIDTH - outputW)/2;
        CGFloat y = (SCREEN_HEIGHT-64 - outputH)/2;
        CGFloat width = SCREEN_WIDTH;
        CGFloat height = SCREEN_HEIGHT-64;
        
        _output.rectOfInterest = CGRectMake(y/height, x/width, outputH/height, outputW/width);
        
        // 5. 背景view scan_bg_pic  scan_line
        bgImgV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"scan_bg_pic"]];
        bgImgV.frame = CGRectMake(x, y, outputW, outputH);
        
        [self.view addSubview:bgImgV];
        
        // 6. 上下移动的view
        aniImgV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"scan_line"]];
        aniImgV.frame = CGRectMake(bgImgV.frame.origin.x, bgImgV.frame.origin.y + 5, bgImgV.frame.size.width, 5);
        
        [self.view addSubview:aniImgV];
        
    }

}



-(BOOL)isGetAccess
{
  
    
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if ((authStatus == AVAuthorizationStatusRestricted)||(authStatus == AVAuthorizationStatusDenied)) {
        NSString* str = @"请在“设置”-“隐私”-“相机”功能中，打开本app的相机访问权限";
        return NO;
    }
    else if (_device == nil)
    {
        NSString* string = @"故无法获取硬件信息!";
        return NO;
    }
    else
    {
        return YES;
    }
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //设置条码类型
    
    if ([self isGetAccess]) {
        [self start];
    }
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self stop];
}
// MARK: 上下移动的动画
-(void)doAnimate {
    if (aniImgV == nil) {
        return;
    }
    
    CAKeyframeAnimation *keyAni = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.y"];
    keyAni.duration = 2;
    keyAni.values = @[[NSNumber numberWithInteger:0], [NSNumber numberWithInteger:scanWidth], [NSNumber numberWithInteger:0]];
    keyAni.repeatCount = MAXFLOAT;
    [aniImgV.layer addAnimation:keyAni forKey:@"keyAni_key"];
    
    
}

-(void)removeAnimate{
    if  (aniImgV != nil) {
        [aniImgV.layer removeAllAnimations];
    }
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    NSString *stringValue;
    
    if ([metadataObjects count] >0){
        //停止扫描
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        stringValue = metadataObject.stringValue;
        //userModel.qrCode: @MEORIENT:Q29udGFjdCZQdXJjaGFzZXImMTAwMDAwMTA2MDY3
        if ([stringValue hasPrefix:@"@MEORIENT:"]) {
            NSArray * qrArray = [stringValue componentsSeparatedByString:@":"];
            if (qrArray.count == 2) {
                NSString * miScrStr = [qrArray objectAtIndex:1];
                
                // NSData from the Base64 encoded str
                NSData *nsdataFromBase64String = [[NSData alloc] initWithBase64EncodedString:miScrStr options:0];
                
                // Decoded NSString from the NSData
                NSString *base64Decoded = [[NSString alloc] initWithData:nsdataFromBase64String encoding:NSUTF8StringEncoding];
                NSLog(@"Decoded: %@", base64Decoded);
                
                
            }
            
        }
    }
}

//停止扫描
-(void)stop
{
    [self removeAnimate];
    [_session stopRunning];
}
-(void)start
{
    [self doAnimate];
    [_session startRunning];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
