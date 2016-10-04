//
//  PhotoCell.h
//  familyTest
//
//  Created by Gao on 15-1-15.
//  Copyright (c) 2015年 huangxiaoya. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PhotoScrollview;

@interface PhotoCell : UICollectionViewCell{
    
PhotoScrollview *_scrollview;//创建scrollview


}

@property (nonatomic,retain) PhotoScrollview *scrollview;
@property (nonatomic, copy) NSString *imageUrl;


@end
