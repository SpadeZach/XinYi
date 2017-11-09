//
//  HeaderCollectionReusableView.m
//  心仪家居
//
//  Created by dllo on 15/12/21.
//  Copyright © 2015年 蓝鸥科技. All rights reserved.
//

#import "HeaderCollectionReusableView.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"

@interface HeaderCollectionReusableView ()<UIScrollViewDelegate>

@property(nonatomic, retain)UIView *aview;

@property(nonatomic, retain)UIScrollView *scrollView;
//翻页间隔
@property(nonatomic, retain) NSTimer *timer;

@property(nonatomic, retain)NSMutableArray *temp;

@end
@implementation HeaderCollectionReusableView

- (void)dealloc
{
    [_aview release];
    [_timer release];
    [_temp release];
    [_scrollView release];
    [super dealloc];
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        /*************** 轮播图 ***************/
        
        //创建轮播图
        self.aview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 200)];
        
        //滑动视图
        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.aview.frame.size.height)];
        self.scrollView.pagingEnabled = YES;
        //偏移量
        self.scrollView.contentOffset = CGPointMake(self.frame.size.width, 0);
        self.scrollView.backgroundColor = [UIColor clearColor];
        
        //控制区域
        self.scrollView.contentSize = CGSizeMake(self.frame.size.width * 10, self.aview.frame.size.height);
        //代理
        self.scrollView.delegate = self;
        [self.aview addSubview:self.scrollView];
        [_scrollView release];
  
        [AKNewWorking GetDataWithURL:@"http://ihome.cmfmobile.com:8080/sp/custom/getProductSet.do?__client__=android&type=living&pn=1&roomClass=living" dic:nil success:^(id responseObject) {
            NSArray *array = responseObject;
            //开辟可变数组
            self.temp = [NSMutableArray array];
            for (NSDictionary *dicList in array) {
                
                [self.temp addObject:dicList[@"pic"]];
                
            }
            
            
            [self.temp addObject:self.temp.firstObject];
            
            [self.temp insertObject:self.temp[self.temp.count - 2] atIndex:0];
            
            for (int i = 0; i < self.temp.count; i++) {
                
                UIImageView *imgView = [[UIImageView alloc] init];
                
                [imgView sd_setImageWithURL:self.temp[i] placeholderImage:[UIImage imageNamed:@"zhanwei"]];
                //大小
                imgView.frame = CGRectMake(self.frame.size.width * i, 0, self.aview.frame.size.width, self.aview.frame.size.height);
                
                
                
                [self.scrollView addSubview:imgView];
                
                [imgView release];
                
            }
            
            
            [self start];
            
        } filed:^(NSError *error) {
            
            
        }];
  
        [self addSubview:self.aview];
    }

    return self;
}


- (void)start
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(change) userInfo:nil repeats:YES];
}

- (void)stop
{
    [self.timer invalidate];
    self.timer = nil;
}

- (void)change
{
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.contentOffset.x + self.aview.frame.size.width, 0) animated:YES];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self stop];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self start];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.scrollView.contentOffset.x >= self.aview.frame.size.width * (self.temp.count - 1)) {
        [self.scrollView setContentOffset:CGPointMake(self.aview.frame.size.width, 0) animated:NO];
    } else if (self.scrollView.contentOffset.x <= 0) {
        [self.scrollView setContentOffset:CGPointMake(self.aview.frame.size.width * (self.temp.count - 2), 0) animated:NO];
    }
}


@end
