//
//  CollectionViewLayout.h
//  DemoCollectionView
//
//  Created by Chris Hu on 16/1/18.
//  Copyright © 2016年 icetime17. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, LayoutCollectionView) {
    Layout_DefaultFlow = 0,
    Layout_Linear,
    Layout_Rotary,
    Layout_Carousel,
    Layout_CoverFlow,
    Layout_Horizontal,
};

@interface CollectionViewLayout : UICollectionViewLayout

@property (nonatomic) LayoutCollectionView type;
@property (nonatomic) UICollectionViewScrollDirection scrollDirection;
@property (nonatomic) CGSize itemSize;

- (instancetype)initWithType:(LayoutCollectionView)type;

@end
