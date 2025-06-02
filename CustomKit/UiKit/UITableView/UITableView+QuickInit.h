//
//  UITableView+QuickInit.h
//  whiso
//
//  Created by apple on 2022/11/1.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (QuickInit)

/**
 自定义初始化
 */
+(UITableView*)initDelegate:(id)delegate style:(UITableViewStyle)style;

@end

NS_ASSUME_NONNULL_END
