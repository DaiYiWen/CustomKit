//
//  ImageBtn.h
//  whiso
//
//  Created by apple on 2022/10/26.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ImageBtn : UIButton

/**
 按钮点击的间隔时间
 */
@property(nonatomic,assign)NSTimeInterval time;

/**
 开启动画
 */
@property (nonatomic, assign) BOOL buttonAnimation;

/**
 设置所有状态图片
 */
@property (nonatomic, copy) NSString *allStateImage;

/**
 设置普通状态图片
 */
@property (nonatomic, copy) NSString *normalImage;
/**
 设置高亮状态图片
 */
@property (nonatomic, copy) NSString *highlightedImage;
/**
 设置选中状态图片
 */
@property (nonatomic, copy) NSString *selectedImage;



/**
 添加响应事件
 */
-(void)addAction:(id)target actionName:(NSString*)actionName;

@end

NS_ASSUME_NONNULL_END
