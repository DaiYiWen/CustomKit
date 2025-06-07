//
//  UIColor+D.h
//

#import <UIKit/UIKit.h>

#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (D)

// 颜色转换：iOS中（以#开头）十六进制的颜色转换为UIColor(RGB)
+ (UIColor *)D_ColorStr: (NSString *)color;

// 透明
+ (UIColor *)D_ColorStr: (NSString *)color Alpha:(CGFloat)Alpha;

// 生成渐变色
+ (CAGradientLayer *)setGradualChangingColor:(UIView *)view fromColor:(NSString *)fromHexColorStr toColor:(NSString *)toHexColorStr;
@end

NS_ASSUME_NONNULL_END
