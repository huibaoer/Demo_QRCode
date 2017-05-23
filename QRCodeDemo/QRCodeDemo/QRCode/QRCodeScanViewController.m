//
//  QRCodeScanViewController.m
//  QRCodeDemo
//
//  Created by zhanght on 15/9/9.
//  Copyright (c) 2015年 haitao. All rights reserved.
//

#import "QRCodeScanViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "QRCodeBackgroundView.h"

@interface QRCodeScanViewController () <AVCaptureMetadataOutputObjectsDelegate>
@property (strong, nonatomic) AVCaptureSession *session;//影音采集会话对象
@property (strong, nonatomic) AVCaptureVideoPreviewLayer *layer;//用于展示session采集到的内容

@end

@implementation QRCodeScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.alpha = 0.5;
    
    QRCodeBackgroundView *bg = [[QRCodeBackgroundView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:bg];
    
    

    [self startScan];
}

- (void)startScan {
    //选择设备（二维码肯定是视频设备）
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    //获取设备输入
    NSError *error;
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:&error];
    if (!input) {
        NSLog(@"--ht-- 无法开启设备：%@", error.localizedDescription);
        return;
    }
    //数据输出对象
    AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc] init];
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    output.rectOfInterest = CGRectMake(0.1, 0.1, 0.8, 0.8);
    /*
     output.rectOfInterest = CGRectMake(x, y, w, h);
     设定扫描区域 其中 原点位于左上角，x是从上往下算的，y是从左往右算的。w是垂直方向的高度，h是水平方向的宽度 四个参数的范围都是0-1
     */

    
    //创建会话
    self.session = [[AVCaptureSession alloc] init];
    [self.session setSessionPreset:AVCaptureSessionPresetHigh];
    [self.session addInput:input];
    [self.session addOutput:output];
    
    //输出类型 （在创建会话后设置）
    output.metadataObjectTypes = output.availableMetadataObjectTypes;

    /*
     //使用 availableMetadataObjectTypes  扫二维码 反应快 但是扫条形码慢，扫条形码的时候应该指定所有条形码类型，别包含二维码类型
     //确定为 条形码的类型
     @[AVMetadataObjectTypeUPCECode,AVMetadataObjectTypeCode93Code,AVMetadataObjectTypeCode128Code,AVMetadataObjectTypeEAN8Code,AVMetadataObjectTypeEAN13Code,AVMetadataObjectTypeCode39Code,AVMetadataObjectTypeCode39Mod43Code,
     AVMetadataObjectTypeInterleaved2of5Code,//ios 8 才有
     AVMetadataObjectTypeITF14Code,//ios8 才有
     ];
     //确定为 二维码的类型
     @[AVMetadataObjectTypeDataMatrixCode,AVMetadataObjectTypePDF417Code,AVMetadataObjectTypeQRCode,AVMetadataObjectTypeAztecCode,
     AVMetadataObjectTypeDataMatrixCode   //ios8 才有
     ];
     */
    
    self.layer = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
    self.layer.frame = self.view.layer.frame;
    self.layer.videoGravity = AVLayerVideoGravityResizeAspect;
    [self.view.layer insertSublayer:self.layer atIndex:0];
    
    [self.session startRunning];
}

-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    if (metadataObjects.count>0) {
        AVMetadataMachineReadableCodeObject *metadataObject = [metadataObjects objectAtIndex:0];
        if ([metadataObject isKindOfClass:[AVMetadataFaceObject class]]) {
            NSLog(@"--ht-- face detected!");
            //镜头刚扫到图片的时候 因为图片不清晰 会认为是面部表情 如果取 stringValue属性 会导致crash
            return;
        }
        
        if (metadataObject.stringValue!=nil) {
            NSString *str = metadataObject.stringValue;
            NSLog(@"--ht-- code :%@",str);
            //            if ([self.delegate respondsToSelector:@selector(scanViewControllerDidScan:)]) {
            //                [self.delegate scanViewControllerDidScan:str];
            //            }
        }else{
            NSLog(@"--ht-- catch a nil code");
        }
    }
}

-(void)stopScan {
    [self.session stopRunning];
    [self.layer removeFromSuperlayer];
}

@end
