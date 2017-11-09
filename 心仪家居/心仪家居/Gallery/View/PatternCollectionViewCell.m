//
//  PatternCollectionViewCell.m
//  心仪家居
//
//  Created by dllo on 15/12/25.
//  Copyright © 2015年 蓝鸥科技. All rights reserved.
//

#import "PatternCollectionViewCell.h"
#import "Gallery.h"
#import "UIImageView+WebCache.h"
@implementation PatternCollectionViewCell
- (void)dealloc
{
    [_bimgfilePic release];
    [super dealloc];
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.bimgfilePic = [[UIImageView alloc] init];
        [self.contentView addSubview:self.bimgfilePic];
        [_bimgfilePic release];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.bimgfilePic.frame = CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height);
}

- (void)setGallery:(Gallery *)gallery
{
    if (_gallery != gallery) {
        [_gallery release];
        _gallery = [gallery retain];
    }
    [self.bimgfilePic sd_setImageWithURL:[NSURL URLWithString:gallery.bimgfile] placeholderImage:[UIImage imageNamed:@"zhanwei"]];
//    [self.bimgfilePic sd_setImageWithURL:[NSURL URLWithString:gallery.bimgfile]];
}


@end
