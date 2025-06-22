//
//  UserViewController.m
//  CustomKit
//
//  Created by 戴义文 on 2025/6/22.
//

#import "UserViewController.h"

@interface UserViewController ()

@end

@implementation UserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.infoLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 200, 222, 20)];
    [self.view addSubview:self.infoLabel];
    
    self.greetingLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 250, 220, 20)];
    [self.view addSubview:self.greetingLabel];
    
    // 创建Model
    User *user = [[User alloc] initWithName:@"张狗子" age:25 email:@"zhangsan@example.com"];
    
    // 创建ViewModel
    self.viewModel = [[UserViewModel alloc] initWithUser:user];
    
    // 绑定数据到View
    [self bindViewModel];
    
    //添加观察者
    [self setupObservers];
}

- (void)bindViewModel {
    self.infoLabel.text = self.viewModel.userInfoText;
    self.greetingLabel.text = self.viewModel.greetingText;
}

// 在ViewController中观察属性变化
- (void)setupObservers {
    [self.viewModel addObserver:self forKeyPath:@"userInfoText" options:NSKeyValueObservingOptionNew context:nil];
    [self.viewModel addObserver:self forKeyPath:@"greetingText" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"userInfoText"]) {
        DLog(@"NSKeyValueChangeNewKey==========%@",change[NSKeyValueChangeNewKey]);
        self.infoLabel.text = change[NSKeyValueChangeNewKey];
    } else if ([keyPath isEqualToString:@"greetingText"]) {
        self.greetingLabel.text = change[NSKeyValueChangeNewKey];
    }
}

- (void)dealloc {
    [self.viewModel removeObserver:self forKeyPath:@"userInfoText"];
    [self.viewModel removeObserver:self forKeyPath:@"greetingText"];
}


@end
