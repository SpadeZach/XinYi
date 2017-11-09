//
//  BigGalleryCollectionViewCell.m
//  心仪家居
//
//  Created by dllo on 15/12/25.
//  Copyright © 2015年 蓝鸥科技. All rights reserved.
//

#import "BigGalleryCollectionViewCell.h"
#import "AFNetworking.h"
#import "Gallery.h"
#import "PatternCollectionViewCell.h"
#import "MBProgressHUD.h"
#import "MJRefresh.h"
#import "GalleryViewController.h"
@interface BigGalleryCollectionViewCell ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

//@property(nonatomic, retain)UICollectionView *collectionView;

@property(nonatomic, retain)NSMutableArray *sectionArray;

@property(nonatomic, retain)NSMutableArray *urlArray;


@property(nonatomic, retain)NSMutableArray *jointArray;
@end



@implementation BigGalleryCollectionViewCell

- (void)dealloc
{
    [_jointArray release];
    [_urlArray release];
    [_collectionView release];
    [_sectionArray release];
    [_urlData release];
    [super dealloc];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        
        layout.itemSize = CGSizeMake(self.frame.size.width / 3 - 10, 100);
        
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        
        
        self.collectionView.delegate = self;
        
        self.collectionView.dataSource = self;
        //背景
        self.collectionView.backgroundColor = [UIColor clearColor];
        //注册
        [self.collectionView registerClass:[PatternCollectionViewCell class] forCellWithReuseIdentifier:@"indfi"];
        
        [self.contentView addSubview:self.collectionView];
        
        [_collectionView release];
        
            }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.collectionView.frame = CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height);
}

- (void)setUrlData:(NSString *)urlData{
    if (_urlData != urlData) {
        [_urlData release];
        _urlData = [urlData retain];
    }
    //网络菊花
    [MBProgressHUD showHUDAddedTo:self.collectionView animated:YES];
    
    [AKNewWorking GetDataWithURL:[NSString stringWithFormat:@"%@",self.urlData] dic:nil success:^(id responseObject) {
        
        self.sectionArray = [NSMutableArray array];

        
        NSMutableArray *array = responseObject;
        for (NSDictionary *dic in array) {
            
            Gallery *gallery = [[Gallery alloc] init];
            
            [gallery setValuesForKeysWithDictionary:dic];
            
            [self.sectionArray addObject:gallery];
       
        }
       
        [NSTimer scheduledTimerWithTimeInterval:15 target:self selector:@selector(stopReload) userInfo:nil repeats:NO];

        
        [self.collectionView reloadData];
        [MBProgressHUD hideHUDForView:self.collectionView animated:YES];

        
    } filed:^(NSError *error) {
       
        NSLog(@"%@", error);
        
    }];
    
    //刷新数据
    [self refreshData];
    
    //加载数据
    [self getData];
    
}

- (void)stopReload
{
    [MBProgressHUD hideAllHUDsForView:self.collectionView animated:YES];
}

//刷新数据
- (void)refreshData
{
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        // 发送一个GET请求
        [MBProgressHUD showHUDAddedTo:self.contentView animated:YES];

        [AKNewWorking GetDataWithURL:[NSString stringWithFormat:@"%@",self.urlData] dic:nil success:^(id responseObject) {
   
           
            self.sectionArray = [NSMutableArray array];
            
            
            NSMutableArray *array = responseObject;
            for (NSDictionary *dic in array) {
                
                Gallery *gallery = [[Gallery alloc] init];
                
                [gallery setValuesForKeysWithDictionary:dic];
                
                [self.sectionArray addObject:gallery];
                
            }
            [self.collectionView reloadData];
            
        } filed:^(NSError *error) {
            
            NSLog(@"%@", error);
            
        }];
        
        [self.collectionView.mj_header endRefreshing];
        
        [MBProgressHUD hideHUDForView:self.contentView animated:YES];
        
        [self.collectionView reloadData];
        

    
    }];
    
}
//加载
- (void)getData
{
   self.collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{

       self.jointArray = [NSMutableArray arrayWithObjects:@"&pagesize=24&v=6.0", @"&pagesize=24&style_id=27&v=6.0", @"&pagesize=24&style_id=2&v=6.0", @"&pagesize=24&style_id=16&v=6.0", @"&pagesize=24&style_id=19&v=6.0", @"&pagesize=24&style_id=1&v=6.0", @"&pagesize=24&style_id=9&v=6.0", @"&pagesize=24&style_id=28&v=6.0", @"&pagesize=24&style_id=30&v=6.0", nil];
  
       NSString *qian = [self.urlData substringToIndex:74];
   
       static int i = 2;
       
       i ++;
 
       NSString *trueurl = [NSString stringWithFormat:@"%@%d%@",qian, i,  self.jointArray[self.indexP]];
       
       
       
       [AKNewWorking GetDataWithURL:[NSString stringWithFormat:@"%@",trueurl] dic:nil success:^(id responseObject) {
    
           NSMutableArray *array = responseObject;
           for (NSDictionary *dic in array) {
               
               Gallery *gallery = [[Gallery alloc] init];
               
               [gallery setValuesForKeysWithDictionary:dic];
               
               [self.sectionArray addObject:gallery];
               
           }
           [self.collectionView reloadData];
           [MBProgressHUD hideHUDForView:self.collectionView animated:YES];
       } filed:^(NSError *error) {
           
           NSLog(@"%@", error);
           
       }];
       
       [self.collectionView.mj_footer endRefreshing];
       
       [self.collectionView reloadData];
  
   }];
}




- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.sectionArray.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PatternCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"indfi" forIndexPath:indexPath];
    cell.gallery = self.sectionArray[indexPath.row];
//    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

// 点击事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.delegate clicked:self.sectionArray[indexPath.row]];
}




@end
