//
//  NSString+Path.h
//  GuiHuaRenSheng
//
//  Created by apple on 2019/5/22.
//  Copyright © 2019 wancaishangwu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Path)

/**获取Documents目录*/
+ (NSString *)documentPath;

/**获取Cache目录*/
+ (NSString *)cachePath;

/**获取Tmp目录*/
+ (NSString *)tempPath;

/**获取拼接后的Documents目录*/
- (NSString *)appendDocumentsPath;

/**获取拼接后的Cache目录*/
- (NSString *)appendCachePath;
/**获取Cache目录相对路径*/
- (NSString *)removeCachePath;

/**获取拼接后的Tmp目录*/
- (NSString *)appendTmpPath;

//文件是否存在
- (BOOL)isFileExist;

- (BOOL)deleteFile;

- (NSData *)readFile;

- (BOOL)reNameFileName:(NSString *)newName;

- (BOOL)isDirectory;
//获取文件大小
- (unsigned long long)sizeAtPath;

@end

NS_ASSUME_NONNULL_END
