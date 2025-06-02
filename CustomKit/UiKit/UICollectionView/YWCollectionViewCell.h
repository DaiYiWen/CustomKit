//
//  YWCollectionViewCell.h
//  whiso
//
//  Created by apple on 2022/11/2.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YWCollectionViewCell : UICollectionViewCell
@property (nonatomic,weak) UIViewController *owner;
@property (nonatomic,assign) NSInteger celltag;
@end

NS_ASSUME_NONNULL_END
