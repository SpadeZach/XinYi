//
//  HomePageDetail.m
//  心仪家居
//
//  Created by dllo on 15/12/22.
//  Copyright © 2015年 蓝鸥科技. All rights reserved.
//

#import "HomePageDetail.h"

@implementation HomePageDetail

- (void)dealloc
{
    [_imgUrl release];
    [_comment release];
    [super dealloc];
}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
}

@end
