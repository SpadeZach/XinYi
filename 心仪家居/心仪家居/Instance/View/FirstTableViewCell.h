//
//  FirstTableViewCell.h
//  心仪家居
//
//  Created by dllo on 15/12/26.
//  Copyright © 2015年 蓝鸥科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstTableViewCell : UITableViewCell
@property(nonatomic, retain)NSDictionary *sdictionary;


@property(nonatomic, retain)UILabel *Description;

@property(nonatomic, retain)UIImageView *housemap;



+ (CGFloat)heightOfLabel:(NSString *)text font:(UIFont *)font width:(CGFloat)width;

@end
