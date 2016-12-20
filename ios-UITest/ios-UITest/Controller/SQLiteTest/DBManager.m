//
//  DBManager.m
//  ios-UITest
//
//  Created by yangl on 2016/11/29.
//  Copyright © 2016年 yl. All rights reserved.
//

#import "DBManager.h"

#ifndef kDatabaseName
#define kDatabaseName @"myDatabase.db"
#endif


@interface DBManager ()

@end

@implementation DBManager

- (instancetype)init {
	DBManager *manager = [super init];
	if (manager) {
		[manager openDb:kDatabaseName];
	}
	return manager;
}

- (void)openDb:(NSString *)dbname {
	NSString *directory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
	NSLog(@"%@", directory);
	NSString *filePath = [directory stringByAppendingPathComponent:dbname];
	if (SQLITE_OK==sqlite3_open(filePath.UTF8String, &_database)) {
		NSLog(@"open database successfully");
	} else {
		NSLog(@"false open");
	}
}

- (void)executeNonQuery:(NSString *)sql{
	char *error;
	//单步执行sql语句，用于插入、修改、删除
	if (SQLITE_OK!=sqlite3_exec(_database, sql.UTF8String, NULL, NULL,&error)) {
		NSLog(@"执行SQL语句过程中发生错误！错误信息：%s",error);
	}
}

-(NSArray *)executeQuery:(NSString *)sql{
	NSMutableArray *rows=[NSMutableArray array];//数据行
	
	//评估语法正确性
	sqlite3_stmt *stmt;
	//检查语法正确性
	if (SQLITE_OK==sqlite3_prepare_v2(_database, sql.UTF8String, -1, &stmt, NULL)) {
		//单步执行sql语句
		while (SQLITE_ROW==sqlite3_step(stmt)) {
			int columnCount= sqlite3_column_count(stmt);
			NSMutableDictionary *dic=[NSMutableDictionary dictionary];
			for (int i=0; i<columnCount; i++) {
				const char *name= sqlite3_column_name(stmt, i);//取得列名
				const unsigned char *value= sqlite3_column_text(stmt, i);//取得某列的值
				dic[[NSString stringWithUTF8String:name]]=[NSString stringWithUTF8String:(const char *)value];
			}
			[rows addObject:dic];
		}
	}
	
	//释放句柄
	sqlite3_finalize(stmt);
	
	return rows;
}

@end
