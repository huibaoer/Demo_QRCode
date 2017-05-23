//
//  MyQRCodeViewController.m
//  QRCodeDemo
//
//  Created by zhanght on 15/9/14.
//  Copyright (c) 2015年 haitao. All rights reserved.
//

#import "MyQRCodeViewController.h"
#import "QRCodeCreator.h"

@interface MyQRCodeViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation MyQRCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"我的二维码";
    
    //self.imageView.image = [QRCodeCreator QRCodeImageWithString:@"www.devhaitao.com" imageSideLength:300.0f];
    self.imageView.image = [QRCodeCreator QRCodeImageWithString:@"www.devhaitao.com" imageSideLength:300.0f red:255 green:97 blue:0];
    
    // set shadow
    self.imageView.layer.shadowOffset = CGSizeMake(0, 2);
    self.imageView.layer.shadowRadius = 2;
    self.imageView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.imageView.layer.shadowOpacity = 0.5;
}



@end
