//
//  BigGalleryCollectionViewCell.h
//  心仪家居
//
//  Created by dllo on 15/12/25.
//  Copyright © 2015年 蓝鸥科技. All rights reserved.
//

#import <UIKit/UIKit.h>


@class Gallery;

@protocol BigGalleryCollectionViewCellDelegate <NSObject>

- (void)clicked:(Gallery *)galleryModel;

@end



@interface BigGalleryCollectionViewCell : UICollectionViewCell


@property(nonatomic, assign) id<BigGalleryCollectionViewCellDelegate>delegate;



@property(nonatomic, copy)NSString *urlData;


@property(nonatomic, assign)NSInteger indexP;


@property(nonatomic, retain)UICollectionView *collectionView;



@end
