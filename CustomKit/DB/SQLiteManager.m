//
//  SQLiteManager.m
//  CustomKit
//
//  Created by 戴义文 on 2025/6/24.
//

#import "SQLiteManager.h"
#import <sqlite3.h>

@interface SQLiteManager ()

@property (nonatomic, assign) sqlite3 *database;

@end

@implementation SQLiteManager

+ (instancetype)sharedInstance {
    static SQLiteManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[SQLiteManager alloc] init];
    });
    return instance;
}

- (BOOL)openDatabaseWithName:(NSString *)dbName {
    NSString *docsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *dbPath = [docsPath stringByAppendingPathComponent:dbName];
    
    if (sqlite3_open([dbPath UTF8String], &_database) == SQLITE_OK) {
        return YES;
    }
    return NO;
}

- (BOOL)executeSQL:(NSString *)sql {
    char *errorMsg = NULL;
    if (sqlite3_exec(self.database, [sql UTF8String], NULL, NULL, &errorMsg) == SQLITE_OK) {
        return YES;
    } else {
        NSLog(@"执行SQL出错: %s", errorMsg);
        sqlite3_free(errorMsg);
        return NO;
    }
}

- (NSArray *)querySQL:(NSString *)sql {
    sqlite3_stmt *stmt;
    NSMutableArray *resultArray = [NSMutableArray array];
    
    if (sqlite3_prepare_v2(self.database, [sql UTF8String], -1, &stmt, NULL) == SQLITE_OK) {
        int columnCount = sqlite3_column_count(stmt);
        
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
            
            for (int i = 0; i < columnCount; i++) {
                NSString *columnName = [NSString stringWithUTF8String:sqlite3_column_name(stmt, i)];
                int columnType = sqlite3_column_type(stmt, i);
                
                id value;
                switch (columnType) {
                    case SQLITE_INTEGER:
                        value = @(sqlite3_column_int(stmt, i));
                        break;
                    case SQLITE_FLOAT:
                        value = @(sqlite3_column_double(stmt, i));
                        break;
                    case SQLITE_TEXT:
                        value = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, i)];
                        break;
                    case SQLITE_BLOB:
                        value = [NSData dataWithBytes:sqlite3_column_blob(stmt, i) length:sqlite3_column_bytes(stmt, i)];
                        break;
                    case SQLITE_NULL:
                        value = [NSNull null];
                        break;
                    default:
                        break;
                }
                
                if (value) {
                    dict[columnName] = value;
                }
            }
            
            [resultArray addObject:dict];
        }
        
        sqlite3_finalize(stmt);
    }
    
    return resultArray;
}

- (void)dealloc {
    if (_database) {
        sqlite3_close(_database);
    }
}

@end
