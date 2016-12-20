//
//  DBManager.h
//  ios-UITest
//
//  Created by yangl on 2016/11/29.
//  Copyright © 2016年 yl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface DBManager : NSObject

@property(nonatomic) sqlite3 *database;

-(void)openDb:(NSString *)dbname;
-(void)executeNonQuery:(NSString *)sql;
-(NSArray *)executeQuery:(NSString *)sql;

@end
