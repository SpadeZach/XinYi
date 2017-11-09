//
//  DataBaseLast.m
//  心仪家居
//
//  Created by dllo on 15/12/29.
//  Copyright © 2015年 蓝鸥科技. All rights reserved.
//

#import "DataBaseLast.h"
#import <sqlite3.h>
#import "HomePageModel.h"
@implementation DataBaseLast

+ (DataBaseLast *)defaultDataBaseLast
{
    static DataBaseLast *databaseLast;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        databaseLast = [[DataBaseLast alloc] init];
        
    });
    return databaseLast;
}
static sqlite3 *db = nil;

- (void)openDatabase
{
    NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    
    NSString *databasePath = [documentPath stringByAppendingPathComponent:@"collection.sqlite"];
//    NSLog(@"数据库地址%@", databasePath);
    
    //打开数据库
    int result = sqlite3_open(databasePath.UTF8String, &db);
    
    if (result == SQLITE_OK) {
        //创建sql语句
        
        NSString *sqlStr = @"create table if not exists List(ID text, name text, imgUrl text,  areaName text, spaceName text, styleName text, counts text)";
        
        
        int success = sqlite3_exec(db, sqlStr.UTF8String, NULL, NULL, nil);
        
        if (success == SQLITE_OK) {
            NSLog(@"创建成功");
        }else
        {
            NSLog(@"😢失败%d",success);
        }
    }else{
            NSLog(@"😭%d", result);
            
        }
    
}

#pragma mark 插入一条信息
- (void)insertOneBase:(HomePageModel *)homePageModel
{
    NSString *sqlString = [NSString stringWithFormat:@"insert into List(ID, name, imgUrl, areaName, spaceName, styleName, counts) values('%@','%@','%@', '%@', '%@', '%@', '%@')", homePageModel.ID, homePageModel.name, homePageModel.imgUrl, homePageModel.areaName, homePageModel.spaceName, homePageModel.styleName, homePageModel.counts];

    
    
    int result = sqlite3_exec(db, sqlString.UTF8String, NULL, NULL, nil);
    
    if (result == SQLITE_OK) {
        NSLog(@"插入成功");

    }else{
        NSLog(@"😡插入失败%d", result);

    }
}


#pragma mark 移除一条数据
- (BOOL)removeOneBase:(HomePageModel *)homePageModel
{
    
    NSString *sqlString = [NSString stringWithFormat:@"delete from List where id = '%@'", homePageModel.ID];
    
    int result = sqlite3_exec(db, sqlString.UTF8String, NULL, NULL, nil);
    
    if (result == SQLITE_OK) {
        NSLog(@"😄移除成功");
        return YES;

    }else{
        NSLog(@"👿移除失败%d", result);
        return NO;
    }
    
}



#pragma mark 查询一条数据
- (BOOL)searchOneBase:(HomePageModel *)homePageModel
{
    NSString *sqlString = [NSString stringWithFormat:@"select * from List where ID = '%@'", homePageModel.ID];
    sqlite3_stmt *stmt = nil;
    int result = sqlite3_prepare_v2(db, sqlString.UTF8String, -1, &stmt, nil);
    if (result == SQLITE_OK) {
        //判断查询是否有结果
        if (sqlite3_step(stmt) == SQLITE_ROW) {
            return YES;
        }else
        {
            return NO;
        }
    }else{
        NSLog(@"😫查询失败%d", result);
        return NO;
    }
    //返回值是否存在，如果返回YES说明存在，如果返回NO说明不存在或查询失败}
}
#pragma mark 查询所有数据
- (NSArray *)selectAllBaseInCollectionList
{
    NSString *sqlSrting = @"select * from List";
    sqlite3_stmt *stmt = nil;
    
    int result = sqlite3_prepare_v2(db, sqlSrting.UTF8String, -1, &stmt, nil);
    if (result == SQLITE_OK) {
        NSMutableArray *array = [NSMutableArray array];
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            
            const unsigned char *ID = sqlite3_column_text(stmt, 0);
            const unsigned char *name = sqlite3_column_text(stmt, 1);
            const unsigned char *imgUrl = sqlite3_column_text(stmt, 2);
            const unsigned char *areaName = sqlite3_column_text(stmt, 3);
            const unsigned char *spaceName = sqlite3_column_text(stmt, 4);
            const unsigned char *styleName = sqlite3_column_text(stmt, 5);
            const unsigned char *counts = sqlite3_column_text(stmt, 6);
            
            HomePageModel *homepageModel = [[HomePageModel alloc] init];
            homepageModel.ID = [NSString stringWithUTF8String:(const char*)ID];
            homepageModel.name = [NSString stringWithUTF8String:(const char*)name];
            homepageModel.imgUrl = [NSString stringWithUTF8String:(const char*)imgUrl];
            homepageModel.areaName = [NSString stringWithUTF8String:(const char*)areaName];
            homepageModel.spaceName = [NSString stringWithUTF8String:(const char*)spaceName];
            homepageModel.styleName = [NSString stringWithUTF8String:(const char*)styleName];
            homepageModel.counts = [NSString stringWithUTF8String:(const char*)counts];
            [array addObject:homepageModel];
            
        }
        return array;
        
    }else
    {
        NSLog(@"😱查询失败%d", result);
        return nil;
    }
}




@end
