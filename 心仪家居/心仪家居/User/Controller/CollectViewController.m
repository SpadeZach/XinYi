//
//  CollectViewController.m
//  心仪家居
//
//  Created by dllo on 15/12/30.
//  Copyright © 2015年 蓝鸥科技. All rights reserved.
//

#import "CollectViewController.h"
#import "DataBaseLast.h"
#import "HomePageRefisterTableViewCell.h"
#import "HomePageDetailViewController.h"
#import "DataBaseLast.h"
@interface CollectViewController ()<UITableViewDelegate, UITableViewDataSource>

//收藏tableView
@property(nonatomic, retain)UITableView *tableView;

/**
 *  数据数组 -- 来自数据库
 */
@property(nonatomic, retain)NSArray *dataArray;

@end

@implementation CollectViewController
- (void)dealloc
{
    [_tableView release];
    [_dataArray release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.title = @"我的收藏";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64 - 49)];
    
    [imageView setImage:[UIImage imageNamed:@"collectionPic.jpg"]];
    
    [self.view addSubview:imageView];
 
    dispatch_queue_t queue = dispatch_queue_create("line2", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(queue, ^{
        NSLog(@"子线程");
        DataBaseLast *dataBase = [DataBaseLast defaultDataBaseLast];
        self.dataArray = [NSArray array];
        self.dataArray = [dataBase selectAllBaseInCollectionList];

        [self.tableView reloadData];
    });
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64 - 49) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.rowHeight = 235;
    [self.view addSubview:self.tableView];
    [_tableView release];
        
}

- (void)viewWillAppear:(BOOL)animated
{
    DataBaseLast *dataBase = [DataBaseLast defaultDataBaseLast];
    self.dataArray = [NSArray array];
    self.dataArray = [dataBase selectAllBaseInCollectionList];
    
    [self.tableView reloadData];
}


#pragma mark 返回行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}

#pragma mark 返回cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *iden = @"iden";
    HomePageRefisterTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:iden];
    if (!cell) {
        cell = [[[HomePageRefisterTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:iden] autorelease];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.homePageModel = self.dataArray[indexPath.row];
    
    cell.backgroundColor = [UIColor clearColor];
    
    //去除单元格点击后背景颜色
    UIView *backView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView = backView;
    cell.selectedBackgroundView.backgroundColor = [UIColor whiteColor];
    
    
    
    BOOL isExist = [[DataBaseLast defaultDataBaseLast]searchOneBase:cell.homePageModel];
    
    NSString *imageString = nil;
    
    if (isExist) {
        imageString = @"star-selected";
    }else
    {
        imageString = @"star-normal";
    }
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    
    button.tag = indexPath.row + 1000;
    
    button.frame = CGRectMake(self.view.frame.size.width - 10 -30, 210, 25, 25);
    
    //按钮状态
    button.selected = isExist;
    
    
    [button addTarget:self action:@selector(collectionAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [button setBackgroundImage:[UIImage imageNamed:imageString] forState:UIControlStateNormal];
    
    [cell addSubview:button];
    
    return cell;
}


#pragma mark cell的点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    HomePageDetailViewController *collectionDeatilVC = [[HomePageDetailViewController alloc] init];
    
    collectionDeatilVC.homePageModel = self.dataArray[indexPath.row];
    
    [self.navigationController pushViewController:collectionDeatilVC animated:YES];
    
    
    
    [collectionDeatilVC release];
}

- (void)collectionAction:(UIButton *)sender
{
    sender.selected = sender.isSelected;
    if (sender.isSelected) {
        [sender setBackgroundImage:[UIImage imageNamed:@"star-normal"] forState:UIControlStateNormal];
        [[DataBaseLast defaultDataBaseLast] removeOneBase:self.dataArray[sender.tag - 1000]];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"取消收藏" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        

            DataBaseLast *dataBase = [DataBaseLast defaultDataBaseLast];
            self.dataArray = [NSArray array];
            self.dataArray = [dataBase selectAllBaseInCollectionList];
            
            [self.tableView reloadData];
        
        
        [alert show];
        
        [alert release];
        
        
       
    }
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
