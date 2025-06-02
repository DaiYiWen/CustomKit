//
//  UIImageView+UIImageViewNew.m
//  whiso
//
//  Created by apple on 2022/11/2.
//

#import "UIImageView+UIImageViewNew.h"

@implementation UIImageView (UIImageViewNew)
+(UIImageView*)newImage:(NSString*)imageStr{
    if (imageStr.length<=0) {
        imageStr=@"启动图1";
    }
    UIImageView*newimage=[UIImageView new];
    newimage.image=GetImage(imageStr);
    newimage.contentMode=UIViewContentModeScaleAspectFill;
    newimage.clipsToBounds = YES;
    return newimage;
}

@end
