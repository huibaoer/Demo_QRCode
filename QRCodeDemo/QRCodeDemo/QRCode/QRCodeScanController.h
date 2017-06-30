//
//  QRCodeScanViewController.h
//  QRCodeDemo
//
//  Created by zhanght on 15/9/9.
//  Copyright (c) 2015年 haitao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol QRCodeScanControllerDelegate <NSObject>

- (void)onScanResult:(NSString *)result;

@end


@interface QRCodeScanController : UIViewController
@property (nonatomic, weak) id<QRCodeScanControllerDelegate> delegate;

@end
