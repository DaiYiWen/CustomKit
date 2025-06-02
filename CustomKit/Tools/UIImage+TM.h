//
//  UIImage+TM.h
//  TMDemo
//
//  Created by TIM on 2018/7/23.
//  Copyright © 2018年 tim. All rights reserved.
//

#import <UIKit/UIKit.h>

// 圆角
typedef NS_ENUM(NSInteger, YKImageRoundedCornerCorner) {
    YKImageRoundedCornerCornerTopLeft = 1,
    YKImageRoundedCornerCornerTopRight = 1 << 1,
    YKImageRoundedCornerCornerBottomRight = 1 << 2,
    YKImageRoundedCornerCornerBottomLeft = 1 << 3
};

@interface UIImage (TM)

/**
 高性能绘圆形图片
 
 @return 圆形图片
 */
- (UIImage *)rounded;

/**
 高性能绘制圆角图片(默认绘制4个圆角)
 
 @param radius 圆角
 @return 圆角图片
 */
- (UIImage *)roundedWithRadius:(CGFloat)radius;

/**
 高性能绘制圆角图片
 
 @param radius 圆角
 @param cornerMask 要绘制的圆角
 @return 圆角图片
 */
- (UIImage *)roundedWithRadius:(CGFloat)radius cornerMask:(YKImageRoundedCornerCorner)cornerMask;

@end
