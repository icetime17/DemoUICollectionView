//
//  CollectionLayoutScrollView.m
//  DemoCollectionView
//
//  Created by Chris Hu on 16/5/12.
//  Copyright © 2016年 icetime17. All rights reserved.
//

#import "CollectionLayoutScrollView.h"

@implementation CollectionLayoutScrollView {
    
    CGSize _itemSize;

    NSInteger _cellCount;
    
    CGFloat _widthCollectionView;
    CGFloat _heightCollectionView;
    
    CGFloat _widthCollectionViewCell;
    CGFloat _heightCollectionViewCell;
    
    CGPoint _center;
    CGFloat _radius;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)prepareLayout{
    [super prepareLayout];
    
    _cellCount = [self.collectionView numberOfItemsInSection:0];
    
    _itemSize = CGSizeMake(250, 250);
    
    _widthCollectionView        = CGRectGetWidth(self.collectionView.frame);
    _heightCollectionView       = CGRectGetHeight(self.collectionView.frame);
    
    _widthCollectionViewCell    = _itemSize.width;
    _heightCollectionViewCell   = _itemSize.height;
    
    _center = CGPointMake(_widthCollectionView / 2.0, _heightCollectionView / 2.0);
    _radius = MIN(_widthCollectionView, _heightCollectionView) / 2.5;
    
    self.collectionView.contentInset = UIEdgeInsetsMake((_heightCollectionView - _heightCollectionViewCell) / 2, 0, (_heightCollectionView - _heightCollectionViewCell) / 2, 0);
}

// collectionView内容尺寸
- (CGSize)collectionViewContentSize {
    return CGSizeMake(_widthCollectionViewCell * _cellCount, _heightCollectionView);
}

// 返回rect中所有元素的布局信息组成的数组
- (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    
    NSMutableArray *array = [NSMutableArray array];
    for (NSInteger i = 0; i < _cellCount; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:indexPath];
        [array addObject:attributes];
    }

    return array;
}

// 返回对应indexPath的item布局信息，使用UICollectionViewLayoutAttributes可定义item的布局
- (nullable UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    // size
    attributes.size = _itemSize;
    
    CGFloat cX = self.collectionView.contentOffset.x + _widthCollectionView / 2;
    CGFloat attributesX = _widthCollectionViewCell * indexPath.item + _widthCollectionViewCell / 2;
    
    CGFloat delta = cX - attributesX;
    CGFloat ratio = - delta / (_widthCollectionViewCell * 2);
    CGFloat scale = 1 - ABS(delta) / (_widthCollectionViewCell * 6.0) * cos(ratio * M_PI_4);
    attributes.transform = CGAffineTransformMakeScale(scale, scale);
    
    CGFloat centerX = attributesX;
    
    attributes.center = CGPointMake(centerX, _heightCollectionView / 2);

    return attributes;
}


@end
