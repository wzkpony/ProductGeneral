//
//  ScanQRCodeViewController.h
//  ELuTong
//
//  Created by wangzhengkui on 2017/4/17.
//  Copyright © 2017年 ELuTong. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "ErWeiMaWZK.h"
#import <AVFoundation/AVFoundation.h>



/*
 1.
 2.
 3.
 4.
 5.
 
 
 */
typedef enum {
    ExhibitionView,
    AddCantact,
    RFCSampleDtatilView,
} ComeToScanQR;

@interface ScanQRCodeViewController : ELTBaseViewController
@property (strong,nonatomic)AVCaptureDevice * device;
@property (strong,nonatomic)AVCaptureDeviceInput * input;
@property (strong,nonatomic)AVCaptureMetadataOutput * output;
@property (strong,nonatomic)AVCaptureSession * session;
@property (strong,nonatomic)AVCaptureVideoPreviewLayer * preview;

@property(nonatomic,assign)ComeToScanQR cometotype;
@end
