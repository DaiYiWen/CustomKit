//
//  PopGestureHandler.m
//  Ugram
//
//  Created by zjh on 2025/2/25.
//  Version 1.1.0
//  Modified: 2025/2/28 添加多方向手势支持
//

#import "PopGestureHandler.h"

@interface PopGestureHandler ()<UIGestureRecognizerDelegate>

//pod spec lint PopGestureHandler.podspec --allow-warnings
//pod trunk push PopGestureHandler.podspec --allow-warnings

#pragma mark - 属性声明
/// 目标视图（弱引用避免循环）
@property (nonatomic, weak) UIView *targetView;
/// 触发交互式关闭的滑动比例（0.0~1.0）
@property (nonatomic, assign) CGFloat interactivePopPading;
/// 确认关闭的滑动阈值比例（0.0~1.0）
@property (nonatomic, assign) CGFloat interactivePopClosedPading;
/// 允许的手势方向集合
@property (nonatomic, assign) GestureDirection directions;
/// 当前识别的手势方向
@property (nonatomic, assign) GestureDirection currentDirection;
/// 视图初始中心点
@property (nonatomic, assign) CGPoint initialCenter;
/// 滑动手势识别器（强引用）
@property (nonatomic, strong) UIPanGestureRecognizer *panGesture;
/// 当前滑动偏移量
@property (nonatomic, assign) CGFloat currentOffset;

@end

@implementation PopGestureHandler

#pragma mark - 生命周期
/// 初始化手势控制器
/// @param view 需要添加手势的视图
/// @param directions 允许的手势方向集合
/// @param interactivePopPading 触发比例（0.0~1.0）
/// @param interactivePopClosedPading 完成比例（0.0~1.0）
- (instancetype)initWithView:(UIView *)view
                  directions:(GestureDirection)directions
        interactivePopPading:(CGFloat)interactivePopPading
     interactivePopClosedPading:(CGFloat)interactivePopClosedPading {
    if (self = [super init]) {
        _targetView = view;
        _directions = directions;
        _interactivePopPading = interactivePopPading;
        _interactivePopClosedPading = interactivePopClosedPading;
        
        // 设置抗锯齿优化
        view.layer.shouldRasterize = YES;
        view.layer.rasterizationScale = [UIScreen mainScreen].scale;
        
        [self setupGesture];
    }
    return self;
}

#pragma mark - 手势配置
/// 初始化滑动手势识别器
- (void)setupGesture {
    self.panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    self.panGesture.delegate = self;
    [_targetView addGestureRecognizer:self.panGesture];
    
    // 处理子视图中的滚动视图冲突
    for (UIView *view in [self.targetView subviews]) {
        if ([view isKindOfClass:[UIScrollView class]]) {
            UIScrollView *scroll = (UIScrollView *)view;
            scroll.bounces = NO;
            // 设置手势优先级：滚动视图手势需等待滑动手势失败
            [scroll.panGestureRecognizer requireGestureRecognizerToFail:self.panGesture];
        }
    }
}

#pragma mark - 手势处理
/// 处理滑动手势事件
/// @param gesture 滑动手势识别器
- (void)handlePan:(UIPanGestureRecognizer *)gesture {
    CGPoint translation = [gesture translationInView:_targetView.superview];
    
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan: {
            // 初始方向判断（取X/Y轴速度较大的方向）
            CGPoint velocity = [gesture velocityInView:self.targetView];
            self.currentDirection = (fabs(velocity.x) > fabs(velocity.y)) ?
                GestureDirectionRight : GestureDirectionDown;
            self.initialCenter = self.targetView.center;
            // 处理滚动视图冲突
            if(self.currentDirection != GestureDirectionRight) {
                UIScrollView *scrollView = [self findScrollViewInSubviews];
                if (scrollView && scrollView.contentOffset.y > 0.1) {
                    // 重置手势状态
                    gesture.enabled = NO;
                    gesture.enabled = YES;
                    return;
                }
            }
            // 触发开始回调
            if (self.animateViewToBeginBlock) {
                self.animateViewToBeginBlock();
            }
            break;
        }
            
        case UIGestureRecognizerStateChanged: {
            // 计算当前滑动偏移量
            CGFloat offset = 0;
            switch (self.currentDirection) {
                case GestureDirectionRight:
                    offset = translation.x*2.f; // X轴灵敏度系数
                    break;
                case GestureDirectionDown:
                    offset = translation.y; // Y轴灵敏度系数
                    break;
                default: break;
            }
            // 限制偏移量在有效范围（0 ~ 视图高度）
            offset = MIN(offset, CGRectGetHeight(self.targetView.bounds));
            [self updateViewPositionWithOffset:offset];
            break;
        }
            
        case UIGestureRecognizerStateEnded: {
            CGFloat totalDistance = CGRectGetHeight(self.targetView.bounds);
            CGFloat threshold = totalDistance * self.interactivePopClosedPading;
            
            // 根据最终偏移量决定动画方向
            if (self.currentOffset >= threshold) {
                NSTimeInterval duration = [self calculateAnimationDurationForOffset:self.currentOffset
                                                                      totalDistance:totalDistance];
                [self animateViewToCompletionWithDuration:duration];
            } else {
                NSTimeInterval duration = [self calculateAnimationDurationForOffset:0
                                                                      totalDistance:self.currentOffset];
                [self animateViewToInitialWithDuration:duration];
            }
            break;
        }
            
        default: break;
    }
}

#pragma mark - 视图动画
/// 更新视图位置
/// @param offset 当前滑动偏移量
- (void)updateViewPositionWithOffset:(CGFloat)offset {
    // 计算最大允许偏移量
    CGFloat maxOffset = CGRectGetHeight(self.targetView.bounds) * _interactivePopClosedPading;
    CGFloat clampedOffset = MIN(MAX(offset, 0), maxOffset);
    
    // 阈值检测（达到关闭条件时立即触发动画）
    if (clampedOffset >= maxOffset && self.autoCloseWhileDrag) {
        CGFloat totalDistance = CGRectGetHeight(self.targetView.bounds);
        NSTimeInterval duration = [self calculateAnimationDurationForOffset:self.currentOffset
                                                              totalDistance:totalDistance];
        [self animateViewToCompletionWithDuration:duration];
        return;
    }
    // 更新视图位置
    CGFloat newY = self.initialCenter.y + MAX(offset, 0);
    self.targetView.center = CGPointMake(self.initialCenter.x, newY);
    self.currentOffset = MAX(offset, 0);
}

/// 执行关闭动画
/// @param duration 动画持续时间
- (void)animateViewToCompletionWithDuration:(NSTimeInterval)duration {
    if (self.animateViewToCompletion) {
        self.animateViewToCompletion();
        [self invalidate];
        return;
    }
    
    [UIView animateWithDuration:duration
                          delay:0
         usingSpringWithDamping:0.7   // 弹簧阻尼（0~1，越小弹性越大）
          initialSpringVelocity:0.2   // 初始速度
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
        // 移动到屏幕下方外部
        self.targetView.center = CGPointMake(
            self.initialCenter.x,
            CGRectGetHeight(self.targetView.superview.bounds) + CGRectGetHeight(self.targetView.bounds)/2
        );
    } completion:^(BOOL finished) {
        if (self.gestureCompletion) {
            self.gestureCompletion();
        }
        [self invalidate];
    }];
}

/// 恢复初始位置动画
/// @param duration 动画持续时间
- (void)animateViewToInitialWithDuration:(NSTimeInterval)duration {
    [UIView animateWithDuration:duration
                          delay:0
         usingSpringWithDamping:0.7
          initialSpringVelocity:0.2
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
        self.targetView.center = self.initialCenter;
    } completion:nil];
}

#pragma mark - 工具方法
/// 计算动画持续时间
/// @param offset 当前偏移量
/// @param totalDistance 总滑动距离
- (NSTimeInterval)calculateAnimationDurationForOffset:(CGFloat)offset
                                      totalDistance:(CGFloat)totalDistance {
    // 线性计算持续时间：剩余距离/总距离 * 基准时间
    return ((totalDistance - offset) / totalDistance) * 0.3;
}

/// 查找子视图中的滚动视图
- (UIScrollView *)findScrollViewInSubviews {
    for (UIView *subview in self.targetView.subviews) {
        if ([subview isKindOfClass:[UIScrollView class]]) {
            return (UIScrollView *)subview;
        }
    }
    return nil;
}

#pragma mark - 手势代理
/// 解决与ScrollView的滑动冲突
/// @param gesture 当前手势识别器
- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gesture {
    UIScrollView *scrollView = [self findScrollViewInSubviews];
    if (!scrollView) return YES;
    
    // 速度向量分析
    CGPoint velocity = [gesture velocityInView:self.targetView.superview];
    BOOL isHorizontal = (fabs(velocity.x) > fabs(velocity.y)) && (velocity.x > 0);
    BOOL isVerticalDown = (fabs(velocity.y) > fabs(velocity.x)) && (velocity.y > 0);
    
    // 滚动视图位于顶部时才响应手势
    BOOL isAtTop = (scrollView.contentOffset.y + scrollView.contentInset.top <= 0.1);
    
    CGPoint location = [gesture locationInView:_targetView.superview];
    
    return ((isHorizontal && (location.x < self.targetView.width * _interactivePopPading)) || (isAtTop && isVerticalDown));
}

#pragma mark - 资源释放
/// 释放手势资源
- (void)invalidate {
    if (self.panGesture) {
        [self.targetView removeGestureRecognizer:self.panGesture];
        self.panGesture.delegate = nil;
        self.panGesture = nil;
    }
    self.gestureCompletion = nil;
}

- (void)setDirections:(GestureDirection)directions{
    _directions = directions;
}

@end
