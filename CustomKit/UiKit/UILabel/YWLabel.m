//
//  YWLabel.m
//  whiso
//
//  Created by apple on 2022/10/27.
//

#import "YWLabel.h"

@implementation YWLabel

/**
 自定义初始化
 */
+(UILabel*)initLabelColor:(NSString*)colorStr font:(UIFont*)font text:(NSString*)textStr{
    UILabel*label=[UILabel new];
    label.textColor=[UIColor D_ColorStr:colorStr];
    label.font=font;
    label.text=textStr;
    return label;
}

@end
