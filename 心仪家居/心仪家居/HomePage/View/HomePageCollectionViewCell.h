//
//  HomePageCollectionViewCell.h
//  心仪家居
//
//  Created by dllo on 15/12/21.
//  Copyright © 2015年 蓝鸥科技. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HomePageModel;
@interface HomePageCollectionViewCell : UICollectionViewCell

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

@end
