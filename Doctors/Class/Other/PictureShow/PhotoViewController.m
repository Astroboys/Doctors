//
//  PhotoViewController.m
//  familyTest
//
//  Created by Gao on 15-1-15.
//  Copyright (c) 2015年 huangxiaoya. All rights reserved.
//

#import "PhotoViewController.h"
#import "PhotoCell.h"
@interface PhotoViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>{
    
    CGSize _size;
    
    UICollectionView*PhotoView;
}

@end

@implementation PhotoViewController
@synthesize name;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _size = [UIScreen mainScreen].bounds.size;
  
    [[UIApplication sharedApplication]setStatusBarHidden:YES];
    
    [self _initcollectionview];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(removePhoto) name:@"quitPhoto" object:nil];
}

-(void)removePhoto
{
    [[UIApplication sharedApplication]setStatusBarHidden:NO];
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"quitPhoto" object:nil];
}

//创建一个collectionview的实现
- (void)_initcollectionview{
    UICollectionViewFlowLayout *flowlayou = [[UICollectionViewFlowLayout alloc]init];
    
    //设置方向 [水平方向]
    
    flowlayou.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    //设置大小
    
    flowlayou.itemSize = CGSizeMake(_size.width, _size.height);
    
    //设置间距
    
    flowlayou.minimumLineSpacing = 0;
    
    
    PhotoView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, _size.width, _size.height) collectionViewLayout:flowlayou];
    
    [self.view addSubview:PhotoView];
    
    PhotoView.dataSource=self;
    PhotoView.delegate=self;
    PhotoView.pagingEnabled=YES;
    
    [PhotoView registerClass:[PhotoCell class] forCellWithReuseIdentifier:@"cell001"];
    
    [PhotoView scrollToItemAtIndexPath:_indexpath atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
    
    name=[[UILabel alloc]initWithFrame:CGRectMake(0, _size.height-40,_size.width, 40)];
    name.text=[[NSString alloc] initWithFormat:@"%ld/%lu",(unsigned long)_indexpath.row+1,(unsigned long)self.images.count];
    name.textColor=[UIColor whiteColor];
    name.textAlignment=NSTextAlignmentCenter;
    name.backgroundColor=[UIColor blackColor];
    [self.view addSubview:name];
}
//必须实现的代理方法

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.images.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    PhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell001" forIndexPath:indexPath];
    NSString *stringUrl = [self.images objectAtIndex:indexPath.row];
    
    cell.imageUrl = stringUrl;
    
    
    return cell;
    
}
//当单元格消失时调用
- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int page=(int)scrollView.contentOffset.x/PhotoView.frame.size.width;
    name.text=[[NSString alloc] initWithFormat:@"%d/%lu",page+1,(unsigned long)self.images.count];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
