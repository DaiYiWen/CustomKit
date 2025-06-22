//
//  UserViewController.h
//  CustomKit
//
//  Created by 戴义文 on 2025/6/22.
//

#import "BaseViewController.h"

#import "UserViewModel.h"
#import "User.h"

NS_ASSUME_NONNULL_BEGIN

@interface UserViewController : BaseViewController

@property (strong, nonatomic) UILabel *infoLabel;
@property (strong, nonatomic) UILabel *greetingLabel;

@property (nonatomic, strong) UserViewModel *viewModel;

@end

NS_ASSUME_NONNULL_END
