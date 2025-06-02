//
//  UICollectionView+UICollectionViewNew.m
//  whiso
//
//  Created by apple on 2022/11/2.
//

#import "UICollectionView+UICollectionViewNew.h"

@implementation UICollectionView (UICollectionViewNew)

/**
 自定义初始化
 */
+(UICollectionView*)initVertical:(id)delegate{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    // 设置collectionView的滚动方向，需要注意的是如果使用了collectionview的headerview或者footerview的话， 如果设置了水平滚动方向的话，那么就只有宽度起作用了了
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    layout.minimumInteritemSpacing = 0;// 垂直方向的间距
    layout.minimumLineSpacing = 0; // 水平方向的间距
    UICollectionView*CollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
//    CollectionView.backgroundColor = [UIColor clearColor];
//        _CollectionView.backgroundColor = [UIColor redColor];
    CollectionView.dataSource = delegate;
    CollectionView.delegate = delegate;
//    CollectionView.emptyDataSetSource = delegate;
//    CollectionView.emptyDataSetDelegate = delegate;
    CollectionView.alwaysBounceVertical = YES;  // 垂直
    CollectionView.alwaysBounceHorizontal = NO;   // 水平
    CollectionView.showsVerticalScrollIndicator = NO;
    CollectionView.showsHorizontalScrollIndicator = NO;
//    CollectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    return CollectionView;
}

+(UICollectionView*)initHorizontal:(id)delegate{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    // 设置collectionView的滚动方向，需要注意的是如果使用了collectionview的headerview或者footerview的话， 如果设置了水平滚动方向的话，那么就只有宽度起作用了了
    [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
//    layout.minimumInteritemSpacing = 0;// 垂直方向的间距
//    layout.minimumLineSpacing = 0; // 水平方向的间距
    UICollectionView*CollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
//    CollectionView.backgroundColor = [UIColor clearColor];
//        _CollectionView.backgroundColor = [UIColor redColor];
    CollectionView.dataSource = delegate;
    CollectionView.delegate = delegate;
//    CollectionView.emptyDataSetSource = delegate;
//    CollectionView.emptyDataSetDelegate = delegate;
    CollectionView.alwaysBounceVertical = NO;  // 垂直
    CollectionView.alwaysBounceHorizontal = YES;   // 水平
    CollectionView.showsVerticalScrollIndicator = NO;
    CollectionView.showsHorizontalScrollIndicator = NO;
//    CollectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    return CollectionView;
}

@end
