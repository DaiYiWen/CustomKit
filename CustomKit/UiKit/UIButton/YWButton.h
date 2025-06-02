//
//  YWButton.h
//  whiso
//
//  Created by apple on 2022/10/31.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YWButton : UIButton
/**
 设置label
 */
-(void)setLabelColor:(NSString*)colorStr font:(UIFont*)font text:(NSString*)textStr;

/**
 添加响应事件
 */
-(void)addAction:(id)target actionName:(NSString*)actionName;

/**
 设置普通状态背景
 */
@property (nonatomic, copy) NSString *normalColor;
/**
 设置高亮状态背景
 */
@property (nonatomic, copy) NSString *highlightedColor;

/**
 设置labeltext
 */
@property (nonatomic, copy) NSString *labeltext;

/**
 开启动画
 */
@property (nonatomic, assign) BOOL buttonAnimation;

@end

NS_ASSUME_NONNULL_END
