//
//  QRCodeCreator.h
//  QRCodeDemo
//
//  Created by zhanght on 15/9/14.
//  Copyright (c) 2015年 haitao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface QRCodeCreator : NSObject

/**
 *  创建黑白二维码
 *
 *  @param string     二维码包含的信息
 *  @param sideLength 二维码的边长
 *
 *  @return 二维码
 */
+ (UIImage *)QRCodeImageWithString:(NSString *)string imageSideLength:(CGFloat)sideLength;

/**
 *  创建彩色二维码
 *
 *  @param string     二维码包含的信息
 *  @param sideLength 二维码的边长
 *  @param red        二维码rgb颜色值r （0~255）
 *  @param green      二维码rgb颜色值g （0~255）
 *  @param blue       二维码rgb颜色值b （0~255）
 *
 *  @return 二维码
 */
+ (UIImage *)QRCodeImageWithString:(NSString *)string imageSideLength:(CGFloat)sideLength red:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue;

@end
