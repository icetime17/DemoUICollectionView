//
//  FiltersController.h
//  DemoCollectionView
//
//  Created by Chris Hu on 16/5/1.
//  Copyright © 2016年 icetime17. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "FilterCollectionViewCell.h"


#define FilterCELL    @"FilterCell"

@protocol FiltersControllerDelegate;


@interface FiltersController : NSObject <

    UICollectionViewDataSource,
    UICollectionViewDelegate,
    UICollectionViewDelegateFlowLayout

>

@property (nonatomic, weak) UICollectionView *collectionView;

@property (nonatomic, weak) id<FiltersControllerDelegate> filtersControllerDelegate;

@end


@protocol FiltersControllerDelegate <NSObject>

- (void)FiltersControllerDelegate:(FiltersController *)filtersController scrollViewDidScroll:(UIScrollView *)scrollView;

@end
