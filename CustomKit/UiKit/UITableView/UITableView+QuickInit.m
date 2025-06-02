//
//  UITableView+QuickInit.m
//  whiso
//
//  Created by apple on 2022/11/1.
//

#import "UITableView+QuickInit.h"

@implementation UITableView (QuickInit)
+(UITableView*)initDelegate:(id)delegate style:(UITableViewStyle)style{
    UITableView*tableview=[[UITableView alloc]initWithFrame:CGRectZero style:style];
    tableview.showsVerticalScrollIndicator = NO;
    tableview.showsHorizontalScrollIndicator = NO;
    tableview.delegate=delegate;
    tableview.dataSource=delegate;
//    tableview.emptyDataSetSource = delegate;
//    tableview.emptyDataSetDelegate = delegate;
    tableview.backgroundColor=[UIColor D_ColorStr:@"#FFFFFF"];
    tableview.separatorStyle=UITableViewCellSeparatorStyleNone;//去掉cell横线
//    self.tableview.separatorColor=[UIColor D_ColorStr:@"#F8F8F8"];//设置线的颜色
    //直接用估算高度
    if (@available(iOS 15.0, *)) {
        tableview.sectionHeaderTopPadding=0;
    }
    tableview.estimatedRowHeight = PT(1);

    tableview.estimatedSectionFooterHeight = 0;
    tableview.estimatedSectionHeaderHeight = 0;
    tableview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    tableview.autoresizingMask =  UIViewAutoresizingFlexibleWidth;
    tableview.rowHeight = UITableViewAutomaticDimension;
    
    return tableview;
}
@end
