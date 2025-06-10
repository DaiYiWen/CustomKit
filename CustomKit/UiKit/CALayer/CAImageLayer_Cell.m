//
//  CAImageLayer_Cell.m
//  CustomKit
//
//  Created by 戴义文 on 2025/6/9.
//

#import "CAImageLayer_Cell.h"
#import "SDWebImageManager.h"
@interface CAImageLayer_Cell()

@property (nonatomic,strong) CALayer *imageLayer;

@end

@implementation CAImageLayer_Cell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.imageLayer = [CALayer layer];
//        self.imageLayer.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        self.imageLayer.backgroundColor = [UIColor systemBlueColor].CGColor;
        self.imageLayer.contentsScale = [UIScreen mainScreen].scale; // 避免模糊
        [self.layer addSublayer:self.imageLayer];
    }
    return self;
}

- (void)setCellRow:(NSInteger)cellRow{
    _cellRow = cellRow;
    
    // 使用 SDWebImage 加载图片
    NSURL *imageURL = [NSURL URLWithString:@"https://picsum.photos/id/4/5000/3333"];
    
    // 使用SDWebImageManager检查缓存
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    
//    [manager loadImageWithURL:imageURL options:0 progress:nil completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
//        
//        self.imageLayer.contents = (__bridge id)image.CGImage;
//        
//        
//    }];
    
//    [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:imageURL completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
//        
//        
//        self.imageLayer.contents = (__bridge id)image.CGImage;
////        self.imageLayer.contentsGravity = kCAGravityResizeAspectFill;
//        
//    }];
//    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.imageLayer.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
