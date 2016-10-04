//
//  MoreActionView.m
//  ChatMessageDemo
//
//  Created by ZQ on 15/11/23.
//  Copyright © 2015年 ZQ. All rights reserved.
//

#import "MoreActionView.h"
#import "MoreActionViewCell.h"
#import "UIButton+WebCache.h"
@interface MoreActionView ()<UICollectionViewDataSource,UICollectionViewDelegate>
{
    UICollectionView *moreActionCollectioin;
    NSArray *imageArrayName;
    NSArray *imageTitleArray;
    NSArray *imageSelectedArray;
}
@end

@implementation MoreActionView


-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        imageArrayName = @[@"btn_inputbox_more_photo_default_",@"btn_inputbox_more_photograph_default_",@"btn_inputbox_more_position_default_",@"btn_inputbox_more_freephone_default_"];
        imageSelectedArray = @[@"btn_inputbox_more_photo_selected_",@"btn_inputbox_more_photograph_selected_",@"btn_inputbox_more_position_selected_",@"btn_inputbox_more_freephone_selected_"];
        imageTitleArray = @[@"照片",@"拍摄",@"位置",@"免费电话"];
        [self addAllViews];
    }
    return self;
}
-(void)setImageArray:(NSArray *)imageArray
{
    _imageArray = imageArray;
    [moreActionCollectioin reloadData];
}
-(void)addAllViews
{
    UICollectionViewFlowLayout *homeFlow = [[UICollectionViewFlowLayout alloc] init];
    [homeFlow setItemSize:CGSizeMake(40, 40)];//设置cell的尺寸
    homeFlow.minimumLineSpacing = 7;
    homeFlow.minimumInteritemSpacing = 6.0;
    
    moreActionCollectioin = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) collectionViewLayout:homeFlow];
    moreActionCollectioin.scrollEnabled = NO;
    moreActionCollectioin.backgroundColor = [UIColor whiteColor];
    moreActionCollectioin.dataSource = self;
    moreActionCollectioin.delegate = self;
    [self addSubview:moreActionCollectioin];
    [moreActionCollectioin registerClass:[MoreActionViewCell class] forCellWithReuseIdentifier:@"collectionViewCell"];

}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _imageArray.count;//imageTitleArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MoreActionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionViewCell" forIndexPath:indexPath];
    
    NSString *urlStr = _imageArray[indexPath.row];
    if ([urlStr hasSuffix:@".pdf"]) {
        [cell.moreActionBtn setImage:[UIImage imageNamed:@"healthIcon"] forState:UIControlStateNormal];
    }else{
        
        [cell.moreActionBtn sd_setImageWithURL:[NSURL URLWithString:urlStr] forState:UIControlStateNormal];
    }
    
    
//    cell.imageTitle.text = imageTitleArray[indexPath.row];
    return cell;
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    UIEdgeInsets top = {15,15,15,15};
    return top;
}

//设置顶部的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    CGSize size={0,0};
    return size;
}
//设置元素大小
//-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
//
//    //LNLog(@"%f",(kDeviceHeight-88-49)/4.0);
//    return CGSizeMake(240,(kDeviceHeight-kNavHeight*2-kTabBarHeight-20)/4.0);
//}

- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    MoreActionViewCell *cell = (MoreActionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    [cell.moreActionBtn setImage:[UIImage imageNamed:imageSelectedArray[indexPath.row]] forState:UIControlStateNormal];
    
}
- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    MoreActionViewCell *cell = (MoreActionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    [cell.moreActionBtn setImage:[UIImage imageNamed:imageArrayName[indexPath.row]] forState:UIControlStateNormal];
    
}

//点击元素触发事件
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSMutableDictionary *dict =[NSMutableDictionary dictionary];
    
    [dict setValue:[NSString stringWithFormat:@"%ld",(long)indexPath.row] forKey:@"index"];
    
    [dict setValue:_imageArray forKey:@"picture"];
    
    //创建通知
    NSNotification *notification =[NSNotification notificationWithName:@"showPicture" object:nil userInfo:dict];
    //通过通知中心发送通知
    [[NSNotificationCenter defaultCenter] postNotification:notification];
//    if (_delegate && [_delegate respondsToSelector:@selector(selectMoreActionWithIndex:)]) {
//        [_delegate selectMoreActionWithIndex:indexPath.row];
//    }
   
}


@end
