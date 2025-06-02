//
//  UIButton+Click.h
//  Pyramid
//
//  Created by apple on 2021/7/20.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (Click)
//开启UIButton防连击事件控制
- (void)enableControlRepeatTouch;
//关闭UIButton防连击事件控制
- (void)disableControlRepeatTouch;
//设置防连续点击最小时间差(s),不设置则默认值是1.0s
- (void)setAllowRepeatTouchMinTimeInterval:(NSTimeInterval)interval;
@end

NS_ASSUME_NONNULL_END
