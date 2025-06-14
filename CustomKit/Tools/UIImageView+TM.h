//
//  UIImageView+TM.h
//  TMDemo
//
//  Created by TIM on 2018/7/23.
//  Copyright © 2018年 tim. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (TM)

/**
 高性能绘制带圆角图片
 
 @param image 原始图片
 @param imageViewSize UIImageView的size，绘制必须先确定size
 @param cornerRadius 圆角
 @return UIImageView
 */
+ (UIImageView *)imageViewWithImage:(UIImage *)image
                      imageViewSize:(CGSize)imageViewSize
                       cornerRadius:(CGFloat)cornerRadius;

/**
 高性能绘制带圆角+阴影图片
 
 @param image 原始图片
 @param imageViewSize UIImageView的size，绘制必须先确定size
 @param cornerRadius 圆角
 @param horizontal 水平阴影
 @param vertical 垂直阴影
 @param shadowColor 阴影颜色
 @param shadowOpacity shadowOpacity
 @param shadowRadius shadowRadius
 @return UIImageView
 */
+ (UIImageView *)imageViewWithImage:(UIImage *)image
                      imageViewSize:(CGSize)imageViewSize
                       cornerRadius:(CGFloat)cornerRadius
                         horizontal:(CGFloat)horizontal
                           vertical:(CGFloat)vertical
                        shadowColor:(UIColor *)shadowColor
                      shadowOpacity:(float)shadowOpacity
                       shadowRadius:(CGFloat)shadowRadius;

@end
