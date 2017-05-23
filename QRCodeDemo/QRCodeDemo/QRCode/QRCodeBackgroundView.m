//
//  QRCodeBackgroundView.m
//  ttt
//
//  Created by zhanght on 15/9/14.
//  Copyright (c) 2015年 haitao. All rights reserved.
//

#import "QRCodeBackgroundView.h"



static const CGFloat kWhiteRectLineWidth = 0.5;//白色框的线宽

static const CGFloat kCornerLineLength = 15;//四个角的绿色折线的边长
static const CGFloat kCornerLineWidth = 2;//绿色折线的线宽
static const CGFloat kCornerLineOffSet = (kCornerLineWidth-kWhiteRectLineWidth)/2;//绿色折线相对于白色线框的偏移量

@interface QRCodeBackgroundView ()
@property (assign, nonatomic) CGRect holeRect;
@property (strong, nonatomic) UIImageView *line;
@property (strong, nonatomic) UILabel *label;
@end

@implementation QRCodeBackgroundView


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.opaque = NO;
        self.backgroundColor = [UIColor clearColor];
        
        CGFloat holeRectSideLength = frame.size.width-100;
        _holeRect = CGRectMake(50, 128, holeRectSideLength, holeRectSideLength);
        
        _line = [[UIImageView alloc] initWithFrame:CGRectMake(_holeRect.origin.x, _holeRect.origin.y, _holeRect.size.width, 2)];
        _line.image = [UIImage imageNamed:@"line"];
        [self addSubview:_line];
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
        animation.toValue = [NSNumber numberWithFloat:holeRectSideLength];
        animation.duration = 1.9;
        animation.removedOnCompletion = NO;
        animation.fillMode = kCAFillModeForwards;
        animation.repeatCount = LONG_MAX;
        [_line.layer addAnimation:animation forKey:nil];
        
        _label = [[UILabel alloc] initWithFrame:CGRectMake(0, _holeRect.origin.y+_holeRect.size.height+20, frame.size.width, 30)];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.textColor = [UIColor whiteColor];
        _label.text = @"将二维码/条码放入框内，即可自动扫描";
        _label.font = [UIFont systemFontOfSize:13];
        [self addSubview:_label];
        
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
    
    // Start by filling the area with the blue color
    [[[UIColor blackColor] colorWithAlphaComponent:0.5] setFill];
    UIRectFill( rect );
    
    // Assume that there's an ivar somewhere called holeRect of type CGRect
    // We could just fill holeRect, but it's more efficient to only fill the
    // area we're being asked to draw.
    CGRect holeRectIntersection = CGRectIntersection( self.holeRect, rect );
    [[UIColor clearColor] setFill];
    UIRectFill( holeRectIntersection );
    
    UIBezierPath *whiteRect = [UIBezierPath bezierPathWithRect:self.holeRect];
    whiteRect.lineWidth = kWhiteRectLineWidth;
    [[UIColor whiteColor] setStroke];
    [whiteRect stroke];
    
    //cornerLine1 左上角
    UIBezierPath *cornerLine1 = [UIBezierPath bezierPath];
    cornerLine1.lineWidth = kCornerLineWidth;
    [cornerLine1 moveToPoint:CGPointMake(self.holeRect.origin.x+kCornerLineOffSet, self.holeRect.origin.y + kCornerLineLength)];
    [cornerLine1 addLineToPoint:CGPointMake(self.holeRect.origin.x+kCornerLineOffSet, self.holeRect.origin.y +kCornerLineOffSet)];
    [cornerLine1 addLineToPoint:CGPointMake(self.holeRect.origin.x + kCornerLineLength, self.holeRect.origin.y+kCornerLineOffSet)];
    [[UIColor greenColor] setStroke];
    [cornerLine1 stroke];
    //cornerLine2 右上角
    UIBezierPath *cornerLine2 = [UIBezierPath bezierPath];
    cornerLine2.lineWidth = kCornerLineWidth;
    [cornerLine2 moveToPoint:CGPointMake(self.holeRect.origin.x+self.holeRect.size.width-kCornerLineLength-kCornerLineOffSet, self.holeRect.origin.y + kCornerLineOffSet)];
    [cornerLine2 addLineToPoint:CGPointMake(self.holeRect.origin.x+self.holeRect.size.width-kCornerLineOffSet, self.holeRect.origin.y+kCornerLineOffSet)];
    [cornerLine2 addLineToPoint:CGPointMake(self.holeRect.origin.x+self.holeRect.size.width-kCornerLineOffSet, self.holeRect.origin.y+kCornerLineOffSet+kCornerLineLength)];
    [[UIColor greenColor] setStroke];
    [cornerLine2 stroke];
    //cornerLine3 左下角
    UIBezierPath *cornerLine3 = [UIBezierPath bezierPath];
    cornerLine3.lineWidth = kCornerLineWidth;
    [cornerLine3 moveToPoint:CGPointMake(self.holeRect.origin.x+kCornerLineOffSet, self.holeRect.origin.y+self.holeRect.size.height-kCornerLineLength-kCornerLineOffSet)];
    [cornerLine3 addLineToPoint:CGPointMake(self.holeRect.origin.x+kCornerLineOffSet, self.holeRect.origin.y+self.holeRect.size.height-kCornerLineOffSet)];
    [cornerLine3 addLineToPoint:CGPointMake(self.holeRect.origin.x+kCornerLineOffSet+kCornerLineLength, self.holeRect.origin.y+self.holeRect.size.height-kCornerLineOffSet)];
    [[UIColor greenColor] setStroke];
    [cornerLine3 stroke];
    //cornerLine4 右下角
    UIBezierPath *cornerLine4 = [UIBezierPath bezierPath];
    cornerLine4.lineWidth = kCornerLineWidth;
    [cornerLine4 moveToPoint:CGPointMake(self.holeRect.origin.x+kCornerLineOffSet+self.holeRect.size.width-kCornerLineLength, self.holeRect.origin.y+self.holeRect.size.height-kCornerLineOffSet)];
    [cornerLine4 addLineToPoint:CGPointMake(self.holeRect.origin.x+self.holeRect.size.width-kCornerLineOffSet, self.holeRect.origin.y+self.holeRect.size.height-kCornerLineOffSet)];
    [cornerLine4 addLineToPoint:CGPointMake(self.holeRect.origin.x+self.holeRect.size.width-kCornerLineOffSet, self.holeRect.origin.y+self.holeRect.size.height-kCornerLineLength-kCornerLineOffSet)];
    [[UIColor greenColor] setStroke];
    [cornerLine4 stroke];
    
}


@end
