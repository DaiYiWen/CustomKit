//
//  UIColor_VC.m
//  CustomKit
//
//  Created by qa-test on 2025/6/5.
//

#import "UIColor_VC.h"

@interface UIColor_VC ()

@property (nonatomic, strong) UIView *colorView_C;

@end

@implementation UIColor_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *colorView_A = [UIView new];
    colorView_A.backgroundColor = RGBA(115, 115, 195, 1);
    [self.view addSubview:colorView_A];
    [colorView_A mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset([MySingleton sharedInstance].totalHeight+20);
        make.width.offset(Screen_Width-100);
        make.height.offset(Screen_Height/5);
    }];
    
    
    UIView *colorView_B = [UIView new];
    colorView_B.backgroundColor = RGBA(115, 115, 195, 0.5);
    [self.view addSubview:colorView_B];
    [colorView_B mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(colorView_A.mas_bottom).offset(20);
        make.width.offset(Screen_Width-100);
        make.height.offset(Screen_Height/5);
    }];
    
    
    UIView *colorView_C = [UIView new];
    colorView_C.backgroundColor = RGBA(238, 129, 177, 1);
    [self.view addSubview:colorView_C];
    [colorView_C mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(colorView_B.mas_bottom).offset(20);
        make.width.offset(Screen_Width-100);
        make.height.offset(Screen_Height/5);
    }];
    
    self.colorView_C = colorView_C;

    
}

- (void)viewDidLayoutSubviews{
    
    [super viewDidLayoutSubviews];
    
//    self.colorView_C.layer.mask = [UIColor setGradualChangingColor:self.colorView_C fromColor:@"#40B0BF" toColor:@"C3914B"];
    
//    [self.colorView_C.layer addSublayer:[UIColor setGradualChangingColor:self.colorView_C fromColor:@"#40B0BF" toColor:@"C3914B"]];
    
    //    CAGradientLayer类对其绘制渐变背景颜色、填充层的形状(包括圆角)
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.colorView_C.bounds;
    //  创建渐变色数组，需要转换为CGColor颜色
    gradientLayer.colors = @[(__bridge id)RGBA(238, 129, 177, 1).CGColor,(__bridge id)RGBA(115, 115, 195, 0.5).CGColor];
    //  设置渐变颜色方向，左上点为(0,0), 右下点为(1,1)
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 1);
    //  设置颜色变化点，取值范围 0.0~1.0
    gradientLayer.locations = @[@0,@1];
    
    [self.colorView_C.layer addSublayer:gradientLayer];
    
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
