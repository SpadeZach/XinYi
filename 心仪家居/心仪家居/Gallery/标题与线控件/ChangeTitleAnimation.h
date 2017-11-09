//
//  ChangeTitleAnimation.h
//  ChangeTitle
//
//  Created by LML on 15/12/3.
//  Copyright © 2015年 LML-PC. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  标题小于4个是平均分, 标题大于4个使用滚动视图控制.
 *  如果标题数量大于4个,使用 self.automaticallyAdjustsScrollViewInsets = NO
 *  修复ScrollView自动偏移的问题
 */

@protocol ChangeTitleAnimationDelegate <NSObject>

/**
 *  用于得到当前点击的title序号 默认序号从1开始
 *
 *  @param titleNumber title序号
 */
- (void)getPresentTitleNumber:(NSInteger)titleNumber;

@end

@interface ChangeTitleAnimation : UIView

/**
 *  标题数组
 */
@property(nonatomic, retain)NSArray *titleArray;

/**
 *  标题点击颜色
 */
@property(nonatomic, retain)UIColor *titleSelectedColor;

/**
 *  标题颜色
 */
@property(nonatomic, retain)UIColor *titleColor;

/**
 *  下方线的颜色
 */
@property(nonatomic, retain)UIColor *lineColor;

/**
 *  字体
 */
@property(nonatomic, assign)CGFloat sizeOfFont;

/**
 *  对外接口, 用于外界(例如滚动视图滚动)对当前标题的变化
 *
 *  @param value 传入的控制值, 对应上方的标题 传入从1开始到最后一个标题的序号即可.
 */
- (void)changeTitleByValue:(NSInteger)value;

//初始化
- (instancetype)initWithFrame:(CGRect)frame titleArray:(NSArray *)titleArray titleColor:(UIColor *)titleColor titleSelectedColor:(UIColor *)titleSelectedColor lineColor:(UIColor *)lineColor sizeOfFont:(CGFloat)size;

+ (ChangeTitleAnimation *)ChangeTitleAnimationWithFrame:(CGRect)frame titleArray:(NSArray *)titleArray titleColor:(UIColor *)titleColor titleSelectedColor:(UIColor *)titleSelectedColor lineColor:(UIColor *)lineColor sizeOfFont:(CGFloat)size;

@property(nonatomic, assign)id <ChangeTitleAnimationDelegate> delegate;

@end
