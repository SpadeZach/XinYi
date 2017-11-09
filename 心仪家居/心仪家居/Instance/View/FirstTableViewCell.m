
//
//  FirstTableViewCell.m
//  心仪家居
//
//  Created by dllo on 15/12/26.
//  Copyright © 2015年 蓝鸥科技. All rights reserved.
//

#import "FirstTableViewCell.h"
#import "Instance.h"
#import "UIImageView+WebCache.h"

@implementation FirstTableViewCell

- (void)dealloc
{
    [_housemap release];
    [_Description release];
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.housemap = [[UIImageView alloc] init];
        [self.contentView addSubview:self.housemap];
        [_housemap release];
        
        self.Description = [[UILabel alloc] init];
        self.Description.numberOfLines = 0;
        self.Description.textColor = [UIColor lightGrayColor];
        self.Description.font = [UIFont systemFontOfSize:17];
        [self.contentView addSubview:self.Description];
        [_Description release];
        
    }
    return self;
}
- (void)layoutSubviews
{
    
    [super layoutSubviews];
    
   CGFloat height = [FirstTableViewCell heightOfLabel:self.Description.text font:[UIFont systemFontOfSize:17] width:self.frame.size.width - 20];
    
    self.Description.frame = CGRectMake(10, 20, self.frame.size.width - 20,height);
    self.housemap.frame = CGRectMake(0, self.Description.frame.origin.y + self.Description.frame.size.height + 5, self.frame.size.width, 200);

}


- (void)setSdictionary:(NSDictionary *)sdictionary
{
    if (_sdictionary != sdictionary) {
        [_sdictionary release];
        _sdictionary = [sdictionary retain];
    }
    
    self.Description.text = sdictionary[@"Description"];
    
    [self.housemap sd_setImageWithURL:[NSURL URLWithString:sdictionary[@"housemap"]] placeholderImage:[UIImage imageNamed:@"zhanwei"]];
    
//    [self.housemap sd_setImageWithURL:[NSURL URLWithString:sdictionary[@"housemap"]]];

}




+ (CGFloat)heightOfLabel:(NSString *)text font:(UIFont *)font width:(CGFloat)width
{
    CGSize size = CGSizeMake(width, MAXFLOAT);
    
    NSDictionary *style = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil];
    
    CGRect result = [text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:style context:nil];
    
    
    return result.size.height;
}








- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
