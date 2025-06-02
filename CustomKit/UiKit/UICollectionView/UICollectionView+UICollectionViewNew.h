//
//  UICollectionView+UICollectionViewNew.h
//  whiso
//
//  Created by apple on 2022/11/2.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UICollectionView (UICollectionViewNew)

/**
 自定义初始化
 */
+(UICollectionView*)initVertical:(id)delegate;
+(UICollectionView*)initHorizontal:(id)delegate;
@end

NS_ASSUME_NONNULL_END
