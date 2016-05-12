//
//  CollectionViewLayout.m
//  DemoCollectionView
//
//  Created by Chris Hu on 16/1/18.
//  Copyright © 2016年 icetime17. All rights reserved.
//

#import "CollectionViewLayout.h"

@implementation CollectionViewLayout {

    NSInteger cellCount;
    
    CGFloat _widthCollectionView;
    CGFloat _heightCollectionView;
    
    CGFloat _widthCollectionViewCell;
    CGFloat _heightCollectionViewCell;
}

- (instancetype)initWithType:(LayoutCollectionView)type
{
    self = [super init];
    if (self) {
        self.type = type;
        
        if (type == Layout_DefaultFlow) {
            self = [[UICollectionViewFlowLayout alloc] init];
        }
    }
    return self;
}

// 其他准备工作
- (void)prepareLayout {
    [super prepareLayout];
    
    cellCount                   = [self.collectionView numberOfItemsInSection:0];
    
    _widthCollectionView        = CGRectGetWidth(self.collectionView.frame);
    _heightCollectionView       = CGRectGetHeight(self.collectionView.frame);
    
    _widthCollectionViewCell    = self.itemSize.width;
    _heightCollectionViewCell   = self.itemSize.height;
    
    // 设置content的缩进
    // 刚好cell滑动至屏幕最中间的时候，尺寸最大。
    self.collectionView.contentInset = UIEdgeInsetsMake((_heightCollectionView - _heightCollectionViewCell) / 2, 0, (_heightCollectionView - _heightCollectionViewCell) / 2, 0);
}

// collectionView内容尺寸
- (CGSize)collectionViewContentSize {
    return CGSizeMake(_widthCollectionView, _heightCollectionViewCell * cellCount);
}

// 返回rect中所有元素的布局信息组成的数组
- (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    
    NSMutableArray *array = [NSMutableArray array];
    for (NSInteger i = 0; i < cellCount; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:indexPath];
        [array addObject:attributes];
    }
    
    return array;
}

// 返回对应indexPath的item布局信息，使用UICollectionViewLayoutAttributes可定义item的布局
- (nullable UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *attributes;
    switch (self.type) {
        case Layout_Linear:
            attributes = [self attributesForLinear:indexPath];
            break;
        default:
            attributes = [self attributesForLinear:indexPath];
            break;
    }
    return attributes;
}

//- (nullable UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
//
//}
//
//- (nullable UICollectionViewLayoutAttributes *)layoutAttributesForDecorationViewOfKind:(NSString*)elementKind atIndexPath:(NSIndexPath *)indexPath {
//
//}

// 当边界改变时，是否应该刷新布局。
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return !CGRectEqualToRect(newBounds, self.collectionView.bounds);
}

- (UICollectionViewLayoutAttributes *)attributesForLinear:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attributes.size = self.itemSize;
    
    //    CGFloat setoff = 50.0f;
    //    CGFloat x = self.collectionView.bounds.origin.x + setoff * indexPath.row;
    //    CGFloat y = self.collectionView.bounds.origin.y + 64 + setoff * indexPath.row;
    //    attributes.center = CGPointMake(x, y);
    
    CGFloat cY = self.collectionView.contentOffset.y + _heightCollectionView / 2;
    CGFloat attributesY = _heightCollectionViewCell * indexPath.row + _heightCollectionViewCell / 2;
    attributes.zIndex = -ABS(attributesY - cY);
    
    CGFloat delta = cY - attributesY;
    CGFloat ratio =  - delta / (_heightCollectionViewCell * 2);
    CGFloat scale = 1 - ABS(delta) / (_heightCollectionViewCell * 6.0) * cos(ratio * M_PI_4);
    attributes.transform = CGAffineTransformMakeScale(scale, scale);
    
    CGFloat centerY = attributesY;
    
    attributes.center = CGPointMake(_widthCollectionView / 2, centerY);

    return attributes;
}

@end
