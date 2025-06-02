//
//  UIButton+FillColorButton.h
//  whiso
//
//  Created by apple on 2022/10/31.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (FillColorButton)


- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state;
 
@property (nonatomic, strong) NSString * titleName;

@end

NS_ASSUME_NONNULL_END
