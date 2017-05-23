//
//  RootViewController.m
//  QRCodeDemo
//
//  Created by zhanght on 15/9/9.
//  Copyright (c) 2015年 haitao. All rights reserved.
//

#import "RootViewController.h"
#import "QRCodeScanViewController.h"
#import "MyQRCodeViewController.h"

#import "MLSelectPhotoAssets.h"
#import "MLSelectPhotoPickerAssetsViewController.h"
#import "MLSelectPhotoBrowserViewController.h"

@interface RootViewController ()
@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    
}

- (IBAction)scanButtonAction:(id)sender {
    QRCodeScanViewController *qr = [[QRCodeScanViewController alloc] init];
    [self.navigationController pushViewController:qr animated:YES];
}

- (IBAction)myQRCodeButtonAction:(id)sender {
    MyQRCodeViewController *vc = [[MyQRCodeViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)imageQRCodeAction:(id)sender {
    // 创建控制器
    MLSelectPhotoPickerViewController *pickerVc = [[MLSelectPhotoPickerViewController alloc] init];
    // 默认显示相册里面的内容SavePhotos
    pickerVc.status = PickerViewShowStatusCameraRoll;
    pickerVc.maxCount = 1;
    [pickerVc showPickerVc:self];
    __weak typeof(self) weakSelf = self;
    pickerVc.callBack = ^(NSArray *assets){
        if (assets && assets.count) {
            // 1.取出选中的图片
            MLSelectPhotoAssets *asset = assets[0];
            UIImage *image = [MLSelectPhotoPickerViewController getImageWithImageObj:asset];
            CIImage *ciImage = image.CIImage;
            if (!ciImage) {
                ciImage = [[CIImage alloc] initWithCGImage:image.CGImage];
            }
            
            // 2.从选中的图片中读取二维码数据
            // 2.1创建一个探测器
            CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:@{CIDetectorAccuracy: CIDetectorAccuracyLow}];
            
            // 2.2利用探测器探测数据
            NSArray *feature = [detector featuresInImage:ciImage];
            
            // 2.3取出探测到的数据
            for (CIQRCodeFeature *result in feature) {
                // NSLog(@"%@",result.messageString);
                NSString *urlStr = result.messageString;
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"二维码内容" message:urlStr delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [alert show];
            }
        }
    };
}

@end
