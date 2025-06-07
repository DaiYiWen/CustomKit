//
//  HomePag_VC.m
//  CustomKit
//
//  Created by 戴义文 on 2025/6/1.
//

#import "HomePag_VC.h"

@interface HomePag_VC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSMutableArray *SectionArray;

@property (nonatomic,strong) NSMutableArray *ClassNameArray;

@end

@implementation HomePag_VC

- (void)GetData{
    
    self.SectionArray = [NSMutableArray arrayWithArray:@[@"UIKit",@"Audio and Video",@"Animation"]];
    
    self.ClassNameArray = [NSMutableArray arrayWithArray:@[@"UiKit_VC",@"",@""]];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"For study purposes";
    
//    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//    dict[@"target"] = [@""]
    
    
//    // 1. 创建FLAnimatedImageView
//    FLAnimatedImageView *imageView = [[FLAnimatedImageView alloc] init];
//    imageView.frame = CGRectMake(0, 0, 200, 200);
//    [self.view addSubview:imageView];
//
//    // 2. 加载GIF
//    NSString *gifPath = [[NSBundle mainBundle] pathForResource:@"猫gif" ofType:@"gif"];
//    NSData *gifData = [NSData dataWithContentsOfFile:gifPath];
//
//    FLAnimatedImage *animatedImage = [FLAnimatedImage animatedImageWithGIFData:gifData];
//    imageView.animatedImage = animatedImage;
    
    // 获取Plist文件路径
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"Target Name" ofType:@"plist"];

    // 读取Plist文件内容
//    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
//    NSArray *array = [NSArray arrayWithContentsOfFile:path]; // 如果Plist是数组结构

//    // 使用数据
//    if (dict) {
//        NSString *value = dict[@"key"];
//        NSLog(@"Value: %@", value);
//    }
    
    
    
    [MySingleton sharedInstance].totalHeight = [UIApplication sharedApplication].windows.firstObject.windowScene.statusBarManager.statusBarFrame.size.height+self.navigationController.navigationBar.frame.size.height;

    

    [self GetData];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleInsetGrouped];
    
    self.tableView.delegate = self;
    
    self.tableView.dataSource = self;
    
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.view);
    }];

}

#pragma mark - UITableView Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.SectionArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    // 配置单元格
    cell.textLabel.text = self.SectionArray[indexPath.section];
    
    cell.textLabel.font = [UIFont boldSystemFontOfSize:15];
    
    cell.textLabel.textColor = RGBA(115, 115, 195, 1);
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
    Class class = NSClassFromString(self.ClassNameArray[indexPath.section]);

    if (class && [class isSubclassOfClass:[UIViewController class]]) {
        
        UIViewController *vc = [[class alloc] init];
        
        vc.navigationItem.title = self.SectionArray[indexPath.section];
        // 使用vc
        [self.navigationController pushViewController:vc animated:YES];
        // 或者 [self presentViewController:vc animated:YES completion:nil];
    } else {
//        NSLog(@"未找到名为 %@ 的视图控制器类", className);
    }
}



@end
