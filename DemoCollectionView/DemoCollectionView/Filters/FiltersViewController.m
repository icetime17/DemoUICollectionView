//
//  FiltersViewController.m
//  DemoCollectionView
//
//  Created by Chris Hu on 16/5/1.
//  Copyright © 2016年 icetime17. All rights reserved.
//

#import "FiltersViewController.h"

@interface FiltersViewController () <
    FiltersControllerDelegate
>

@end

@implementation FiltersViewController {

    UIView *viewBackground;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    [self initCollectionView];
    
    [self initDecorationView];
    
    [self addButton];
}

- (void)initCollectionView {
    viewBackground = [[UIView alloc] initWithFrame:CGRectMake(0, 300, CGRectGetWidth(self.view.frame), 140)];
    viewBackground.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:viewBackground];
    
    
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 10, CGRectGetWidth(viewBackground.frame), 80) collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    [viewBackground addSubview:_collectionView];
    
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.bounces = NO;
    
    [_collectionView registerNib:[UINib nibWithNibName:@"FilterCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:FilterCELL];
    
    _filtersController = [[FiltersController alloc] init];
    _collectionView.dataSource = _filtersController;
    _collectionView.delegate = _filtersController;
    
    _filtersController.filtersControllerDelegate = self;
}

- (void)FiltersControllerDelegate:(FiltersController *)filtersController scrollViewDidScroll:(UIScrollView *)scrollView {
    if (_decorationView) {
//        [_decorationController performScrollViewDidScroll:scrollView];
        [_decorationView setContentOffset:scrollView.contentOffset];
    }
}

- (void)initDecorationView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    
    _decorationView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_collectionView.frame) + 10 , CGRectGetWidth(viewBackground.frame), 31) collectionViewLayout:layout];
    _decorationView.backgroundColor = [UIColor whiteColor];
    [viewBackground addSubview:_decorationView];
    
    _decorationView.showsHorizontalScrollIndicator = NO;
    _decorationView.showsVerticalScrollIndicator = NO;
    _decorationView.bounces = NO;
    
    [_decorationView registerNib:[UINib nibWithNibName:@"FilterDecorationCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:FilterCellDecoration];
    
    _decorationController = [[DecorationController alloc] init];
    _decorationController.filtersCollectionView = _collectionView;
    
    _decorationView.dataSource = _decorationController;
    _decorationView.delegate = _decorationController;
}



- (void)addButton {
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 50, self.view.frame.size.width, 50)];
    [btn setTitle:@"Back" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(actionBack:) forControlEvents:UIControlEventTouchUpInside];
    btn.layer.borderColor = [UIColor redColor].CGColor;
    btn.layer.borderWidth = 2.0f;
    [self.view addSubview:btn];
}

- (void)actionBack:(UIButton *)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
}

@end
