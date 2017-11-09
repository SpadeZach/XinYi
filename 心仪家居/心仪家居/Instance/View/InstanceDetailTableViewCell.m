//
//  InstanceDetailTableViewCell.m
//  心仪家居
//
//  Created by dllo on 15/12/26.
//  Copyright © 2015年 蓝鸥科技. All rights reserved.
//

#import "InstanceDetailTableViewCell.h"
#import "InstanceDetail.h"
#import "UIImageView+WebCache.h"

@interface InstanceDetailTableViewCell ()

@property(nonatomic, retain)NSMutableArray *sectionArray;

@end

@implementation InstanceDetailTableViewCell
- (void)dealloc
{
    [_bimgfilePic release];
    [_des release];
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        self.bimgfilePic = [[UIImageView alloc] init];
        [self.contentView addSubview:self.bimgfilePic];
        [_bimgfilePic release];
        
        self.des = [[UILabel alloc] init];
        self.des.textColor = [UIColor lightGrayColor];
        self.des.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.des];
        [_des release];
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.bimgfilePic.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - 40);

    self.des.frame = CGRectMake(20, self.bimgfilePic.frame.origin.y + self.bimgfilePic.frame.size.height, self.frame.size.width - 40, 40);
}


- (void)setInstanceDetail:(InstanceDetail *)instanceDetail
{
    if (_instanceDetail != instanceDetail) {
        [_instanceDetail release];
        _instanceDetail = [instanceDetail retain];
    }
    
    
    [self.bimgfilePic sd_setImageWithURL:[NSURL URLWithString:instanceDetail.bimgfile] placeholderImage:[UIImage imageNamed:@"zhanwei"]];
//    [self.bimgfilePic sd_setImageWithURL:[NSURL URLWithString:instanceDetail.bimgfile]];
    
    self.des.text = instanceDetail.des;
}




- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
