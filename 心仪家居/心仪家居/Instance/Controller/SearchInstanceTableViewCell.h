//
//  SearchInstanceTableViewCell.h
//  心仪家居
//
//  Created by 赵博 on 16/1/5.
//  Copyright © 2016年 蓝鸥科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Instance;
@interface SearchInstanceTableViewCell : UITableViewCell

@property(nonatomic, retain)Instance *instance;
/**
 *  图片
 */
@property(nonatomic, retain)UIImageView *bimgfilePic;
/**
 *  标题
 */
@property(nonatomic, retain)UILabel *subjectLabel;
/**
 *  样式
 */
@property(nonatomic, retain)NSDictionary *housetype_info;
/**
 *  风格
 */
@property(nonatomic,retain)NSDictionary *style_info;


@property(nonatomic, retain)UILabel *name1;

@property(nonatomic, retain)UILabel *name2;
@property(nonatomic, copy)NSString *searchText;
@end
