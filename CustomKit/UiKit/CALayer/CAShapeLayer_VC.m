//
//  CAShapeLayer_VC.m
//  CustomKit
//
//  Created by 戴义文 on 2025/6/7.
//

#import "CAShapeLayer_VC.h"

@interface CAShapeLayer_VC ()

@end

@implementation CAShapeLayer_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 禁用隐式动画
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    
    
    CGFloat width = Screen_Width/4;
    
#pragma mark - CALayer
    CALayer *caLayer_A = [CALayer layer];
    caLayer_A.frame =  CGRectMake(20+10+width, [MySingleton sharedInstance].totalHeight+30, width, width);
    caLayer_A.backgroundColor = [UIColor systemBlueColor].CGColor;
    [self.view.layer addSublayer:caLayer_A];

    // 脉冲动画
    CABasicAnimation *scaleAnim = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnim.fromValue = @1.0;
    scaleAnim.toValue = @1.1;
    scaleAnim.duration = 1.0;
    scaleAnim.autoreverses = YES;
    scaleAnim.repeatCount = HUGE_VALF;
    [caLayer_A addAnimation:scaleAnim forKey:@"pulse"];

    CABasicAnimation *opacityAnim = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnim.fromValue = @1.0;
    opacityAnim.toValue = @0.5;
    opacityAnim.duration = 1.0;
    opacityAnim.autoreverses = YES;
    opacityAnim.repeatCount = HUGE_VALF;
    [caLayer_A addAnimation:opacityAnim forKey:@"opacity"];
    
    CALayer *caLayer_B = [CALayer layer];
    caLayer_B.frame =  CGRectMake(20+20+width*2, [MySingleton sharedInstance].totalHeight+30, width, width);
    caLayer_B.contents = (__bridge id)GetImage(@"icon").CGImage;
    caLayer_B.cornerRadius = 15;
    caLayer_B.masksToBounds = YES;
    caLayer_B.borderWidth = 2;
    caLayer_B.borderColor = [UIColor systemPinkColor].CGColor;
    [self.view.layer addSublayer:caLayer_B];
    
    
    
#pragma mark - shapeLayer(圆角加边框使用shapeLayer替代可以避免离屏渲染)
    
    CAShapeLayer *shapeLayer_A = [CAShapeLayer layer];
    shapeLayer_A.frame =  CGRectMake(20, [MySingleton sharedInstance].totalHeight+30, width, width);
    shapeLayer_A.backgroundColor = [UIColor systemGray6Color].CGColor;
    [self.view.layer addSublayer:shapeLayer_A];
    
    UIBezierPath *bezierPath_A = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, width, width) cornerRadius:width/2];
    shapeLayer_A.path = bezierPath_A.CGPath;
    shapeLayer_A.fillColor = [UIColor whiteColor].CGColor;
    shapeLayer_A.strokeColor = [UIColor systemBlueColor].CGColor;
    shapeLayer_A.lineWidth = 4;
    shapeLayer_A.strokeStart = 0.0;
    shapeLayer_A.strokeEnd = 0.0;
    
//    // 创建路径动画
//    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
//    pathAnimation.fromValue = (__bridge id)bezierPath.CGPath;
//    pathAnimation.toValue = (__bridge id)bezierPath.CGPath;
//    pathAnimation.duration = 10.0;
//    [shapeLayer_A addAnimation:pathAnimation forKey:@"pathAnimation"];
    
    // 添加进度动画
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.duration = 8.5;
    animation.fromValue = @0.0;
    animation.toValue = @1.0;
    [shapeLayer_A addAnimation:animation forKey:@"progressAnimation"];
    
    
    CAShapeLayer *shapeLayer_B = [CAShapeLayer layer];
    shapeLayer_B.frame =  CGRectMake(20, [MySingleton sharedInstance].totalHeight+50+width, width, width);
    shapeLayer_B.backgroundColor = [UIColor systemBrownColor].CGColor;
    [self.view.layer addSublayer:shapeLayer_B];
    
    UIBezierPath *bezierPath_B = [UIBezierPath bezierPath];
    [bezierPath_B moveToPoint:CGPointMake(width/2, 15)];
    [bezierPath_B addLineToPoint:CGPointMake(width-15,width-15)];
    [bezierPath_B addLineToPoint:CGPointMake(15, width-15)];
    [bezierPath_B closePath]; // 闭合路径
    shapeLayer_B.path = bezierPath_B.CGPath;
    shapeLayer_B.strokeColor = [UIColor systemRedColor].CGColor;
    shapeLayer_B.fillColor = [UIColor whiteColor].CGColor;
    shapeLayer_B.lineWidth  = 3;
    
    
    CAShapeLayer *shapeLayer_C = [CAShapeLayer layer];
    shapeLayer_C.frame =  CGRectMake(20+10+width, [MySingleton sharedInstance].totalHeight+50+width, width, width);
    shapeLayer_C.backgroundColor = [UIColor systemMintColor].CGColor;
    [self.view.layer addSublayer:shapeLayer_C];
    
    // 创建路径对象
    UIBezierPath *bezierPath_C = [UIBezierPath bezierPath];
    // 设置起点
    [bezierPath_C moveToPoint:CGPointMake(0, width/2)];
    // 添加曲线
    [bezierPath_C addCurveToPoint:CGPointMake(width, width/2)
           controlPoint1:CGPointMake(width/4, 10)
           controlPoint2:CGPointMake(width-(width/4), width-10)];

    shapeLayer_C.path = bezierPath_C.CGPath;
    shapeLayer_C.fillColor = [UIColor yellowColor].CGColor;
    shapeLayer_C.strokeColor = [UIColor redColor].CGColor;
    shapeLayer_C.lineWidth = 2.0;
    
    
    
    
    // 模拟数据点
    NSArray *dataPoints = @[@100, @150, @90, @200, @130, @180];
    UIBezierPath *chartPath = [UIBezierPath bezierPath];
    [chartPath moveToPoint:CGPointMake(50, [dataPoints[0] floatValue])];

    // 连接数据点形成平滑曲线
    for (int i = 1; i < dataPoints.count; i++) {
        CGFloat x = 50 + i * 60;
        CGFloat y = [dataPoints[i] floatValue];
        CGFloat prevX = 50 + (i-1) * 60;
        CGFloat prevY = [dataPoints[i-1] floatValue];
        
        // 计算控制点
        CGPoint cp1 = CGPointMake(prevX + (x - prevX)/2, prevY);
        CGPoint cp2 = CGPointMake(prevX + (x - prevX)/2, y);
        
        [chartPath addCurveToPoint:CGPointMake(x, y)
                    controlPoint1:cp1
                    controlPoint2:cp2];
    }

    CAShapeLayer *chartLayer = [CAShapeLayer layer];
    chartLayer.path = chartPath.CGPath;
    chartLayer.fillColor = [UIColor clearColor].CGColor;
    chartLayer.strokeColor = [UIColor greenColor].CGColor;
    chartLayer.lineWidth = 3.0;

    [self.view.layer addSublayer:chartLayer];
    
    // 创建特殊形状路径
    UIBezierPath *buttonPath = [UIBezierPath bezierPath];
    [buttonPath moveToPoint:CGPointMake(50, 50)];
    [buttonPath addCurveToPoint:CGPointMake(150, 50)
                 controlPoint1:CGPointMake(75, 0)
                 controlPoint2:CGPointMake(125, 0)];
    [buttonPath addLineToPoint:CGPointMake(200, 100)];
    [buttonPath addCurveToPoint:CGPointMake(50, 100)
                 controlPoint1:CGPointMake(150, 150)
                 controlPoint2:CGPointMake(100, 150)];
    [buttonPath closePath];

    // 创建按钮图层
    CAShapeLayer *buttonLayer = [CAShapeLayer layer];
    buttonLayer.path = buttonPath.CGPath;
    buttonLayer.fillColor = [UIColor purpleColor].CGColor;
    buttonLayer.strokeColor = [UIColor whiteColor].CGColor;
    buttonLayer.lineWidth = 2.0;
    buttonLayer.frame = CGRectMake(20+width*2, [MySingleton sharedInstance].totalHeight+50+width, 250, 150);

//    // 添加点击手势
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(specialButtonTapped)];
//    [buttonLayer addGestureRecognizer:tap];

    [self.view.layer addSublayer:buttonLayer];
    
    
    // 基于数学心形曲线公式
    UIBezierPath *mathHeartPath = [UIBezierPath bezierPath];

    CGFloat scale = 10.0;  // 缩放因子
    CGFloat dx = 100.0;    // x偏移
    CGFloat dy = 100.0;    // y偏移

    // 绘制心形曲线
    for (CGFloat t = 0; t <= 2 * M_PI; t += 0.01) {
        CGFloat x = 16 * pow(sin(t), 3);
        CGFloat y = 13 * cos(t) - 5 * cos(2*t) - 2 * cos(3*t) - cos(4*t);
        
        CGPoint point = CGPointMake(-x * scale + dx, -y * scale + dy);
        
        if (t == 0) {
            [mathHeartPath moveToPoint:point];
        } else {
            [mathHeartPath addLineToPoint:point];
        }
    }

    [mathHeartPath closePath];

    // 创建形状图层
    CAShapeLayer *mathHeartLayer = [CAShapeLayer layer];
    mathHeartLayer.path = mathHeartPath.CGPath;
    mathHeartLayer.fillColor = [UIColor systemPinkColor].CGColor;
    mathHeartLayer.strokeColor = [UIColor darkGrayColor].CGColor;
    mathHeartLayer.lineWidth = 1.5;

    [self.view.layer addSublayer:mathHeartLayer];
    
    // 心跳动画
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.toValue = @1.2;
    scaleAnimation.duration = 0.5;
    scaleAnimation.autoreverses = YES;
    scaleAnimation.repeatCount = HUGE_VALF;
    [mathHeartLayer addAnimation:scaleAnimation forKey:@"heartbeat"];

    // 颜色变化动画
    CABasicAnimation *colorAnimation = [CABasicAnimation animationWithKeyPath:@"fillColor"];
    colorAnimation.toValue = (__bridge id)[UIColor colorWithRed:1.0 green:0.2 blue:0.2 alpha:1.0].CGColor;
    colorAnimation.duration = 1.0;
    colorAnimation.autoreverses = YES;
    colorAnimation.repeatCount = HUGE_VALF;
    [mathHeartLayer addAnimation:colorAnimation forKey:@"colorChange"];
    
    
    // 创建爱心路径
    UIBezierPath *heartButtonPath = [UIBezierPath bezierPath];
    [heartButtonPath moveToPoint:CGPointMake(50, 35)];
    [heartButtonPath addCurveToPoint:CGPointMake(0, 35) controlPoint1:CGPointMake(35, 0) controlPoint2:CGPointMake(0, 0)];
    [heartButtonPath addCurveToPoint:CGPointMake(50, 100) controlPoint1:CGPointMake(0, 70) controlPoint2:CGPointMake(35, 100)];
    [heartButtonPath addCurveToPoint:CGPointMake(100, 35) controlPoint1:CGPointMake(65, 100) controlPoint2:CGPointMake(100, 70)];
    [heartButtonPath addCurveToPoint:CGPointMake(50, 35) controlPoint1:CGPointMake(100, 0) controlPoint2:CGPointMake(65, 0)];
    [heartButtonPath closePath];

    // 创建按钮图层
    CAShapeLayer *heartButtonLayer = [CAShapeLayer layer];
    heartButtonLayer.path = heartButtonPath.CGPath;
    heartButtonLayer.fillColor = [UIColor redColor].CGColor;
    heartButtonLayer.strokeColor = [UIColor whiteColor].CGColor;
    heartButtonLayer.lineWidth = 2.0;
    heartButtonLayer.frame = CGRectMake(100, 300, 100, 100);

//    // 添加点击手势
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(heartButtonTapped)];
//    [heartButtonLayer addGestureRecognizer:tap];

    [self.view.layer addSublayer:heartButtonLayer];
    
    [CATransaction commit];
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
