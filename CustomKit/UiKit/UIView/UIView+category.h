//
//  UIView+category.h
//  Ugram
//
//  Created by zjh on 2022/6/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (category)

/// 添加到window
- (void)addToWindow;

+ (UIView *)getSingleLineView;

- (UIViewController *)getViewController;
+ (UIWindow *)getCurrentWindow;
- (void)addShadowToView;
- (void)addShadowToView:(UIColor *)color;

- (void)shakeDirection:(UICollectionViewScrollDirection)direction times:(int)times interval:(NSTimeInterval)interval delta:(CGFloat) delta finished:(void (^ __nullable)(BOOL finished))completion;
- (void)showCurProjectErr:(NSString *)error;

@end

NS_ASSUME_NONNULL_END
