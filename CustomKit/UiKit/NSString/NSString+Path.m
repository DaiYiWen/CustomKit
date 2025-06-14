//
//  NSString+Path.m
//  GuiHuaRenSheng
//
//  Created by apple on 2019/5/22.
//  Copyright © 2019 wancaishangwu. All rights reserved.
//

#import "NSString+Path.h"

@implementation NSString (Path)

// 获取Documents目录
+ (NSString *)documentPath
{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

// 获取Cache目录
+ (NSString *)cachePath
{
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
}

// 获取Tmp目录
+ (NSString *)tempPath
{
    return NSTemporaryDirectory();
}

// 获取拼接后的Documents目录
- (NSString *)appendDocumentsPath
{
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *fileName = [self lastPathComponent];
    NSString *filePath = [documentsPath stringByAppendingPathComponent:fileName];
    
    return filePath;
}

// 获取拼接后的Cache目录
- (NSString *)appendCachePath
{
    if([self containsString:@"/var/"]){
        return self;
    }
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
//    NSString *fileName = [self lastPathComponent];
    NSString *filePath = [cachePath stringByAppendingPathComponent:self];
    
    return filePath;
}
- (NSString *)removeCachePath
{
    if(![self containsString:@"/var/"]){
        return self;
    }
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filePath = [self stringByReplacingOccurrencesOfString:cachePath withString:@""];
    return filePath;
}

// 获取拼接后的Tmp目录
- (NSString *)appendTmpPath
{
    NSString *tmpPath = NSTemporaryDirectory();
    NSString *fileName = [self lastPathComponent];
    NSString *filePath = [tmpPath stringByAppendingPathComponent:fileName];
    
    return filePath;
}
- (BOOL)isFileExist{
    if(self == nil){
        return false;
    }
    BOOL isDir;
    NSString *path = self;
    if (![path containsString:@"Application"] && ![path containsString:@"/var/"]) {
        path = [self appendCachePath];
    }
    return [[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&isDir];
}
- (BOOL)deleteFile{
    return [[NSFileManager defaultManager] removeItemAtPath:self error:nil];
}
- (NSData *)readFile{
    return [NSData dataWithContentsOfFile:self];
}
- (BOOL)reNameFileName:(NSString *)newName{
    //通过移动该文件对文件重命名
    NSString *documentsPath = self;
    NSFileManager *fileManager = [NSFileManager defaultManager];
//    NSString *filePath = [documentsPath stringByAppendingPathComponent:@"iOS.txt"];
    NSString *moveToPath = [documentsPath stringByAppendingPathComponent:newName];
    BOOL isSuccess = [fileManager moveItemAtPath:documentsPath toPath:moveToPath error:nil];
//    if (isSuccess) {
//        NSLog(@"rename success");
//    }else{
//        return false;
//    }
    return isSuccess;
}
- (BOOL)isDirectory{
    BOOL isDirectory = NO;
    [[NSFileManager defaultManager] fileExistsAtPath:self isDirectory:&isDirectory];
    return isDirectory;
  }
//文件的大小(字节)
- (unsigned long long)sizeAtPath{
    NSFileManager *manager = [NSFileManager defaultManager];
    NSString *filePath = self.mutableCopy;
    if (![filePath containsString:@"Application"]) {
        filePath = [self appendCachePath];
    }
    if ([filePath containsString:@"file:///"] && (filePath = [filePath stringByReplacingOccurrencesOfString:@"file:///" withString:@""]) && [manager fileExistsAtPath:filePath]){
        if([manager fileExistsAtPath:filePath]){
            return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
        }
    }
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}



@end
