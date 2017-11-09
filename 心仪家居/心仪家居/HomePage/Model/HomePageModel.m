//
//  HomePageModel.m
//  心仪家居
//
//  Created by dllo on 15/12/21.
//  Copyright © 2015年 蓝鸥科技. All rights reserved.
//

#import "HomePageModel.h"

@implementation HomePageModel  

- (void)dealloc
{
    [_ID release];
    [_areaName release];
    [_name release];
    [_imgUrl release];
    [_styleName release];
    [_spaceName release];
    [_counts release];
    [_searchText release];
    [super dealloc];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
    
}

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dictionary];
    }
    return self;
}



@end
