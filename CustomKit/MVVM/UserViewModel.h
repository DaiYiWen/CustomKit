//
//  UserViewModel.h
//  CustomKit
//
//  Created by 戴义文 on 2025/6/22.
//

#import <Foundation/Foundation.h>
#import "User.h"

NS_ASSUME_NONNULL_BEGIN

@interface UserViewModel : NSObject

- (instancetype)initWithUser:(User *)user;

@property (nonatomic, copy) NSString *userInfoText;
@property (nonatomic, copy) NSString *greetingText;


typedef void (^FetchUserCompletion)(BOOL success, NSError *error);

- (void)fetchUserWithCompletion:(FetchUserCompletion)completion;

@end

NS_ASSUME_NONNULL_END
