//
//  UILabel+UILabelNew.h
//  whiso
//
//  Created by apple on 2022/11/2.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (UILabelNew)
/**
 自定义初始化
 */
+(UILabel*)newLabelColor:(NSString*)colorStr font:(UIFont*)font text:(NSString*)textStr;


/**
 获取宽度
 */
+ (CGFloat)getWidthWithLabel:(UILabel *)label;
/**
 获取宽度
 */
+ (CGFloat)getWidthWithTitle:(NSString *)title font:(UIFont *)font;

/**
 获取高度
 */
+ (CGFloat)getHeightByWidth:(CGFloat)width title:(NSString *)title font:(UIFont*)font;


+(NSMutableAttributedString * ) getTextStringLineSpace:(NSString *) string lineSpace:(CGFloat)space;

/**
 *  改变行间距
 */
+ (void)changeLineSpaceForLabel:(UILabel *)label WithSpace:(float)space;

/**
 *  改变字间距
 */
+ (void)changeWordSpaceForLabel:(UILabel *)label WithSpace:(float)space;

/**
 *  改变行间距和字间距
 */
+ (void)changeSpaceForLabel:(UILabel *)label withLineSpace:(float)lineSpace WordSpace:(float)wordSpace;
@end

NS_ASSUME_NONNULL_END
