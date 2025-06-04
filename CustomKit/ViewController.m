//
//  ViewController.m
//  CustomKit
//
//  Created by 戴义文 on 2025/6/1.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
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
    return 10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    return @"ewwer";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    // 配置单元格
//    cell.textLabel.text = self.dataArray[indexPath.row];
//    cell.detailTextLabel.text = [NSString stringWithFormat:@"第%ld行", (long)indexPath.row];
//    cell.imageView.image = [UIImage imageNamed:@"icon"];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}



@end
