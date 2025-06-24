//
//  Sqlite_VC.m
//  CustomKit
//
//  Created by 戴义文 on 2025/6/24.
//

#import "Sqlite_VC.h"
#import <sqlite3.h>
#import "SQLiteManager.h"

@interface Sqlite_VC ()
@property (nonatomic ,assign) sqlite3*database;

@end

@implementation Sqlite_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
//    [self openDatabase];
//    [self createTable];
    
    // 初始化数据库
    SQLiteManager *manager = [SQLiteManager sharedInstance];
    if ([manager openDatabaseWithName:@"myDatabase.sqlite"]) {
        // 创建表
        NSString *createTableSQL = @"CREATE TABLE IF NOT EXISTS Users (ID INTEGER PRIMARY KEY AUTOINCREMENT, Name TEXT, Age INTEGER)";
        [manager executeSQL:createTableSQL];
        
        // 插入数据
        NSString *insertSQL = [NSString stringWithFormat:@"INSERT INTO Users (Name, Age) VALUES ('%@', %d)", @"张三", 25];
        [manager executeSQL:insertSQL];
        
        // 查询数据
        NSArray *results = [manager querySQL:@"SELECT * FROM Users"];
        NSLog(@"查询结果: %@", results);
        
//        // 更新数据
//        NSString *updateSQL = [NSString stringWithFormat:@"UPDATE Users SET Age = %d WHERE Name = '%@'", 26, @"张三"];
//        [manager executeSQL:updateSQL];
//        
//        // 删除数据
//        NSString *deleteSQL = @"DELETE FROM Users WHERE Name = '张三'";
//        [manager executeSQL:deleteSQL];
    }
    
}

- (void)openDatabase {
    sqlite3 *database;
    NSString *dbPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    dbPath = [dbPath stringByAppendingPathComponent:@"myDatabase.sqlite"];
    
    if (sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK) {
        NSLog(@"数据库打开/创建成功");
        self.database = database; // 保存数据库引用
    } else {
        NSLog(@"数据库打开失败");
    }
}

- (void)createTable {
    char *errorMsg = NULL;
    const char *createSQL = "CREATE TABLE IF NOT EXISTS PEOPLE (ID INTEGER PRIMARY KEY AUTOINCREMENT, NAME TEXT, AGE INTEGER)";
    
    if (sqlite3_exec(self.database, createSQL, NULL, NULL, &errorMsg) == SQLITE_OK) {
        NSLog(@"表创建成功");
    } else {
        NSLog(@"创建表失败: %s", errorMsg);
        sqlite3_free(errorMsg);
    }
}

- (void)insertDataWithName:(NSString *)name age:(NSInteger)age {
    const char *insertSQL = "INSERT INTO PEOPLE (NAME, AGE) VALUES (?, ?)";
    sqlite3_stmt *statement;
    
    if (sqlite3_prepare_v2(self.database, insertSQL, -1, &statement, NULL) == SQLITE_OK) {
        sqlite3_bind_text(statement, 1, [name UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_int(statement, 2, (int)age);
        
        if (sqlite3_step(statement) == SQLITE_DONE) {
            NSLog(@"数据插入成功");
        } else {
            NSLog(@"数据插入失败");
        }
        
        sqlite3_finalize(statement);
    }
}

- (void)queryData {
    const char *querySQL = "SELECT ID, NAME, AGE FROM PEOPLE";
    sqlite3_stmt *statement;
    
    if (sqlite3_prepare_v2(self.database, querySQL, -1, &statement, NULL) == SQLITE_OK) {
        while (sqlite3_step(statement) == SQLITE_ROW) {
            int personID = sqlite3_column_int(statement, 0);
            char *nameChars = (char *)sqlite3_column_text(statement, 1);
            int age = sqlite3_column_int(statement, 2);
            
            NSString *name = [[NSString alloc] initWithUTF8String:nameChars];
            NSLog(@"ID: %d, Name: %@, Age: %d", personID, name, age);
        }
        
        sqlite3_finalize(statement);
    }
}

- (void)updateDataWithID:(NSInteger)ID newName:(NSString *)name newAge:(NSInteger)age {
    const char *updateSQL = "UPDATE PEOPLE SET NAME = ?, AGE = ? WHERE ID = ?";
    sqlite3_stmt *statement;
    
    if (sqlite3_prepare_v2(self.database, updateSQL, -1, &statement, NULL) == SQLITE_OK) {
        sqlite3_bind_text(statement, 1, [name UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_int(statement, 2, (int)age);
        sqlite3_bind_int(statement, 3, (int)ID);
        
        if (sqlite3_step(statement) == SQLITE_DONE) {
            NSLog(@"数据更新成功");
        } else {
            NSLog(@"数据更新失败");
        }
        
        sqlite3_finalize(statement);
    }
}

- (void)deleteDataWithID:(NSInteger)ID {
    const char *deleteSQL = "DELETE FROM PEOPLE WHERE ID = ?";
    sqlite3_stmt *statement;
    
    if (sqlite3_prepare_v2(self.database, deleteSQL, -1, &statement, NULL) == SQLITE_OK) {
        sqlite3_bind_int(statement, 1, (int)ID);
        
        if (sqlite3_step(statement) == SQLITE_DONE) {
            NSLog(@"数据删除成功");
        } else {
            NSLog(@"数据删除失败");
        }
        
        sqlite3_finalize(statement);
    }
}

- (void)closeDatabase {
    if (sqlite3_close(self.database) == SQLITE_OK) {
        NSLog(@"数据库关闭成功");
        self.database = NULL;
    } else {
        NSLog(@"数据库关闭失败");
    }
}

@end
