//
//  UIView_VC.m
//  CustomKit
//
//  Created by 戴义文 on 2025/6/7.
//

#import "UIView_VC.h"

@interface UIView_VC ()
@property (nonatomic,strong) UIView *view_A;
@end

@implementation UIView_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGFloat width = Screen_Width/4;
    
    
#pragma mark - plain
    
    UIView *view_A = [[UIView alloc]initWithFrame:CGRectMake(20, [MySingleton sharedInstance].totalHeight+30, width, width)];
    view_A.backgroundColor = [UIColor systemBlueColor];
    [self.view addSubview:view_A];
    self.view_A = view_A;
    
    
//    [UIView animateWithDuration:1 animations:^{
//        view_A.transform = CGAffineTransformMakeScale(0.9, 1.1);
        
//        view_A.transform = CGAffineTransformMakeTranslation(100,0);
        
//        view_A.transform = CGAffineTransformMakeRotation(1);
//    }];
    
    
    UIView *view_B = [[UIView alloc]initWithFrame:CGRectMake(20+width+10, [MySingleton sharedInstance].totalHeight+30, width, width)];
    view_B.backgroundColor = [UIColor systemRedColor];
    view_B.layer.cornerRadius = 10;
    view_B.clipsToBounds = YES;
    [self.view addSubview:view_B];
    
    UIView *view_C = [[UIView alloc]initWithFrame:CGRectMake(20+width*2+20, [MySingleton sharedInstance].totalHeight+30, width, width)];
    view_C.backgroundColor = [UIColor systemCyanColor];
    view_C.layer.cornerRadius = 10;
    view_C.layer.maskedCorners = kCALayerMinXMinYCorner | kCALayerMaxXMinYCorner;
    view_C.clipsToBounds = YES;
    [self.view addSubview:view_C];
    
    UIView *view_D = [[UIView alloc]initWithFrame:CGRectMake(20, [MySingleton sharedInstance].totalHeight+30+width+20, width, width)];
    view_D.backgroundColor = [UIColor whiteColor];
    view_D.layer.borderWidth = 1;
    view_D.layer.borderColor = [UIColor systemFillColor].CGColor;
    [self.view addSubview:view_D];
    
    UIView *view_E = [[UIView alloc]initWithFrame:CGRectMake(20+width+10, [MySingleton sharedInstance].totalHeight+30+width+20, width, width)];
    view_E.backgroundColor = [UIColor systemBrownColor];
    view_E.layer.shadowColor = [UIColor systemMintColor].CGColor;
    view_E.layer.shadowOffset = CGSizeMake(10, 10);
    view_E.layer.shadowRadius = 5;
    view_E.layer.shadowOpacity = 0.7;
    [self.view addSubview:view_E];
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = touches.anyObject;
    
    CGPoint touchPoint = [touch locationInView:self.view];
    
    touchPoint = [self.view convertPoint:touchPoint toView:self.view_A];
    
    if ([self.view_A pointInside:touchPoint withEvent:event]) {
        [UIView animateWithDuration:0.2 animations:^{
            self.view_A.transform = CGAffineTransformMakeScale(0.9, 0.9);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.2 animations:^{
                self.view_A.transform = CGAffineTransformMakeScale(1.0, 1.0);
            }];
        }];
    }
    
    [UIView animateWithDuration:0.2 animations:^{
        
//        self.view_A.center = touchPoint;
        
        
    }];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
