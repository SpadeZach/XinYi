//
//  GalleryViewController.m
//  心仪家居
//
//  Created by dllo on 15/12/24.
//  Copyright © 2015年 蓝鸥科技. All rights reserved.
//

#import "GalleryViewController.h"
#import "AFNetworking.h"
#import "ChangeTitleAnimation.h"
#import "BigGalleryCollectionViewCell.h"
#import "LastViewController.h"

#define kWidth [[UIScreen mainScreen]bounds].size.width
#define kHeight self.view.frame.size.height
#define kRestOfHeight (kHeight - 64 - 49)

@interface GalleryViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, ChangeTitleAnimationDelegate, BigGalleryCollectionViewCellDelegate>
@property (nonatomic, retain) NSArray *items;

@property(nonatomic, retain)UICollectionView *collectionView;

@property(nonatomic, retain)NSMutableArray *urlArray;

@property(nonatomic, retain)UICollectionView *coll;

/**
 *  后一页数据数组
 */
@property(nonatomic, retain)NSMutableArray *sectionArray;

@end

@implementation GalleryViewController
- (void)dealloc
{

    [_coll release];
    [_collectionView release];
    [_urlArray release];
    [_items release];
    [super dealloc];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.title = @"图库";
    
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    

    self.items =  [NSMutableArray arrayWithObjects:@"所有", @"现代简约", @"欧式", @"田园", @"混搭", @"中式", @"地中海", @"新古典", @"美式乡村", nil];
    
    ChangeTitleAnimation *title = [ChangeTitleAnimation ChangeTitleAnimationWithFrame:CGRectMake(0, 64, kWidth, 30) titleArray:self.items titleColor:nil titleSelectedColor:nil lineColor:nil sizeOfFont:12];
    
    title.tag = 1000;
    
    title.delegate = self;
    
    [self.view addSubview:title];

    NSString *url = @"http://pic.jiajuol.com/api/iphone/0600/pic_photo.php?act=photo_list&page=1&pagesize=24&v=6.0";
    
    NSString *url1 = @"http://pic.jiajuol.com/api/iphone/0600/pic_photo.php?act=photo_list&page=1&pagesize=24&style_id=27&v=6.0";
    
    
    NSString *url2 = @"http://pic.jiajuol.com/api/iphone/0600/pic_photo.php?act=photo_list&page=1&pagesize=24&style_id=2&v=6.0";

    NSString *url3 = @"http://pic.jiajuol.com/api/iphone/0600/pic_photo.php?act=photo_list&page=1&pagesize=24&style_id=16&v=6.0";

    NSString *url4 = @"http://pic.jiajuol.com/api/iphone/0600/pic_photo.php?act=photo_list&page=1&pagesize=24&style_id=19&v=6.0";

    NSString *url5 = @"http://pic.jiajuol.com/api/iphone/0600/pic_photo.php?act=photo_list&page=1&pagesize=24&style_id=1&v=6.0";
    
    NSString *url6 = @"http://pic.jiajuol.com/api/iphone/0600/pic_photo.php?act=photo_list&page=1&pagesize=24&style_id=9&v=6.0";

    NSString *url7 = @"http://pic.jiajuol.com/api/iphone/0600/pic_photo.php?act=photo_list&page=1&pagesize=24&style_id=28&v=6.0";

    NSString *url8 = @"http://pic.jiajuol.com/api/iphone/0600/pic_photo.php?act=photo_list&page=1&pagesize=24&style_id=30&v=6.0";
    
    self.urlArray = [NSMutableArray arrayWithObjects:url, url1, url2, url3, url4, url5, url6, url7, url8, nil];

    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(kWidth - 10, kRestOfHeight - 40);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64 + 30, kWidth, kRestOfHeight - 30) collectionViewLayout:layout];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;

    self.collectionView.pagingEnabled = YES;
    
//    self.collectionView.backgroundColor = [UIColor clearColor];
    //注册
    self.collectionView.showsHorizontalScrollIndicator = NO;
    [self.collectionView registerClass:[BigGalleryCollectionViewCell class] forCellWithReuseIdentifier:@"chongyong"];
    
    
    
    [self.view addSubview:self.collectionView];
    [_collectionView release];
    [layout release];

    
}

- (void)getPresentTitleNumber:(NSInteger)titleNumber {
    
    CGFloat offsetX = (titleNumber - 1) * kWidth;
    [self.collectionView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    NSInteger x = self.collectionView.contentOffset.x / kWidth;
    ChangeTitleAnimation *title = [self.view viewWithTag:1000];
    [title changeTitleByValue:x + 1];
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.urlArray.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    BigGalleryCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"chongyong" forIndexPath:indexPath];
 
    cell.urlData = self.urlArray[indexPath.row];
    
    cell.indexP = indexPath.row;
    
    //协议
    cell.delegate = self;
    
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}

//小collectionView 点击事件
- (void)clicked:(Gallery *)galleryModel{
    
    LastViewController *lastViewVC = [[LastViewController alloc] init];
    
    lastViewVC.galleryModel = galleryModel;

    [self.navigationController pushViewController:lastViewVC animated:YES];

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
