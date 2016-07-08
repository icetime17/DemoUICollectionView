//
//  DecorationController.h
//  DemoCollectionView
//
//  Created by Chris Hu on 16/5/1.
//  Copyright © 2016年 icetime17. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "FilterDecorationCollectionViewCell.h"

#define FilterCellDecoration    @"FilterCellDecoration"

@interface DecorationController : NSObject <

    UICollectionViewDataSource,
    UICollectionViewDelegate,
    UICollectionViewDelegateFlowLayout

>

@property (nonatomic, strong) UICollectionView *filtersCollectionView;

- (void)performScrollViewDidScroll:(UIScrollView *)scrollView;

@end
