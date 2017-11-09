//
//  DataBaseLast.h
//  心仪家居
//
//  Created by dllo on 15/12/29.
//  Copyright © 2015年 蓝鸥科技. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HomePageModel.h"
@interface DataBaseLast : NSObject

//打开数据库创建表
+ (DataBaseLast *)defaultDataBaseLast;

//打开表
- (void)openDatabase;

//插入一条数据
- (void)insertOneBase:(HomePageModel *)homePageModel;

- (BOOL)removeOneBase:(HomePageModel *)homePageModel;

- (BOOL)searchOneBase:(HomePageModel *)homePageModel;

- (NSArray *)selectAllBaseInCollectionList;

@end
