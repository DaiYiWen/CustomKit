//
//  UIView+Tap.h
//  MaxWellProject
//
//  Created by admin on 2020/3/26.
//  Copyright © 2020 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^TapBlock)(void);

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Tap)

@property (nonatomic, copy) TapBlock tapBlock;


- (void)nyl_addTapGes:(TapBlock)block;

@property (nonatomic, assign) CGFloat testFloat;

/**
 自定义初始化
 */
+(UIView*)newBackColor:(NSString*)colorStr;


@end

NS_ASSUME_NONNULL_END
