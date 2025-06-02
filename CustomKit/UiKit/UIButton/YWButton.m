//
//  YWButton.m
//  whiso
//
//  Created by apple on 2022/10/31.
//

#import "YWButton.h"

@implementation YWButton

/**
 设置label
 */
-(void)setLabelColor:(NSString*)colorStr font:(UIFont*)font text:(NSString*)textStr{
    self.titleLabel.font = font;
    [self setTitle:textStr forState:UIControlStateNormal];
    [self setTitleColor:[UIColor D_ColorStr:colorStr] forState:UIControlStateNormal];
}

/**
 设置labeltext
 */

- (void)setLabeltext:(NSString *)labeltext{
    [self setTitle:labeltext forState:UIControlStateNormal];
}

/**
 添加响应事件
 */
-(void)addAction:(id)target actionName:(NSString*)actionName{
    [self addTarget:target action:NSSelectorFromString(actionName) forControlEvents:UIControlEventTouchUpInside];
}


/**
 设置普通状态背景
 */
- (void)setNormalColor:(NSString *)normalColor{
    [self setBackgroundColor:[UIColor D_ColorStr:normalColor] forState:UIControlStateNormal];
}


/**
 设置高亮状态背景
 */
- (void)setHighlightedColor:(NSString *)highlightedColor{
    [self setBackgroundColor:[UIColor D_ColorStr:highlightedColor] forState:UIControlStateHighlighted];
}


- (void)setButtonAnimation:(BOOL)buttonAnimation{
    [self addTarget:self action:@selector(scaleToSmall)
   forControlEvents:UIControlEventTouchDown | UIControlEventTouchDragEnter];
    [self addTarget:self action:@selector(scaleAnimation)
   forControlEvents:UIControlEventTouchUpInside];
    [self addTarget:self action:@selector(scaleToDefault)
   forControlEvents:UIControlEventTouchDragExit];
}
- (void)scaleToSmall
{
//    POPBasicAnimation *scaleAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
//    scaleAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(0.97f, 0.97f)];
//    [self.layer pop_addAnimation:scaleAnimation forKey:@"layerScaleSmallAnimation"];
}

- (void)scaleAnimation
{
//    POPSpringAnimation *scaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
//    scaleAnimation.velocity = [NSValue valueWithCGSize:CGSizeMake(1.10f, 1.10f)];
//    scaleAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(1.f, 1.f)];
//    scaleAnimation.springBounciness = 18.0f;
//    [self.layer pop_addAnimation:scaleAnimation forKey:@"layerScaleSpringAnimation"];
}

- (void)scaleToDefault
{
//    POPBasicAnimation *scaleAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
//    scaleAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(1.f, 1.f)];
//    [self.layer pop_addAnimation:scaleAnimation forKey:@"layerScaleDefaultAnimation"];
}
@end
