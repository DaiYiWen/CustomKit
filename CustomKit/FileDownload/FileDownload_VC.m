//
//  FileDownload_VC.m
//  CustomKit
//
//  Created by 戴义文 on 2025/6/10.
//

#import "FileDownload_VC.h"
#import "File_VC.h"

@interface FileDownload_VC ()

@property (nonatomic,strong) UIProgressView *progressView;

@property (nonatomic,assign) CGFloat progress;

@property (strong, nonatomic) dispatch_source_t progressTimer;
@end

@implementation FileDownload_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *rightItem = [UIBarButtonItem new];
//    rightItem.title = @"File";
    rightItem.image = [UIImage systemImageNamed:@"folder"];
    
    weakSelf(self);
    // 创建多个 UIAction
    UIAction *documentsAction = [UIAction actionWithTitle:@"documents"
                                            image:[UIImage systemImageNamed:@"folder"]
                                         identifier:nil
                                            handler:^(__kindof UIAction * _Nonnull action) {
        
        File_VC *vc = [File_VC new];
        vc.title = @"documents";
        vc.filePath = [FileManager documentsDir];
        [weakSelf.navigationController pushViewController:vc animated:YES];

    }];

    UIAction *libraryAction = [UIAction actionWithTitle:@"Library"
                                            image:[UIImage systemImageNamed:@"folder"]
                                         identifier:nil
                                            handler:^(__kindof UIAction * _Nonnull action) {
        File_VC *vc = [File_VC new];
        vc.title = @"Library";
        vc.filePath = [FileManager libraryDir];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }];
    
    UIAction *tmpAction = [UIAction actionWithTitle:@"tmp"
                                            image:[UIImage systemImageNamed:@"folder"]
                                         identifier:nil
                                            handler:^(__kindof UIAction * _Nonnull action) {
        File_VC *vc = [File_VC new];
        vc.title = @"tmp";
        vc.filePath = [FileManager tmpDir];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }];

    // 创建 UIMenu
    UIMenu *menu = [UIMenu menuWithTitle:@""
                               children:@[documentsAction, libraryAction, tmpAction]];
    menu.preferredElementSize = UIMenuElementSizeLarge;
    rightItem.menu = menu;
    
    
    self.navigationItem.rightBarButtonItem = rightItem;
    
    
    
    
    
    
    self.progress = 0.00;
    
    self.progressView = [[UIProgressView alloc]initWithFrame:CGRectMake(25, 150, Screen_Width-50, 0)];
//    self.progressView.progressTintColor = [UIColor systemRedColor];
//    self.progressView.trackTintColor = [UIColor systemBlueColor];
//    self.progressView.trackImage = GetImage(@"icon");
//    self.progressView.progress = 0.5;
    [self.view addSubview:self.progressView];
    
    
    
    // 创建 GCD 定时器
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);

    // 设置定时器（每秒执行一次）
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 0.01 * NSEC_PER_SEC, 0.1 * NSEC_PER_SEC);

    // 设置回调
//    __weak typeof(self) weakSelf = self;
    dispatch_source_set_event_handler(timer, ^{
        [weakSelf timerFired];
    });

    // 启动定时器
    dispatch_resume(timer);
    
    self.progressTimer = timer;
    
    NSFileManager*a;
    NSCache*c;
    
    DLog(@"========%@",NSHomeDirectory());
    DLog(@"========%@",[FileManager documentsDir]);
    
    NSArray *array = [FileManager listFilesInCachesDirectoryByDeep:NO];
    NSArray *array1 = [FileManager listFilesInTmpDirectoryByDeep:YES];
}

// 回调方法
- (void)timerFired {
//    DLog(@"GCD 定时器触发");
    self.progress += 0.001;
    // 注意：如果在非主线程执行，需要回到主线程更新UI
    dispatch_async(dispatch_get_main_queue(), ^{
        // 更新UI
        [self.progressView setProgress:self.progress animated:YES];
    });
    
    
    if (self.progress > 1) {
        if (self.progressTimer) {
            DLog(@"GCD 定时器关闭");
            dispatch_source_cancel(self.progressTimer);
            self.progressTimer = nil;
        }
    }
}


@end
