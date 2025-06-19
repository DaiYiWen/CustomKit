//
//  Notification_VC.m
//  CustomKit
//
//  Created by qa-test on 2025/6/19.
//

#import "Notification_VC.h"
#import <UserNotifications/UserNotifications.h>

@interface Notification_VC ()

@end

@implementation Notification_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"Send" style:UIBarButtonItemStylePlain target:self action:@selector(send)];
    
    self.navigationItem.rightBarButtonItem = item;
    
}


-(void)send{
    
    NSDictionary *fakeRemotePayload = @{
        @"aps": @{
            @"alert": @{
                @"title": @"中华人民共和国",
                @"body": @"毛泽东：中国人民站起来了！"
            },
            @"mutable-content": @1,
            @"category": @"myNotificationCategory"
        },
        @"local-notification": @YES, // 标记为本地通知
        @"image-url": @"https://example.com/image.jpg", // 自定义数据
        
        @"sender_name": @"中华人民共和国",
        @"message_content": @"毛泽东：中国人民站起来了！",
        @"message_time": @"刚刚"
    };
    
    // 2. 转换为UNNotificationContent
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
    [content setValue:fakeRemotePayload[@"aps"][@"alert"][@"title"] forKey:@"title"];
    [content setValue:fakeRemotePayload[@"aps"][@"alert"][@"body"] forKey:@"body"];
    content.userInfo = fakeRemotePayload;
    content.categoryIdentifier = fakeRemotePayload[@"aps"][@"category"];
  
  // 4. 设置触发条件（5秒后触发）
  UNTimeIntervalNotificationTrigger *trigger =
      [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:5 repeats:NO];
  
  // 5. 创建通知请求
  NSString *identifier = [NSString stringWithFormat:@"custom_notification_%f", [[NSDate date] timeIntervalSince1970]];
  UNNotificationRequest *request =
      [UNNotificationRequest requestWithIdentifier:identifier
                                          content:content
                                          trigger:trigger];
  
  // 6. 添加到通知中心
  UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
  [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
      if (error) {
          NSLog(@"自定义通知添加失败: %@", error);
      } else {
          NSLog(@"自定义通知已安排");
      }
  }];
    
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
