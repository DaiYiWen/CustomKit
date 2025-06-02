//
//  UIColor+D.h
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (D)
// 颜色转换：iOS中（以#开头）十六进制的颜色转换为UIColor(RGB)
+ (UIColor *)D_ColorStr: (NSString *)color;
+ (UIColor *)D_ColorStrB: (NSString *)color Alpha:(CGFloat)Alpha;

+ (CAGradientLayer *)setGradualChangingColor:(UIView *)view fromColor:(NSString *)fromHexColorStr toColor:(NSString *)toHexColorStr;
@end

NS_ASSUME_NONNULL_END
