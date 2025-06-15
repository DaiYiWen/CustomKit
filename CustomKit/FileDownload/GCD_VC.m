//
//  GCD_VC.m
//  CustomKit
//
//  Created by 戴义文 on 2025/6/15.
//

#import "GCD_VC.h"

@interface GCD_VC ()

@end

@implementation GCD_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    /**
     GCD Use
     */
    
//    //snyc
//    dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
//        DLog(@"sync===============0");
//        DLog(@"sync==========%@",[NSThread currentThread]);
//    });
//    dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
//        DLog(@"sync===============1");
//        DLog(@"sync==========%@",[NSThread currentThread]);
//    });
//    dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
//        DLog(@"sync===============2");
//        DLog(@"sync==========%@",[NSThread currentThread]);
//    });
//    
//    
//    //asnyc
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
//        DLog(@"async===============0");
//        DLog(@"async==========%@",[NSThread currentThread]);
//    });
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
//        DLog(@"async===============1");
//        DLog(@"async==========%@",[NSThread currentThread]);
//    });
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
//        DLog(@"async===============2");
//        DLog(@"async==========%@",[NSThread currentThread]);
//    });
    
    
    //异步执行+串行队列 只会开启一条线程
//    dispatch_queue_t queue = dispatch_queue_create("queue_1", DISPATCH_QUEUE_SERIAL);
//    
//    dispatch_async(queue, ^{
//        DLog(@"async===============0");
//        DLog(@"async==========%@",[NSThread currentThread]);
//    });
//    
//    dispatch_async(queue, ^{
//        DLog(@"async===============1");
//        DLog(@"async==========%@",[NSThread currentThread]);
//    });
//    
//    dispatch_async(queue, ^{
//        DLog(@"async===============2");
//        DLog(@"async==========%@",[NSThread currentThread]);
//    });
    
    
    
    //异步执行+并发队列 会开启多条线程
//    dispatch_queue_t queue1 = dispatch_queue_create("queue_1", DISPATCH_QUEUE_CONCURRENT);
//    
//    dispatch_async(queue1, ^{
//        DLog(@"async=====1==========0");
//        DLog(@"async==========%@",[NSThread currentThread]);
//    });
//    
//    dispatch_async(queue1, ^{
//        DLog(@"async=====1==========1");
//        DLog(@"async==========%@",[NSThread currentThread]);
//    });
//    
//    dispatch_async(queue1, ^{
//        DLog(@"async=====1==========2");
//        DLog(@"async==========%@",[NSThread currentThread]);
//    });
//    
//    
//    //栅栏函数 把上下两组任务分别执行
//    dispatch_barrier_sync(queue1, ^{
//        DLog(@"async=====1==========栅栏");
//        DLog(@"async==========%@",[NSThread currentThread]);
//    });
//    
//    dispatch_async(queue1, ^{
//        DLog(@"async=====1==========3");
//        DLog(@"async==========%@",[NSThread currentThread]);
//    });
//    
//    dispatch_async(queue1, ^{
//        DLog(@"async=====1==========4");
//        DLog(@"async==========%@",[NSThread currentThread]);
//    });
//    
//    dispatch_async(queue1, ^{
//        DLog(@"async=====1==========5");
//        DLog(@"async==========%@",[NSThread currentThread]);
//    });
    
    
    //队列组的使用
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue2 = dispatch_queue_create("queue_2", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_group_async(group, queue2, ^{
        DLog(@"group===============0");
        DLog(@"group==========%@",[NSThread currentThread]);
    });
    
    dispatch_group_async(group, queue2, ^{
        DLog(@"group===============1");
        DLog(@"group==========%@",[NSThread currentThread]);
    });

    
    dispatch_group_async(group, queue2, ^{
        DLog(@"group===============2");
        DLog(@"group==========%@",[NSThread currentThread]);
    });

    dispatch_group_async(group, queue2, ^{
        DLog(@"group===============3");
        DLog(@"group==========%@",[NSThread currentThread]);
    });
    
    dispatch_group_notify(group, queue2, ^{
        DLog(@"group===============都执行完毕了");
        DLog(@"group==========%@",[NSThread currentThread]);
    });
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
