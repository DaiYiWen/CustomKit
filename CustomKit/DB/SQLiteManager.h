//
//  SQLiteManager.h
//  CustomKit
//
//  Created by 戴义文 on 2025/6/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SQLiteManager : NSObject

+ (instancetype)sharedInstance;

- (BOOL)openDatabaseWithName:(NSString *)dbName;

- (BOOL)executeSQL:(NSString *)sql;

- (NSArray *)querySQL:(NSString *)sql;

@end

NS_ASSUME_NONNULL_END
