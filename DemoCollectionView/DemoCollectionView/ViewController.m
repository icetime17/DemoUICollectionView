//
//  ViewController.m
//  DemoCollectionView
//
//  Created by Chris Hu on 15/9/16.
//  Copyright (c) 2015年 icetime17. All rights reserved.
//

#define _CELL   @"acell"

#import "ViewController.h"
#import "CollectionViewsTableViewController.h"
#import "HeaderFooterCollectionViewController.h"
#import "FiltersViewController.h"

@interface ViewController () <
    UICollectionViewDataSource,
    UICollectionViewDelegate,
    UICollectionViewDelegateFlowLayout
>

@end


@implementation ViewController {
    
    UICollectionView *_collectionView;
    UICollectionViewFlowLayout *_layout;
    
    NSInteger _sectionCount;
    NSInteger _itemCount;
    
    UIButton *_btnDirection;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addCollectionView];
    
    [self addButton];
}

- (void)addCollectionView {
    _layout = [[UICollectionViewFlowLayout alloc] init];
    // layout的样式，也可以在UICollectionViewDelegateFlowLayout中设置
    // UICollectionView默认采取纵向排列样式，UICollectionViewScrollDirectionVertical
    // 该样式针对section而言！！！
    // section0为红色, section1为绿, section2为蓝色.
    // Vertical: section是vertical放置，而item是horizontal放置。一个section中的item在一行中放置不下，就另起一行往下放置。
    // Horizontal: section是horizontal放置，而item是vertical放置。一个section中的item在一列中放置不下，就另起一列放置。
    [_layout setScrollDirection:UICollectionViewScrollDirectionVertical];

    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 50, self.view.frame.size.width, self.view.frame.size.height - 250) collectionViewLayout:_layout];
    UIView *bgView = [[UIView alloc] initWithFrame:_collectionView.frame];
    bgView.backgroundColor = [UIColor blackColor];
    _collectionView.backgroundView = bgView;
    
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:_CELL];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.pagingEnabled = YES;
    _collectionView.bounces = NO;
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    [self.view addSubview:_collectionView];
    
    _sectionCount = 3;
    _itemCount = 10;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return _sectionCount;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _itemCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:_CELL forIndexPath:indexPath];
    switch (indexPath.section) {
        case 0:
            cell.backgroundColor = [UIColor redColor];
            break;
        case 1:
            cell.backgroundColor = [UIColor greenColor];
            break;
        case 2:
            cell.backgroundColor = [UIColor blueColor];
            break;
        default:
            break;
    }
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    // 每个item的size
    return CGSizeMake(80, 100);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    // 设置section的insets属性，即边距。
    if (section == _sectionCount - 1) {
        return UIEdgeInsetsMake(0, 0, 0, 0);
    }
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    // 最小行间距
    // vertical：同一个section的上下两行（另起一行）之间的最小间隔
    // horizontal：同一个section的左右两列（另起一列）之间的最小间隔
    return 5.0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    // 最小item间距
    // vertical：一行间水平（horizontal）相邻两个item之间的最小间隔
    // horizontal：一列间上下（vertical）相邻两个item之间的最小间隔
    // 而item之间实际的间隔由UIEdgeInsets及item个数共同决定（各item之间尽量保持相同间距，不够就另起一行）
    return 20.0;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    // vertical：section的header的height
    // horizontal：section的header的width
    if (section == _sectionCount - 1) {
        return CGSizeMake(30, 30);
    }
    return CGSizeMake(10, 10);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    // vertical：section的footer的height
    // horizontal：section的footer的width
    if (section == _sectionCount - 1) {
        return CGSizeMake(30, 30);
    }
    return CGSizeMake(10, 10);
}

#pragma mark - Buttons

- (void)addButton {
    _btnDirection = [[UIButton alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 200, self.view.frame.size.width, 50)];
    [_btnDirection setTitle:@"ScrollDirectionVertical" forState:UIControlStateNormal];
    [_btnDirection setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [_btnDirection setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [_btnDirection addTarget:self action:@selector(actionScrollDirection:) forControlEvents:UIControlEventTouchUpInside];
    _btnDirection.layer.borderColor = [UIColor redColor].CGColor;
    _btnDirection.layer.borderWidth = 2.0f;
    [self.view addSubview:_btnDirection];
    
    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 150, self.view.frame.size.width, 50)];
    [btn1 setTitle:@"UICollectionViewHeader" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [btn1 addTarget:self action:@selector(actionUICollectionViewHeader:) forControlEvents:UIControlEventTouchUpInside];
    btn1.layer.borderColor = [UIColor redColor].CGColor;
    btn1.layer.borderWidth = 2.0f;
    [self.view addSubview:btn1];
    
    UIButton *btn2 = [[UIButton alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 100, self.view.frame.size.width, 50)];
    [btn2 setTitle:@"Filters" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [btn2 addTarget:self action:@selector(actionFilters:) forControlEvents:UIControlEventTouchUpInside];
    btn2.layer.borderColor = [UIColor redColor].CGColor;
    btn2.layer.borderWidth = 2.0f;
    [self.view addSubview:btn2];
    
    UIButton *btn3 = [[UIButton alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 50, self.view.frame.size.width, 50)];
    [btn3 setTitle:@"FlowLayout" forState:UIControlStateNormal];
    [btn3 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn3 setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [btn3 addTarget:self action:@selector(actionUICollectionViewFlowLayout:) forControlEvents:UIControlEventTouchUpInside];
    btn3.layer.borderColor = [UIColor redColor].CGColor;
    btn3.layer.borderWidth = 2.0f;
    [self.view addSubview:btn3];
}

- (void)actionScrollDirection:(UIButton *)sender {
    _layout.scrollDirection = !_layout.scrollDirection;
    if (_layout.scrollDirection == UICollectionViewScrollDirectionVertical) {
        [_btnDirection setTitle:@"ScrollDirectionVertical" forState:UIControlStateNormal];
    } else {
        [_btnDirection setTitle:@"ScrollDirectionHorizontal" forState:UIControlStateNormal];
    }
}

- (void)actionUICollectionViewHeader:(UIButton *)sender {
    UICollectionViewFlowLayout *layoutHeader = [[UICollectionViewFlowLayout alloc] init];
    layoutHeader.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    HeaderFooterCollectionViewController *headerVC = [[HeaderFooterCollectionViewController alloc] initWithCollectionViewLayout:layoutHeader];
    [self presentViewController:headerVC animated:NO completion:nil];
}

- (void)actionFilters:(UIButton *)sender {
    FiltersViewController *filtersVC = [[FiltersViewController alloc] init];
    [self presentViewController:filtersVC animated:NO completion:nil];
}

- (void)actionUICollectionViewFlowLayout:(UIButton *)sender {
    CollectionViewsTableViewController *tableVC = [[CollectionViewsTableViewController alloc] init];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:tableVC];
    
    [self presentViewController:nav animated:YES completion:nil];
}

@end
