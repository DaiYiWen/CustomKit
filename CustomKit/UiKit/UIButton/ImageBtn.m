//
//  ImageBtn.m
//  whiso
//
//  Created by apple on 2022/10/26.
//

#import "ImageBtn.h"

@implementation ImageBtn

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

/**
 设置所有状态图片
 */
- (void)setAllStateImage:(NSString *)allStateImage{
    [self setImage:GetImage(allStateImage) forState:UIControlStateNormal];
    [self setImage:GetImage(allStateImage) forState:UIControlStateHighlighted];
    [self setImage:GetImage(allStateImage) forState:UIControlStateSelected];
}
/**
 设置普通状态图片
 */
- (void)setNormalImage:(NSString *)normalImage{
    [self setImage:GetImage(normalImage) forState:UIControlStateNormal];
}
/**
 设置高亮状态图片
 */
- (void)setHighlightedImage:(NSString *)highlightedImage{
    [self setImage:GetImage(highlightedImage) forState:UIControlStateHighlighted];
}
/**
 设置选中状态图片
 */
- (void)setSelectedImage:(NSString *)selectedImage{
    [self setImage:GetImage(selectedImage) forState:UIControlStateSelected];
}



/**
 添加响应事件
 */
-(void)addAction:(id)target actionName:(NSString*)actionName{
    [self addTarget:target action:NSSelectorFromString(actionName) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - Private instance methods

- (void)setButtonAnimation:(BOOL)buttonAnimation{
    [self addTarget:self action:@selector(scaleToSmall)
   forControlEvents:UIControlEventTouchDown | UIControlEventTouchDragEnter];
    [self addTarget:self action:@selector(scaleAnimation)
   forControlEvents:UIControlEventTouchUpInside];
    [self addTarget:self action:@selector(scaleToDefault)
   forControlEvents:UIControlEventTouchDragExit];
}

- (void)setup{
//    [self addTarget:self action:@selector(scaleToSmall)
//   forControlEvents:UIControlEventTouchDown | UIControlEventTouchDragEnter];
//    [self addTarget:self action:@selector(scaleAnimation)
//   forControlEvents:UIControlEventTouchUpInside];
//    [self addTarget:self action:@selector(scaleToDefault)
//   forControlEvents:UIControlEventTouchDragExit];
}

- (void)scaleToSmall
{
//    POPBasicAnimation *scaleAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
//    scaleAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(0.95f, 0.95f)];
//    [self.layer pop_addAnimation:scaleAnimation forKey:@"layerScaleSmallAnimation"];
}

- (void)scaleAnimation
{
//    POPSpringAnimation *scaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
//    scaleAnimation.velocity = [NSValue valueWithCGSize:CGSizeMake(1.5f, 1.5f)];
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

- (CGRect)imageRectForContentRect:(CGRect)bounds{
    return CGRectMake(0.0, 0.0, self.size.width, self.size.height);
}


@end
