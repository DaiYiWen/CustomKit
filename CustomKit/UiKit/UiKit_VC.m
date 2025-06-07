//
//  UiKit_VC.m
//  CustomKit
//
//  Created by 戴义文 on 2025/6/1.
//

#import "UiKit_VC.h"

@interface UiKit_VC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSArray *SectionArray;
@property (nonatomic,strong) NSArray *ClassArray;

@end

@implementation UiKit_VC

- (void)GetData{
    
    self.SectionArray = @[@"UIColor",@"UIView",@"UILabel",@"UIButton",@"UIImageView",@"UITableView",@"UICollectionView"];
    
    self.ClassArray = @[@"UIColor_VC",@"",@"",@"",@"",@"",@""];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
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
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    Class class = NSClassFromString(self.ClassArray[indexPath.section]);

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
