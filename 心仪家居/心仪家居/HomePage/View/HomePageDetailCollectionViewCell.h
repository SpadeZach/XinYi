//
//  HomePageDetailCollectionViewCell.h
//  心仪家居
//
//  Created by dllo on 15/12/22.
//  Copyright © 2015年 蓝鸥科技. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HomePageDetail;
@interface HomePageDetailCollectionViewCell : UICollectionViewCell

@property(nonatomic, retain)HomePageDetail *homePageDetail;

/**
 *  图片
 */
@property(nonatomic, retain)UIImageView *urlPic;

@property(nonatomic, retain)UILabel *commentLabel;

@end
