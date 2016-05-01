//
//  FiltersController.h
//  DemoCollectionView
//
//  Created by Chris Hu on 16/5/1.
//  Copyright © 2016年 icetime17. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


#define CELL    @"Cell"

@interface FiltersController : NSObject <

    UICollectionViewDataSource,
    UICollectionViewDelegate,
    UICollectionViewDelegateFlowLayout

>


@property (nonatomic, weak) UICollectionView *collectionView;

@end
