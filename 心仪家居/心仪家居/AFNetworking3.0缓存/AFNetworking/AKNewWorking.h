//
//  AKNewWorking.h
//  CollectionViewTableView
//
//  Created by dllo on 15/12/21.
//  Copyright © 2015年 LML-PC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AKNewWorking : NSObject


/**
 *  get缓存
 */
+ (void)GetDataWithURL:(NSString *)urlStr dic:(NSDictionary *)dic success:(void(^)(id responseObject))response filed:(void(^)(NSError *error))err;




@end
