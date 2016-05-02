//
//  DecorationController.m
//  DemoCollectionView
//
//  Created by Chris Hu on 16/5/1.
//  Copyright © 2016年 icetime17. All rights reserved.
//

#import "DecorationController.h"

@implementation DecorationController

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _filtersCollectionView.numberOfSections;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellDecoration forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0
                                           green:arc4random_uniform(255)/255.0
                                            blue:arc4random_uniform(255)/255.0
                                           alpha:1];
    
    return cell;
}


static const CGFloat widthCell = 60.f; // 滤镜缩略图width
static const CGFloat widthBetweenCell = 6.f; // 滤镜缩略图间隔
static const CGFloat widthBetweenFiltersSection = 16.f; // 滤镜缩略图section间隔

#pragma mark - UICollectionViewDelegateFlowLayout

// item的size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger itemsFilters = [_filtersCollectionView numberOfItemsInSection:indexPath.item];
    CGFloat width = widthCell * itemsFilters + widthBetweenCell * (itemsFilters - 1);
    return CGSizeMake(width, 1.0f);
}

// 设置section的insets属性, 即section之间的间隔.
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if (section == 0) {
        return UIEdgeInsetsMake(0, widthBetweenFiltersSection, 0, widthBetweenFiltersSection);
    }
    return UIEdgeInsetsMake(0, 0, 0, widthBetweenFiltersSection);
}

//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
//
//}

// 每个cell之间的最小间隔
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 16.0f; // 滤镜缩略图section的间距
}

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
//
//}
//
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
//
//}


@end
