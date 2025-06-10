//
//  CAImageLayer_VC.m
//  CustomKit
//
//  Created by 戴义文 on 2025/6/9.
//

#import "CAImageLayer_VC.h"
#import "CAImageLayer_Cell.h"
@interface CAImageLayer_VC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;

@end

@implementation CAImageLayer_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleInsetGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(self.view);
    }];
    [self.tableView registerClass:[CAImageLayer_Cell class] forCellReuseIdentifier:@"CAImageLayer_Cell"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 20;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CAImageLayer_Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"CAImageLayer_Cell"];
    cell.cellRow = indexPath.row;
    return cell;
    
}


@end
