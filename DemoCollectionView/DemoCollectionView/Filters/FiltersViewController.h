//
//  FiltersViewController.h
//  DemoCollectionView
//
//  Created by Chris Hu on 16/5/1.
//  Copyright © 2016年 icetime17. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FiltersController.h"
#import "DecorationController.h"

@interface FiltersViewController : UIViewController

@property (nonatomic, strong) FiltersController *filtersController;

@property (nonatomic, strong) UICollectionView *collectionView;


@property (nonatomic, strong) DecorationController *decorationController;

@property (nonatomic, strong) UICollectionView *decorationView;

@end
