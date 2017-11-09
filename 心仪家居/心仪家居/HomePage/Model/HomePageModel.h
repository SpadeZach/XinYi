//
//  HomePageModel.h
//  心仪家居
//
//  Created by dllo on 15/12/21.
//  Copyright © 2015年 蓝鸥科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomePageModel : NSObject

/**
 *  房子平数
 */
@property(nonatomic, copy)NSString *areaName;
/**
 *  标题
 */
@property(nonatomic, copy)NSString *name;
/**
 *  作品图片
 */
@property(nonatomic, copy)NSString *imgUrl;
/**
 *  风格
 */
@property(nonatomic, copy)NSString *styleName;
/**
 *  房间样式
 */
@property(nonatomic, copy)NSString *spaceName;
/**
 *  图片数量
 */
@property(nonatomic, copy)NSString *counts;
/**
 *  ID
 */
@property(nonatomic, copy)NSString *ID;
// 搜索内容高亮处理
@property(nonatomic, copy)NSString *searchText;

- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
