//
//  UserViewModel.m
//  CustomKit
//
//  Created by 戴义文 on 2025/6/22.
//

#import "UserViewModel.h"
#import "User.h"

@interface UserViewModel ()

@property (nonatomic, strong) User *user;

@end


@implementation UserViewModel

- (instancetype)initWithUser:(User *)user {
    if (self = [super init]) {
        _user = user;
        
        
        self.userInfoText = [NSString stringWithFormat:@"%@, %ld岁", self.user.name, (long)self.user.age];
        self.greetingText = [NSString stringWithFormat:@"你好，%@！", self.user.name];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            self.userInfoText = @"改变了";
            [self fetchUserWithCompletion:^(BOOL success, NSError * _Nonnull error) {
                
            }];
        });
    }
    return self;
}

- (void)fetchUserWithCompletion:(FetchUserCompletion)completion {
    // 模拟网络请求
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 假设从网络获取了数据
        User *fetchedUser = [[User alloc] initWithName:@"李四" age:30 email:@"lisi@example.com"];
        self.user = fetchedUser;
        
        // 更新ViewModel属性
        self.userInfoText = [NSString stringWithFormat:@"%@, %ld岁", self.user.name, (long)self.user.age];
        self.greetingText = [NSString stringWithFormat:@"你好，%@！", self.user.name];
        
        if (completion) {
            NSError *error = [NSError new];
            completion(YES, error);
        }
    });
}

//- (NSString *)userInfoText {
//    return [NSString stringWithFormat:@"%@, %ld岁", self.user.name, (long)self.user.age];
//}

//- (NSString *)greetingText {
//    return [NSString stringWithFormat:@"你好，%@！", self.user.name];
//}

@end
