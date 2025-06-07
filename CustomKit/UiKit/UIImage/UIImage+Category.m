//
//  UIImage+Category.m
//  GuiHuaRenSheng
//
//  Created by apple on 2018/6/5.
//  Copyright © 2018年 wancaishangwu. All rights reserved.
//

#import "UIImage+Category.h"
#import <AVKit/AVKit.h>
#import <objc/runtime.h>
#import <ImageIO/ImageIO.h>

@implementation UIImage (Category)

+ (void)load{
    
    Method imageNamed = class_getClassMethod(self,@selector(imageNamed:));
    Method looha_ImageNamed =class_getClassMethod(self,@selector(looha_none_imageNamed:));
    method_exchangeImplementations(imageNamed, looha_ImageNamed);
   
}

+ (instancetype)looha_none_imageNamed:(NSString*)name{
 
    if (NotEmpty_String(name)) {
        
      return  [self looha_none_imageNamed:name];
        
    }else{
        
        return nil;
    }
}


/**
 图片切圆
 
 @param radius 圆的大小
 @return 返回切圆图片
 */
- (UIImage *)imageWithCornerRadius:(CGFloat)radius
{
    CGRect rect = (CGRect){0.f, 0.f, self.size};
    
    UIGraphicsBeginImageContextWithOptions(self.size, NO, UIScreen.mainScreen.scale);
    CGContextAddPath(UIGraphicsGetCurrentContext(),
                     [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius].CGPath);
    CGContextClip(UIGraphicsGetCurrentContext());
    
    [self drawInRect:rect];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;

}

/**
 绘制图片
 
 @param color 颜色
 @param size 大小
 @return 返回图片
 */
+ (UIImage *)createImageColor:(UIColor *)color size:(CGSize)size
{
    
    //开启图形上下文
    @try {
        UIGraphicsBeginImageContextWithOptions(size, NO, 0);
        //绘制颜色区域
        UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, size.width, size.height)];
        [color setFill];
        [path fill];
        //    CGContextRef ctx = UIGraphicsGetCurrentContext();
        //    CGContextSetFillColorWithColor(ctx, color.CGColor);
        //    CGContextFillRect(ctx, CGRectMake(0, 0, size.width, size.height));
        //从图形上下文获取图片
        UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
        //关闭图形上下文
        UIGraphicsEndImageContext();
        
        return newImage;
    } @catch (NSException *exception) {
        return nil;
    } @finally {
        
    }
}
+ (UIImage *)createImageColor:(UIColor *)color size:(CGSize)size Radius:(CGFloat)radius{
    return [[self createImageColor:color size:size] imageWithCornerRadius:radius];
}
+ (UIImage *)createRedDotWithRadius:(CGFloat)radius{
    return [self createImageColor:[UIColor redColor] size:CGSizeMake(radius * 2, radius * 2) Radius:radius];
}
/**
 绘制图片
 
 @param color 颜色
 @param height 高度
 @return 返回图片
 */
+ (UIImage*)GetImageWithColor:(UIColor*)color andHeight:(CGFloat)height
{
    
    CGRect r= CGRectMake(0.0f, 0.0f, 100.0f, height);
    UIGraphicsBeginImageContext(r.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, r);
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}

/**
 获取视频第一帧图片
 
 @param videoURL 视频地址
 @return 返回视频第一帧图片
 */
+ (UIImage *)firstFrameWithVideoURL:(NSString *)videoURL
{
    AVURLAsset *asset = nil;
    if([videoURL isKindOfClass:[NSURL class]]){
        asset = [[AVURLAsset alloc] initWithURL:(NSURL *)videoURL options:nil];
    }else{
        asset = [[AVURLAsset alloc] initWithURL:[NSURL fileURLWithPath:videoURL] options:nil];
    }
    AVAssetImageGenerator *gen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    
    gen.appliesPreferredTrackTransform = YES;
    
    CMTime time = CMTimeMakeWithSeconds(1/60.f, 600);
    
    NSError *error = nil;
    
    CMTime actualTime;
    
    CGImageRef image = [gen copyCGImageAtTime:time actualTime:&actualTime error:&error];
    
    UIImage *thumb = [[UIImage alloc] initWithCGImage:image];
    
    CGImageRelease(image);
    
    return thumb;
}


/**
 压缩图片 
 @param image 图片
 @param kb 大小
 @return 压缩后图片
 */
+ (UIImage *)scaleImage:(UIImage *)image toKb:(NSInteger)kb{
    
    if (!image) {
        return image;
    }
    if (kb<1) {
        return image;
    }
    
    kb*=1024;
    
    CGFloat compression = 0.9f;
    CGFloat maxCompression = 0.1f;
    NSData *imageData = UIImageJPEGRepresentation(image, compression);
    while ([imageData length] > kb && compression > maxCompression) {
        compression -= 0.1;
        imageData = UIImageJPEGRepresentation(image, compression);
    }
    NSLog(@"当前大小:%fkb",(float)[imageData length]/1024.0f);
    UIImage *compressedImage = [UIImage imageWithData:imageData];
    return compressedImage;
}

- (UIImage *)fixOrientation {
    
    // No-op if the orientation is already correct
    if (self.imageOrientation == UIImageOrientationUp) return self;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (self.imageOrientation) {
        case UIImageOrientationUp:
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, self.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, self.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
    }
    
//    switch (self.imageOrientation) {
//        case UIImageOrientationUpMirrored:
//        case UIImageOrientationDownMirrored:
//            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
//            transform = CGAffineTransformScale(transform, -1, 1);
//            break;
//
//        case UIImageOrientationLeftMirrored:
//        case UIImageOrientationRightMirrored:
//            transform = CGAffineTransformTranslate(transform, self.size.height, 0);
//            transform = CGAffineTransformScale(transform, -1, 1);
//            break;
//    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, self.size.width, self.size.height,
                                             CGImageGetBitsPerComponent(self.CGImage), 0,
                                             CGImageGetColorSpace(self.CGImage),
                                             CGImageGetBitmapInfo(self.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (self.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.height,self.size.width), self.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.width,self.size.height), self.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

- (UIImage *)addWatermarkInImage:(NSArray<NSString *> *)images titles:(NSArray<NSString *> *)titles{
    //开启一个图形上下文
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0);
    //绘制上下文：1-绘制图片
    [self drawInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    
    UIImage *image1 = [UIImage imageWithColor:[UIColor.blackColor colorWithAlphaComponent:0.3] size:CGSizeMake(self.size.width, 210)];
    [image1 drawAtPoint:CGPointMake(0, 0)];
    
    for (int i = 0; i < images.count; i++) {
        CGPoint point = CGPointMake(30, 30+i*50);
        UIImage *image = [UIImage imageNamed:images[i]];
        [image drawAtPoint:point];
        //绘制上下文：2-添加文字到上下文
        NSDictionary *dic = @{
                              NSFontAttributeName:[UIFont systemFontOfSize:30],
                              NSForegroundColorAttributeName:[UIColor whiteColor]
                              };
        NSString *string = titles[i];
        
        CGPoint point1 = CGPointMake(40 + image.size.width, 30+i*50);
        [string drawAtPoint:point1 withAttributes:dic];
    }
    //从图形上下文中获取合成的图片
    UIImage *watermarkImage = UIGraphicsGetImageFromCurrentImageContext();
    
    //关闭上下文
    UIGraphicsEndImageContext();
    
    return watermarkImage;
}
- (UIImage *)addWatermarkInImage:(UIImage *)watermarkImage{
    // 创建一个新的图形上下文，大小与原始图片相同
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0);
    
    // 绘制原始图片
    [self drawInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    
    // 计算水印图片缩放比例（这里简化处理，保持原始水印图片的比例）
    float scale = MIN(self.size.width / watermarkImage.size.width, self.size.height / watermarkImage.size.height);
    float width = watermarkImage.size.width * scale;
    float height = watermarkImage.size.height * scale;
    
    // 计算水印图片的位置（这里以给定的 position 为中心点）
    CGRect watermarkRect = CGRectZero;
    
    // 确保水印图片在原始图片内部
    watermarkRect = CGRectIntersection(watermarkRect, CGRectMake(0, 0, self.size.width, self.size.height));
    
    // 绘制水印图片
    [watermarkImage drawInRect:watermarkRect];
    
    // 获取新图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 结束图形上下文
    UIGraphicsEndImageContext();
    
    return newImage;
}


+ (UIImage *)imageWithLetter:(NSString *)letter fontSize:(CGFloat)fontSize imageSize:(CGSize)size{
    // 计算文字的大小
    CGSize textSize = [letter sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}];
      
    // 创建一个足够大的图形上下文来包含文字
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
      
    // 获取当前图形上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
      
    // 设置填充颜色为黑色（你可以根据需要更改颜色）
//    [ZUIColor_HeadBack setFill];
//    UIRectFill(CGRectMake(0, 0, textSize.width + 20, textSize.height + 20));
    
    // 设置文字的位置（这里我们将其置于图像的中心）
    CGPoint textPoint = CGPointMake((size.width - textSize.width) / 2.0,
                                    (size.height - textSize.height) / 2.0);
      
    // 绘制文字
    [letter drawAtPoint:textPoint withAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor whiteColor]}];
      
    // 从图形上下文中获取图像
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
      
    // 结束图形上下文
    UIGraphicsEndImageContext();
      
    // 返回生成的图像
    return image;
}
+ (UIImage *)imageWithLetter:(NSString *)letter font:(UIFont *)font imageSize:(CGSize)size backColor:(UIColor *)backColor textColor:(UIColor *)textColor{
    // 计算文字的大小
    CGSize textSize = [letter sizeWithAttributes:@{NSFontAttributeName:font}];
      
    // 创建一个足够大的图形上下文来包含文字
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
      
    // 获取当前图形上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
      
    // 设置填充颜色为黑色（你可以根据需要更改颜色）
    [backColor setFill];
      
    // 设置文字的位置（这里我们将其置于图像的中心）
    CGPoint textPoint = CGPointMake(ceilf((size.width - textSize.width) / 2.0),
                                    ceilf((size.height - textSize.height) / 2.0));
      
    // 绘制文字
    [letter drawAtPoint:textPoint withAttributes:@{NSFontAttributeName: font,NSForegroundColorAttributeName:textColor}];
      
    // 从图形上下文中获取图像
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
      
    // 结束图形上下文
    UIGraphicsEndImageContext();
      
    // 返回生成的图像
    return image;
}

+ (UIImage *)gradientImageWithStartColor:(UIColor *)startColor size:(CGSize)size {
    // 创建一个图形上下文，用于绘制图片
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    
    // 获取当前图形上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 创建一个渐变层
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(0, 0, size.width, size.height);
    
    // 设置渐变层的颜色，这里我们只需要设置起始颜色和结束颜色
    // 结束颜色我们设置为起始颜色的较暗或较亮版本，或者完全不同的颜色
    UIColor *endColor = [startColor colorWithAlphaComponent:0.3];
    UIColor *endColor1 = [startColor colorWithAlphaComponent:0.9];// 示例：将透明度减半的相同颜色
    gradientLayer.colors = @[(id)[endColor CGColor],(id)[endColor CGColor], (id)[startColor CGColor]];
    
    // 设置渐变方向为从上到下
    gradientLayer.startPoint = CGPointMake(0.5, 0.0);
    gradientLayer.endPoint = CGPointMake(0.5, 1.0);
    
    // 渲染渐变层到图形上下文中
    [gradientLayer renderInContext:context];
    
    // 从图形上下文中获取图片
    UIImage *gradientImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 结束图形上下文
    UIGraphicsEndImageContext();
    
    return gradientImage;
}
+ (UIImage *)createImageSize:(CGSize)imageSize gradientColors:(NSArray *)colors percentage:(NSArray *)percents gradientType:(GradientType)gradientType {
    NSAssert(percents.count == colors.count, @"颜色和百分比数组的长度必须相同");
    NSAssert(percents.count <= 5, @"输入颜色数量过多，请确保百分比和颜色数组的长度不超过5");
    
    NSMutableArray *colorRefs = [NSMutableArray array];
    for (UIColor *color in colors) {
        [colorRefs addObject:(id)color.CGColor];
    }
    
    CGFloat locations[percents.count];
    for (NSUInteger i = 0; i < percents.count; i++) {
        locations[i] = [percents[i] floatValue] / 100.0; // 假设百分比是以0-100为范围的，需要转换为0-1
    }
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB(); // 使用设备RGB颜色空间
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)colorRefs, locations);
    
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0); // 通常不需要设置scale为1，除非你有特定的理由
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGPoint start, end;
    switch (gradientType) {
        case GradientFromTopToBottom:
            start = CGPointMake(imageSize.width / 2.0, 0.0);
            end = CGPointMake(imageSize.width / 2.0, imageSize.height);
            break;
        case GradientFromLeftToRight:
            start = CGPointMake(0.0, imageSize.height / 2.0);
            end = CGPointMake(imageSize.width, imageSize.height / 2.0);
            break;
        case GradientFromLeftTopToRightBottom:
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(imageSize.width, imageSize.height);
            break;
        case GradientFromLeftBottomToRightTop:
            start = CGPointMake(0.0, imageSize.height);
            end = CGPointMake(imageSize.width, 0.0);
            break;
        default:
            NSAssert(NO, @"未知的渐变类型");
            break;
    }
    
    CGContextDrawLinearGradient(context, gradient, start, end, 0); // 通常不需要设置kCGGradientDrawsBeforeStartLocation和kCGGradientDrawsAfterEndLocation
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
    UIGraphicsEndImageContext();
    
    return image;
}

@end
