//
//  SearchCollectionViewCell.h
//  心仪家居
//
//  Created by 赵博 on 16/1/4.
//  Copyright © 2016年 蓝鸥科技. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HomePageDetail;
@interface SearchCollectionViewCell : UICollectionViewCell


@property(nonatomic, retain)HomePageDetail *homePageDetail;

/**
 *  图片
 */
@property(nonatomic, retain)UIImageView *urlPic;

@property(nonatomic, retain)UILabel *commentLabel;
@end
