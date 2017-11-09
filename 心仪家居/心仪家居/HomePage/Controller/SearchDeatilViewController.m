//
//  SearchDeatilViewController.m
//  心仪家居
//
//  Created by 赵博 on 16/1/4.
//  Copyright © 2016年 蓝鸥科技. All rights reserved.
//

#import "SearchDeatilViewController.h"
#import "SearchCollectionViewCell.h"
#import "MBProgressHUD.h"
#import "AFNetworking.h"
#import "SearchCollectionViewCell.h"
#import "HomePageDetail.h"
@interface SearchDeatilViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property(nonatomic, retain)UICollectionView *collection;

//控制数组
@property(nonatomic, retain)NSMutableArray *sectionArray;

@end

@implementation SearchDeatilViewController
- (void)dealloc
{
    [super dealloc];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height) collectionViewLayout:layout];
    
    //横向翻页
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    //collectionView 继承自 UIScrollView   遇到navigation时会偏移, 所以需要修复偏移
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //翻页
    collectionView.pagingEnabled = YES;
    
    //清除背景
//    collectionView.backgroundColor = [UIColor clearColor];
    
    //注册
    [collectionView registerClass:[SearchCollectionViewCell class] forCellWithReuseIdentifier:@"inte"];
    
    collectionView.dataSource = self;
    
    collectionView.delegate = self;
    
    
    // 状态栏网络菊花
    [MBProgressHUD showHUDAddedTo:collectionView animated:YES];
    
    
    //详情数据解析
    [AKNewWorking GetDataWithURL:[NSString stringWithFormat:@"http://www.shejiben.com/mobile/index.php?action=detail&appid=30&appostype=2&appversion=2.2.0&channel=appstore&id=%@&idfa=170C1679-6CC9-44DC-B744-F2DF5D7633E1&module=cases&systemversion=8.3&t8t_device_id=7E49229C-5F62-4C61-9645-4959F46184CE&to8to_token=&uid=0&version=2.2",self.homePageDetail.ID] dic:nil success:^(id responseObject) {
        
        NSDictionary *dictionary = responseObject;
        
        self.sectionArray = [NSMutableArray array];
        
        
        for (NSDictionary *dic in [dictionary[@"data"] objectForKey:@"imgList"]) {
            
            HomePageDetail *homePageDetail = [[HomePageDetail alloc] init];
            [homePageDetail setValuesForKeysWithDictionary:dic];
            
            [self.sectionArray addObject:homePageDetail];
            
            
        }
        // 状态栏网络菊花
        [MBProgressHUD hideHUDForView:collectionView animated:YES];
        
        
        [collectionView reloadData];
    } filed:^(NSError *error) {
        
        NSLog(@"%@",error);
        
    }];
    
    
    
    [self.view addSubview:collectionView];
    [collectionView release];
    
}

#pragma mark Itmes数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.sectionArray.count;
}
#pragma mark Items
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SearchCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"inte" forIndexPath:indexPath];
    
    cell.homePageDetail = self.sectionArray[indexPath.row];
    
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}

#pragma mark 单元格大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height);
}

#pragma mark 边距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

#pragma mark 左右间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}







- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
