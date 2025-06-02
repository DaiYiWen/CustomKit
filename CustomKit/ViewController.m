//
//  ViewController.m
//  CustomKit
//
//  Created by 戴义文 on 2025/6/1.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    // 1. 创建FLAnimatedImageView
    FLAnimatedImageView *imageView = [[FLAnimatedImageView alloc] init];
    imageView.frame = CGRectMake(0, 0, 200, 200);
    [self.view addSubview:imageView];

    // 2. 加载GIF
    NSString *gifPath = [[NSBundle mainBundle] pathForResource:@"猫gif" ofType:@"gif"];
    NSData *gifData = [NSData dataWithContentsOfFile:gifPath];

    FLAnimatedImage *animatedImage = [FLAnimatedImage animatedImageWithGIFData:gifData];
    imageView.animatedImage = animatedImage;


}


@end
