//
//  FiltersController.m
//  DemoCollectionView
//
//  Created by Chris Hu on 16/5/1.
//  Copyright © 2016年 icetime17. All rights reserved.
//

#import "FiltersController.h"

#define CountSection    5

@implementation FiltersController

// UICollectionViewDelegate 继承自 UIScrollViewDelegate
#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    NSLog(@"%s", __func__);
    NSLog(@"offset : %@", NSStringFromCGPoint(scrollView.contentOffset));
    
    if (_filtersControllerDelegate && [_filtersControllerDelegate respondsToSelector:@selector(FiltersControllerDelegate:scrollViewDidScroll:)]) {
        [_filtersControllerDelegate FiltersControllerDelegate:self scrollViewDidScroll:scrollView];
    }
}

#pragma mark - UICollectionViewDataSource

//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return CountSection;
}

// 每个Section中的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSInteger random = arc4random_uniform(7);
    if (random < 3) {
        random = 3;
    }
    return random;
}

- (FilterCollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FilterCollectionViewCell *cell = (FilterCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:FilterCELL forIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0
                                                       green:arc4random_uniform(255)/255.0
                                                        blue:arc4random_uniform(255)/255.0
                                                       alpha:1];
    
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout

// item的size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(60.0f, 80.0f);
}

// 设置section的insets属性, 即section之间的间隔.
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if (section == 0) {
        return UIEdgeInsetsMake(0, 16, 0, 16);
    }
    return UIEdgeInsetsMake(0, 0, 0, 16);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    // 相邻两行或两列之间的间隔。
    // vertical：同一个section的上下两行（另起一行）之间的最小间隔
    // horizontal：同一个section的左右两列（另起一列）之间的最小间隔
    return 6.0f;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    // 相邻两个Item之间的间隔。
    // vertical：一行间水平（horizontal）相邻两个item之间的最小间隔
    // horizontal：一列间上下（vertical）相邻两个item之间的最小间隔
    // 而item之间实际的间隔由UIEdgeInsets及item个数共同决定（各item之间尽量保持相同间距，不够就另起一行）
    return 0.0f;
}

// header
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeZero;
}

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
//
//}

@end
