//
//  UiKit_VC.m
//  CustomKit
//
//  Created by 戴义文 on 2025/6/1.
//

#import "File_VC.h"

@interface File_VC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSMutableArray *array;


@end

@implementation File_VC

-(void)rightClick{
    
    
    WeakSelf(self);
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"新建文件夹"
                                                              message:@""
                                                       preferredStyle:UIAlertControllerStyleAlert];

    // 添加用户名输入框
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"请输入文件夹名称";
        textField.keyboardType = UIKeyboardTypeDefault;
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    }];

    // 添加“登录”按钮
    UIAlertAction *loginAction = [UIAlertAction actionWithTitle:@"确认"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * _Nonnull action) {
        UITextField *usernameField = alert.textFields[0];
        
        if (usernameField.text.length>0) {
            NSMutableDictionary *dict = [NSMutableDictionary dictionary ];
            dict[@"type"] = @"aaaa";
            dict[@"test"] = @"bbbb";
            dict[@"cccc"] = @"dddd";
            if ([FileManager createDirectoryAtPath:[NSString stringWithFormat:@"%@/%@",weakSelf.filePath,usernameField.text] attributes:dict]) {
                [weakSelf.array addObject:usernameField.text];
                
                if (weakSelf.array.count >= 1) {
                    [weakSelf.tableView performBatchUpdates:^{
                        NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:weakSelf.array.count-1 inSection:0];
                        [weakSelf.tableView insertRowsAtIndexPaths:@[newIndexPath]
                                              withRowAnimation:UITableViewRowAnimationAutomatic];
                    } completion:^(BOOL finished) {
                        NSLog(@"刷新完成");
                    }];
                }
                
//                [weakSelf.tableView reloadData];
            }
        }
        
        
    }];
    [alert addAction:loginAction];

    // 添加“取消”按钮
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消"
                                                        style:UIAlertActionStyleCancel
                                                      handler:nil];
    [alert addAction:cancelAction];

    [self presentViewController:alert animated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIBarButtonItem *rightItem = [UIBarButtonItem new];
//    rightItem.title = @"File";
    rightItem.image = [UIImage systemImageNamed:@"folder.badge.plus"];
    rightItem.target = self;
    rightItem.action = @selector(rightClick);
    self.navigationItem.rightBarButtonItem = rightItem;
    
    
    
    self.array = [NSMutableArray arrayWithArray:[FileManager listFilesInDirectoryAtPath:self.filePath deep:NO]];
    
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
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.array.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    // 配置单元格
    
    NSDictionary *dict = [FileManager attributesOfItemAtPath:[NSString stringWithFormat:@"%@/%@",[FileManager libraryDir],self.array[indexPath.row]]];
    
    cell.textLabel.text = self.array[indexPath.row];
    
    cell.textLabel.font = [UIFont boldSystemFontOfSize:15];
    
    cell.imageView.image = [UIImage systemImageNamed:@"folder"];
    
//    cell.textLabel.textColor = RGBA(115, 115, 195, 1);
    
    return cell;
    
}

// 启用编辑
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return YES;
    
}

// 自定义滑动操作（iOS 11+）
- (UISwipeActionsConfiguration *)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WEAKSELF;
    UIContextualAction *deleteAction = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleDestructive
                                                                             title:@"删除"
                                                                           handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
        
        if ([FileManager removeItemAtPath:[NSString stringWithFormat:@"%@/%@",weakSelf.filePath,weakSelf.array[indexPath.row]]]) {
            [weakSelf.array removeObjectAtIndex:indexPath.row];
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            completionHandler(YES);
        }
        
    }];
    
    deleteAction.backgroundColor = [UIColor redColor];
    deleteAction.image = [UIImage systemImageNamed:@"trash"];
    
    UIContextualAction *infoAction = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleNormal
                                                                             title:@"信息"
                                                                           handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {

        completionHandler(YES);
    }];
    
    infoAction.backgroundColor = [UIColor systemBlueColor];
    infoAction.image = [UIImage systemImageNamed:@"info.circle"];
    
    UISwipeActionsConfiguration *config = [UISwipeActionsConfiguration configurationWithActions:@[deleteAction , infoAction]];
    return config;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    NSString *path = self.array[indexPath.row];
    
    File_VC *vc = [File_VC new];
    
    vc.title = path;
    
    vc.filePath = [NSString stringWithFormat:@"%@/%@",self.filePath,path];
    
    [self.navigationController pushViewController:vc animated:YES];
}



@end
