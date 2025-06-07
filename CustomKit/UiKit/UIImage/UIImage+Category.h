//
//  UIImage+Category.h
//  GuiHuaRenSheng
//
//  Created by apple on 2018/6/5.
//  Copyright © 2018年 wancaishangwu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    GradientFromTopToBottom,
    GradientFromLeftToRight,
    GradientFromLeftTopToRightBottom,
    GradientFromLeftBottomToRightTop
} GradientType;

@interface UIImage (Category)

/**
 图片切圆

 @param radius 圆的大小
 @return 返回切圆图片
 */
- (UIImage *)imageWithCornerRadius:(CGFloat)radius;
/**
 绘制图片
 @param color 颜色
 @param size 大小
 @return 返回图片
 */
+ (UIImage *)createImageColor:(UIColor *)color size:(CGSize)size;

+ (UIImage *)createImageColor:(UIColor *)color size:(CGSize)size Radius:(CGFloat)radius;

+ (UIImage *)createRedDotWithRadius:(CGFloat)radius;

/**
 绘制图片
 @param color 颜色
 @param height 高度
 @return 返回图片
 */
+ (UIImage *)GetImageWithColor:(UIColor*)color andHeight:(CGFloat)height;
/**
 获取视频第一帧图片

 @param videoURL 视频地址
 @return 返回视频第一帧图片
 */
+ (UIImage *)firstFrameWithVideoURL:(NSString *)videoURL;
/**
 压缩图片
 @param image 图片
 @param kb 大小
 @return 压缩后图片
 */
+ (UIImage *)scaleImage:(UIImage *)image toKb:(NSInteger)kb;
//获取正常朝向图片
- (UIImage *)fixOrientation;

- (UIImage *)addWatermarkInImage:(NSArray<NSString *> *)images titles:(NSArray<NSString *> *)titles;

- (UIImage *)addWatermarkInImage:(UIImage *)image;
// 修复图片边缘透明度的方法
+ (NSData *)fixImageAlpha:(NSData *)imageData;

+ (UIImage *)imageWithLetter:(NSString *)letter fontSize:(CGFloat)fontSize imageSize:(CGSize)size;

+ (UIImage *)imageWithLetter:(NSString *)letter font:(UIFont *)font imageSize:(CGSize)size backColor:(UIColor *)backColor textColor:(UIColor *)textColor;
+ (UIImage *)createImageSize:(CGSize)imageSize gradientColors:(NSArray *)colors percentage:(NSArray *)percents gradientType:(GradientType)gradientType;
+ (UIImage *)gradientImageWithStartColor:(UIColor *)startColor size:(CGSize)size;

@end
