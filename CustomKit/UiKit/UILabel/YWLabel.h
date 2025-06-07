//
//  YWLabel.h
//  whiso
//
//  Created by apple on 2022/10/27.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YWLabel : UILabel
/**
 自定义初始化
 */
+(UILabel*)initLabelColor:(NSString*)colorStr font:(UIFont*)font text:(NSString*)textStr;

@end

NS_ASSUME_NONNULL_END
