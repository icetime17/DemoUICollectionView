//
//  CollectionLayoutCircle.m
//  DemoCollectionView
//
//  Created by Chris Hu on 16/5/12.
//  Copyright © 2016年 icetime17. All rights reserved.
//

#import "CollectionLayoutCircle.h"

@implementation CollectionLayoutCircle {

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
    
    _itemSize = CGSizeMake(50, 50);
    
    _widthCollectionView        = CGRectGetWidth(self.collectionView.frame);
    _heightCollectionView       = CGRectGetHeight(self.collectionView.frame);
    
    _widthCollectionViewCell    = _itemSize.width;
    _heightCollectionViewCell   = _itemSize.height;
    
    _center = CGPointMake(_widthCollectionView / 2.0, _heightCollectionView / 2.0);
    _radius = MIN(_widthCollectionView, _heightCollectionView) / 2.5;
    
    self.collectionView.contentInset = UIEdgeInsetsMake(0, 0, 00, 0);
}

// collectionView内容尺寸
- (CGSize)collectionViewContentSize {
    return CGSizeMake(_widthCollectionView, _heightCollectionView);
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
    
    attributes.center = CGPointMake(_center.x + _radius * cosf(2 * indexPath.item * M_PI / _cellCount),
                                    _center.y + _radius * sinf(2 * indexPath.item * M_PI / _cellCount));
    
    return attributes;
}


@end
