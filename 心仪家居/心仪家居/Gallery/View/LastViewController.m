//
//  LastViewController.m
//  心仪家居
//
//  Created by dllo on 15/12/28.
//  Copyright © 2015年 蓝鸥科技. All rights reserved.
//

#import "LastViewController.h"
#import "BigGalleryCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import "Gallery.h"
@interface LastViewController ()

@end

@implementation LastViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    

    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    scrollView.backgroundColor = [UIColor blackColor];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, scrollView.frame.size.width, scrollView.frame.size.height)];
    
 
    
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.galleryModel.bimgfile]];
    
    [scrollView addSubview:imageView];
    
    
    
    [self.view addSubview:scrollView];
    
    
    [imageView release];
    
    [scrollView release];
    
    
    
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
