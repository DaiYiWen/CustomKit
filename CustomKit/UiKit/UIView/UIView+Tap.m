//
//  UIView+Tap.m
//  MaxWellProject
//
//  Created by admin on 2020/3/26.
//  Copyright © 2020 admin. All rights reserved.
//

#import "UIView+Tap.h"
#import <objc/runtime.h>

const char *blockKey = "blockKey";


@interface UIView ()

@property (nonatomic, assign) NSTimeInterval custom_acceptEventInterval; // 可以用这个给重复点击加间隔

@end

@implementation UIView (Tap)

/**
 自定义初始化
 */
+(UIView*)newBackColor:(NSString*)colorStr{
    UIView*view=[UIView new];
    view.backgroundColor=[UIColor D_ColorStr:colorStr];
    return view;
}

+(void)load{
//    DLog(@"load方法执行了++++++++++++++++++");
}

- (void)setTapBlock:(TapBlock)tapBlock {
    objc_setAssociatedObject(self, &blockKey, tapBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (TapBlock)tapBlock {
    return objc_getAssociatedObject(self, &blockKey);
}

- (void)nyl_addTapGes:(TapBlock)block {
    self.tapBlock = block; // 把block赋值给self.tapBlock, 可以在当前函数之外执行该回调
    self.userInteractionEnabled=YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGes)];
    [self addGestureRecognizer:tap];
}

- (NSTimeInterval )custom_acceptEventInterval{
    return [objc_getAssociatedObject(self, "UIControl_acceptEventInterval") doubleValue];
}

- (void)setCustom_acceptEventInterval:(NSTimeInterval)custom_acceptEventInterval{
    objc_setAssociatedObject(self, "UIControl_acceptEventInterval", @(custom_acceptEventInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSTimeInterval )custom_acceptEventTime{
    return [objc_getAssociatedObject(self, "UIControl_acceptEventTime") doubleValue];
}

- (void)setCustom_acceptEventTime:(NSTimeInterval)custom_acceptEventTime{
    objc_setAssociatedObject(self, "UIControl_acceptEventTime", @(custom_acceptEventTime), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)testFloat{
    return [objc_getAssociatedObject(self, "test_Float") floatValue];
}

- (void)setTestFloat:(CGFloat)testFloat{
    objc_setAssociatedObject(self, "test_Float", @(testFloat), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)tapGes {
    
//    DLog(@"custom_acceptEventInterval=========%lf",self.custom_acceptEventInterval);
    // 如果想要设置统一的间隔时间，可以在此处加上以下几句
    // 值得提醒一下：如果这里设置了统一的时间间隔，只会影响UIButton, 如果想统一设置，也想影响UISwitch，建议将UIButton分类，改成UIControl分类，实现方法是一样的
    if (self.custom_acceptEventInterval <= 0) {
        // 如果没有自定义时间间隔，则默认为.4秒
        self.custom_acceptEventInterval = 0.5;
    }
    // 是否小于设定的时间间隔
    BOOL needSendAction = (NSDate.date.timeIntervalSince1970 - self.custom_acceptEventTime >= self.custom_acceptEventInterval);
    
    // 更新上一次点击时间戳
    if (self.custom_acceptEventInterval > 0) {
        self.custom_acceptEventTime = NSDate.date.timeIntervalSince1970;
    }
//    self.testFloat=5.9;
    
//    DLog(@"测试浮点数======%lf",self.testFloat);
    
    // 两次点击的时间间隔小于设定的时间间隔时，才执行响应事件
    if (needSendAction) {
        if (self.tapBlock) {
            self.tapBlock(); // 执行回调
        }
    }
    
}

@end
