//
//  Instance.h
//  心仪家居
//
//  Created by dllo on 15/12/24.
//  Copyright © 2015年 蓝鸥科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Instance : NSObject


/**
 *  图片
 */
@property(nonatomic, copy)NSString *bimgfile;
/**
 *  标题
 */
@property(nonatomic, copy)NSString *subject;
/**
 *  样式
 */
//@property(nonatomic, copy)NSString *name;

/**
 *  描述
 */
@property(nonatomic, copy)NSString *Description;
/**
 *  房间样式
 */
@property(nonatomic, copy)NSString *housemap;
/**
 *  详情图片标题
 */
@property(nonatomic, copy)NSString *des;

@property(nonatomic, retain)NSMutableArray *subject_photo_list;

@property (nonatomic, copy) NSString *name1;
@property (nonatomic, copy) NSString *name2;
// 搜索内容高亮处理
@property(nonatomic, copy)NSString *searchText;
@end
