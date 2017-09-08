//
//  ScanQRCodeViewController.m
//  ELuTong
//
//  Created by wangzhengkui on 2017/4/17.
//  Copyright © 2017年 ELuTong. All rights reserved.
//

#import "ScanQRCodeViewController.h"
#import "ContactProfileVC.h"
#import "ProductPageViewController.h"
#import "GroupInfoViewController.h"
#import "ELTMeRequest.h"
#import "RFCDetailViewController.h"
#import "CompanyViewController.h"
#import "AddContactsVC.h"

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
        CGFloat x = (ScreenWidth - outputW)/2;
        CGFloat y = (ScreenHeight-64 - outputH)/2;
        CGFloat width = ScreenWidth;
        CGFloat height = ScreenHeight-64;
        
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
        [Global showAlertWithTitle:@"" message:str];
        return NO;
    }
    else if (_device == nil)
    {
        NSString* string = @"故无法获取硬件信息!";
        [Global showAlertWithTitle:@"" message:string];
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
                // Contact&Purchaser&000000054375
                // CodeType & DataType -->判断跳转界面
                //& DataId -->跳转页面接受的ID
                
                NSArray * dataArray = [base64Decoded componentsSeparatedByString:@"&"];
                if (dataArray.count == 3) {
                    NSString * codeTypeStr = [dataArray objectAtIndex:0];
                    NSString * dataTypeStr = [dataArray objectAtIndex:1];
                    NSString * dataIdTypeStr = [dataArray objectAtIndex:2];
                    
                    NSDictionary * dataDict = [[NSDictionary alloc] initWithObjects:@[codeTypeStr,dataTypeStr,dataIdTypeStr] forKeys:@[@"CodeType",@"DataType",@"DataId"]];
                    
                    if ([codeTypeStr isEqualToString:@"Contact"]) {//联系人
                        if (self.cometotype == RFCSampleDtatilView) {
                            return;
                        }
                        ContactProfileVC* contact = [[ContactProfileVC alloc] initWithFriendID:dataIdTypeStr contactType:ContactTypeSearched];
                        [self.navigationController pushViewController:contact animated:YES];
                        [self stop];
                        
                        

                    }else if ([codeTypeStr isEqualToString:@"Goods"]){//产品详情
                        if (self.cometotype == RFCSampleDtatilView) {
                            return;
                        }
                        ProductPageViewController* pageViewController = [[ProductPageViewController alloc] init];
                        
                        NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
                        [dict setValue:@"" forKey:@"exhibitionId"];
                        [dict setValue:dataIdTypeStr forKey:@"goodsId"];
                        [dict setValue:@{} forKey:@"specSearchCond"];
                        [dict setValue:nil forKey:@"spuId"];
                        
                        pageViewController.dictItems = dict;
                        
                        pageViewController.definesPresentationContext = YES;
                        [self.navigationController pushViewController:pageViewController animated:YES];
                        [self stop];
                        
                    }else if ([codeTypeStr isEqualToString:@"ChatGroup"]){//群聊
                        if (self.cometotype == RFCSampleDtatilView) {
                            return;
                        }
                        GroupInfoViewController* group = [[GroupInfoViewController alloc] initWithGroupName:@"" groupID:dataIdTypeStr];
                        [self.navigationController pushViewController:group animated:YES];
                        
                    }else if ([codeTypeStr isEqualToString:@"SampleOrder"]){///sampleOrder/confirmSampleOrder.json
                        //ConfirmSampleOrderPath
                        if (self.cometotype == RFCSampleDtatilView) {
                            
                            
                            NSInteger userType = [Global sharedInstance].loginedUserModel.memberType;
                            if (userType == 3) {
                                NSArray* arrayContent = [dataIdTypeStr componentsSeparatedByString:@","];
                                if (arrayContent.count<2) {
                                    return;
                                }
                                sampleID = arrayContent[0];
                                sampleCode = arrayContent[1];
                                ELTMeRequest* request = [[ELTMeRequest alloc] init];
                                
                                [request meRequestWithTarget:self action:@selector(simpleRequestForData:) path:ConfirmSampleOrderPath params:@{@"orderId":sampleID,@"tradeQrcode":sampleCode}];
                                [self stop];
                            }
                            
                        }
                    }else if ([codeTypeStr isEqualToString:@"RfcAttend"]){///rfc/confirmRfcAttend.json--ConfirmRfcAttendPath
                        if (self.cometotype == RFCSampleDtatilView) {
                            NSInteger userType = [Global sharedInstance].loginedUserModel.memberType;
                            if (userType == 3) {
                                
                                NSArray* arrayContent = [dataIdTypeStr componentsSeparatedByString:@","];
                                if (arrayContent.count<2) {
                                    return;
                                }
                                rfcID = arrayContent[0];
                                rfcCode = arrayContent[1];
                                ELTMeRequest* request = [[ELTMeRequest alloc] init];
                                [request meRequestWithTarget:self action:@selector(rfcRequestForData:) path:ConfirmRfcAttendPath params:@{@"orderId":rfcID,@"tradeQrcode":rfcCode}];
                                [self stop];
                            }
                        }
   
                    }else if ([codeTypeStr isEqualToString:@"Company"]){//公司详情页面--dataIdTypeStr
                       if (self.cometotype == RFCSampleDtatilView) {
                           return;
                       }
                        CompanyViewController* company = [[CompanyViewController alloc] init];
                        company.supIdString = dataIdTypeStr;
                        [self.navigationController pushViewController:company animated:YES];
                        [self stop];
                    }else if ([codeTypeStr isEqualToString:@"ChatPerson"]){
                        [Global showToastViewWithText:@"ChatPerson"];
                        
                        [self stop];
                        
                    }else{
                        [Global showToastViewWithText:@"Unsupported type"];
                        
                        
                        
                    }
                    
                }
                
            }
        }
    }
   
}
-(void)simpleRequestForData:(id)obj
{
    if ([obj isKindOfClass:[NSError class]]) {
        [self start];
        return;
    }
    RFCDetailViewController* xiangqing = [[RFCDetailViewController alloc] initWithSampleOrderTitle:@"" orderId:[NSString stringWithFormat:@"%@",sampleID]];
    
    
    [self.navigationController pushViewController:xiangqing animated:YES];
}
-(void)rfcRequestForData:(id)obj
{
    if ([obj isKindOfClass:[NSError class]]) {
        [self start];
        return;
    }
    RFCDetailViewController* xiangqing = [[RFCDetailViewController alloc] initWithRFCTitle:@"" canchouId:[NSString stringWithFormat:@"%@",rfcID]];
    [self.navigationController pushViewController:xiangqing animated:YES];
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
