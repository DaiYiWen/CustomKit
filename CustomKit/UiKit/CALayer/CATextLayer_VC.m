//
//  CATextLayer_VC.m
//  CustomKit
//
//  Created by 戴义文 on 2025/6/8.
//

#import "CATextLayer_VC.h"

@interface CATextLayer_VC ()

@end

@implementation CATextLayer_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    CATextLayer *TextLayer_A = [CATextLayer layer];
    TextLayer_A.frame = CGRectMake(20, [MySingleton sharedInstance].totalHeight+20, Screen_Width-40, 20);
    TextLayer_A.string = @"Hello ! CATextLayer";
    TextLayer_A.foregroundColor = [UIColor blackColor].CGColor;
    
    // 设置字体和大小
    UIFont *font = [UIFont systemFontOfSize:16.0];
    CFStringRef fontName = (__bridge CFStringRef)font.fontName;
    CGFontRef fontRef = CGFontCreateWithFontName(fontName);
    TextLayer_A.font = fontRef;
    TextLayer_A.fontSize = font.pointSize;
    CGFontRelease(fontRef);
    
    // 允许换行
    TextLayer_A.wrapped = YES;
    
    // 设置文本对齐方式
    TextLayer_A.alignmentMode = kCAAlignmentCenter;

    // 设置文本截断方式
    TextLayer_A.truncationMode = kCATruncationEnd;

    // 设置内容缩放比例（重要！避免Retina屏幕模糊）
    TextLayer_A.contentsScale = [UIScreen mainScreen].scale;
    
    [self.view.layer addSublayer:TextLayer_A];
    
    
    // 文本颜色动画
    CABasicAnimation *colorAnimation = [CABasicAnimation animationWithKeyPath:@"foregroundColor"];
    colorAnimation.fromValue = (id)[UIColor blackColor].CGColor;
    colorAnimation.toValue = (id)[UIColor redColor].CGColor;
    colorAnimation.duration = 2.0;
    colorAnimation.autoreverses = YES;
    colorAnimation.repeatCount = HUGE_VALF;
    [TextLayer_A addAnimation:colorAnimation forKey:@"colorAnimation"];

    // 文本位置动画
    CABasicAnimation *positionAnimation = [CABasicAnimation animationWithKeyPath:@"position.y"];
    positionAnimation.fromValue = @100;
    positionAnimation.toValue = @200;
    positionAnimation.duration = 3.0;
    positionAnimation.autoreverses = YES;
    [TextLayer_A addAnimation:positionAnimation forKey:@"positionAnimation"];
    
    
    // 创建渐变图层
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(20, [MySingleton sharedInstance].totalHeight+50, Screen_Width-40, 40);
    gradientLayer.colors = @[
        (id)[UIColor redColor].CGColor,
        (id)[UIColor blueColor].CGColor
    ];
    gradientLayer.startPoint = CGPointMake(0, 0.5);
    gradientLayer.endPoint = CGPointMake(1, 0.5);

    // 创建文本图层
    CATextLayer *gradientTextLayer = [CATextLayer layer];
    gradientTextLayer.frame = gradientLayer.bounds;
    gradientTextLayer.string = @"渐变文本效果";
    gradientTextLayer.font = (__bridge CFTypeRef)[UIFont boldSystemFontOfSize:20];
    gradientTextLayer.alignmentMode = kCAAlignmentCenter;
    gradientTextLayer.contentsScale = [UIScreen mainScreen].scale;

    // 将文本图层作为渐变图层的蒙版
    gradientLayer.mask = gradientTextLayer;

    // 添加到视图
    [self.view.layer addSublayer:gradientLayer];
    
    
    
    // 创建文本图层
    CATextLayer *marqueeLayer = [CATextLayer layer];
    marqueeLayer.frame = CGRectMake(20, [MySingleton sharedInstance].totalHeight+50+50, Screen_Width-40, 40);
    marqueeLayer.string = @"这是一条跑马灯文字效果，可以实现左右滚动显示... ";
    marqueeLayer.foregroundColor = [UIColor whiteColor].CGColor;
    marqueeLayer.backgroundColor = [UIColor blackColor].CGColor;
    marqueeLayer.fontSize = 16.0;
    marqueeLayer.alignmentMode = kCAAlignmentLeft;
    marqueeLayer.contentsScale = [UIScreen mainScreen].scale;

    // 计算文本宽度
    CGSize textSize = [marqueeLayer.string sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:16.0]}];
    CGFloat textWidth = textSize.width;

    // 创建动画
    CABasicAnimation *scrollAnimation = [CABasicAnimation animationWithKeyPath:@"position.x"];
    scrollAnimation.fromValue = @(self.view.bounds.size.width);
    scrollAnimation.toValue = @(-textWidth);
    scrollAnimation.duration = 10.0;
    scrollAnimation.repeatCount = HUGE_VALF;
    [marqueeLayer addAnimation:scrollAnimation forKey:@"scrollAnimation"];

    // 添加到视图
    [self.view.layer addSublayer:marqueeLayer];
    
    
    
    // 创建文本图层
    CATextLayer *outlineTextLayer = [CATextLayer layer];
    outlineTextLayer.frame = CGRectMake(20, [MySingleton sharedInstance].totalHeight+50+100, Screen_Width-40, 40);
    outlineTextLayer.string = @"描边文字";
    outlineTextLayer.fontSize = 30.0;
    outlineTextLayer.alignmentMode = kCAAlignmentCenter;
    outlineTextLayer.contentsScale = [UIScreen mainScreen].scale;

    // 设置文字颜色为透明（只显示描边）
    outlineTextLayer.foregroundColor = [UIColor systemBlueColor].CGColor;

    // 创建描边效果
//    outlineTextLayer.strokeColor = [UIColor blueColor].CGColor;
//    outlineTextLayer.strokeWidth = 2.0; // 描边宽度

    // 添加到视图
    [self.view.layer addSublayer:outlineTextLayer];
    
    
    //富文本
    CATextLayer *TextLayer_B = [CATextLayer layer];
    TextLayer_B.frame = CGRectMake(20, [MySingleton sharedInstance].totalHeight+200, Screen_Width-40, 20);
//    TextLayer_B.string = @"Hello ! CATextLayer";
//    TextLayer_B.foregroundColor = [UIColor blackColor].CGColor;
    // 创建富文本属性字典
    NSDictionary *attributes = @{
        NSFontAttributeName: [UIFont boldSystemFontOfSize:18],
        NSForegroundColorAttributeName: [UIColor redColor],
        NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle)
    };

    // 创建富文本
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:@"富文本示例" attributes:attributes];

    // 设置富文本内容
    TextLayer_B.string = attributedString;
    TextLayer_B.contentsScale = [UIScreen mainScreen].scale;
    
    [self.view.layer addSublayer:TextLayer_B];
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
