//
//  UIButton+FillColorButton.m
//  whiso
//
//  Created by apple on 2022/10/31.
//

#import "UIButton+FillColorButton.h"
#import "objc/runtime.h"

static const void * titleNameBy = &titleNameBy;
@implementation UIButton (FillColorButton)
@dynamic titleName;
// 添加自定义属性
-(void)setTitleName:(NSString *)titleName {
    objc_setAssociatedObject(self, titleNameBy, titleName, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
-(NSString *)titleName {
    return objc_getAssociatedObject(self, titleNameBy);
}
// 设置背景颜色for state
- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state {
    [self setBackgroundImage:[UIButton imageWithColor:backgroundColor] forState:state];
}
// 设置颜色
+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
