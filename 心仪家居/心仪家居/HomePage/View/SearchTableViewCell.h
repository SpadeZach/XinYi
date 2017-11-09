//
//  SearchTableViewCell.h
//  心仪家居
//
//  Created by 赵博 on 16/1/4.
//  Copyright © 2016年 蓝鸥科技. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HomePageModel;
@interface SearchTableViewCell : UITableViewCell

@property(nonatomic, retain)HomePageModel *homePageModel;

/**
 *  房间平数
 */
@property(nonatomic, retain)UILabel *areaNameLabel;
/**
 *  标题
 */
@property(nonatomic, retain)UILabel *nameLabel;
/**
 *  作品图片
 */
@property(nonatomic, retain)UIImageView *imgUrlPic;
/**
 *  风格
 */
@property(nonatomic, retain)UILabel *styleNameLabel;
/**
 *  样式
 */
@property(nonatomic, retain)UILabel *spaceNameLabel;
/**
 *  图片数
 */
@property(nonatomic, retain)UILabel *countsLabel;

@property(nonatomic, copy)NSString *searchText;

@end
