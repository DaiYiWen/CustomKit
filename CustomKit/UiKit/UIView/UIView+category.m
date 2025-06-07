//
//  UIView+category.m
//  Ugram
//
//  Created by zjh on 2022/6/22.
//

#import "UIView+category.h"
#import "SceneDelegate.h"

@implementation UIView (category)


- (void)addToWindow
{
//    id appDelegate = [[UIApplication sharedApplication] delegate];
//
//    if ([appDelegate respondsToSelector:@selector(window)])
//    {
//        UIWindow * window = (UIWindow *) [appDelegate performSelector:@selector(window)];
//        [window addSubview:self];
//    }
    [[UIView getCurrentWindow] addSubview:self];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo([UIView getCurrentWindow]);
    }];
}
+ (UIView *)getSingleLineView{
    UIView *line1 = [[UIView alloc] init];
//    line1.backgroundColor = ZUIColor_SingleLine;
    return line1;
}

- (UIViewController *)getViewController{
    UIResponder *responder = [self nextResponder];
    do {
        if ([responder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)responder;
        }
        responder = [responder nextResponder];
    } while (responder != nil);
    return nil;
}
+ (UIWindow *)getCurrentWindow{
    UIWindow *window = nil;
    if (@available(iOS 13.0, *)) {
        NSSet *scenes = [[UIApplication sharedApplication] connectedScenes];
        SceneDelegate *windowSce = [[[scenes allObjects] firstObject] delegate];
        window = windowSce.window;
    } else {
        // Fallback on earlier versions
        window = [UIApplication sharedApplication].delegate.window;
    }
    return window;
}
- (void)addShadowToView{
    
//    [self addShadowToView:KColorBlack8];
//    // 单边阴影 顶边
//    float shadowPathWidth = self.layer.shadowRadius;
//    CGRect shadowRect = CGRectMake(0, 0-shadowPathWidth/2.0, self.bounds.size.width, shadowPathWidth);
//    UIBezierPath *path = [UIBezierPath bezierPathWithRect:shadowRect];
//    self.layer.shadowPath = path.CGPath;
    
}
- (void)addShadowToView:(UIColor *)color{
    self.layer.shadowColor = color.CGColor;
    self.layer.shadowOffset = CGSizeMake(0,1);
    self.layer.shadowOpacity = 1;
    self.layer.shadowRadius = 12;
    self.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(12, 12)].CGPath;
}
-(void)shakeDirection:(UICollectionViewScrollDirection)direction times:(int)times interval:(NSTimeInterval)interval delta:(CGFloat) delta finished:(void (^ __nullable)(BOOL finished))completion{

    if (times == 0) {

        self.transform = CGAffineTransformIdentity;
        if (completion) {
            completion(true);
        }
    }else{
            [UIView animateWithDuration:interval animations:^{
                switch (direction) {

                    case UICollectionViewScrollDirectionHorizontal:

                    {

                        self.transform = CGAffineTransformMakeTranslation(delta, 0);

                    }

                        break;

                    case UICollectionViewScrollDirectionVertical:{

                        self.transform = CGAffineTransformMakeTranslation(0,delta);

                    }

                        break;

                    default:

                        break;

                }

                } completion:^(BOOL finish) {
                    [self shakeDirection:direction times:times-1 interval:interval delta:delta * -1 finished:completion];

                }];

    }

}

- (void)showCurProjectErr:(NSString *)error{
//    weakSelf(self);
//    [[self getViewController] presentViewController:[Tools getAlertViewController:@"" withMessage:error sure:ZLanguage(@"确定")] animated:true completion:^{
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [[weakSelf getViewController].navigationController popViewControllerAnimated:true];
//        });
//    }];
}

@end
