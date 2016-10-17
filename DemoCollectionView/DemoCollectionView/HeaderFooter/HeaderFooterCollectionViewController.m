//
//  HeaderFooterCollectionViewController.m
//  DemoCollectionView
//
//  Created by Chris Hu on 16/1/20.
//  Copyright © 2016年 icetime17. All rights reserved.
//

#import "HeaderFooterCollectionViewController.h"
#import "CollectionViewCell.h"
#import "CollectionReusableView.h"

@interface HeaderFooterCollectionViewController () <
    UICollectionViewDelegateFlowLayout
>

@end

@implementation HeaderFooterCollectionViewController

static NSString * const reuseCellIdentifier = @"Cell";
static NSString * const reuseHeaderIdentifier = @"Header";
static NSString * const reuseFooterIdentifier = @"Footer";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    self.collectionView.frame = CGRectMake(0, 150, self.view.frame.size.width, 400);
    self.collectionView.backgroundColor = [UIColor lightGrayColor];
    self.collectionView.bounces = NO;
    
    // Register cell classes
//    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseCellIdentifier];
    [self.collectionView registerNib:[UINib nibWithNibName:@"CollectionViewCell" bundle:nil] forCellWithReuseIdentifier:reuseCellIdentifier];
    
//    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reuseHeaderIdentifier];
    [self.collectionView registerNib:[UINib nibWithNibName:@"CollectionReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reuseHeaderIdentifier];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"CollectionReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:reuseFooterIdentifier];
    
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    [self addButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 5;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
//    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseCellIdentifier forIndexPath:indexPath];
    
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseCellIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    
    cell.imageView.image = [UIImage imageNamed:@"Model.jpg"];
    cell.labelIndexPath.text = [NSString stringWithFormat:@"%ld-%ld", (long)indexPath.section, (long)indexPath.item];
    
    return cell;
}

- (CollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    CollectionReusableView *reuseableView;
    if (kind == UICollectionElementKindSectionHeader) {
        
        reuseableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reuseHeaderIdentifier forIndexPath:indexPath];
        
        reuseableView.imageView.image = [UIImage imageNamed:@"Header.jpg"];
        reuseableView.button.titleLabel.text = @"Header Button";
        reuseableView.label.text = [NSString stringWithFormat:@"Header: %ld-%ld", (long)indexPath.section, (long)indexPath.row];
        
    } else if (kind == UICollectionElementKindSectionFooter) {
        
        reuseableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:reuseFooterIdentifier forIndexPath:indexPath];
        
        reuseableView.imageView.image = [UIImage imageNamed:@"Header.jpg"];
        reuseableView.button.titleLabel.text = @"Footer Button";
        reuseableView.label.text = [NSString stringWithFormat:@"Footer: %ld-%ld", (long)indexPath.section, (long)indexPath.row];
        
    } else {
    }
    
    return reuseableView;
}

#pragma mark <UICollectionViewDelegate>

#define kWidthFooter 300

- (CGPoint)nearestTargetOffsetForOffset:(CGPoint)offset
{
    CGFloat targetX = offset.x;
    
    CGFloat kWidthCell = self.collectionView.frame.size.width;
    
    CGFloat pageSize = kWidthCell + kWidthFooter;
    
    // 此处不能使用roundf来四舍五入，要使用floorf来下取整。
    NSInteger page = floorf(offset.x / pageSize); // 第几页
    
    if (offset.x > pageSize * page &&
        offset.x < pageSize * page + kWidthFooter / 2) {
        targetX = pageSize * page;
    } else if (offset.x > pageSize * page + kWidthFooter / 2 &&
               offset.x < pageSize * page + kWidthFooter + kWidthCell / 2) {
        targetX = pageSize * page + kWidthFooter;
    } else if (offset.x > pageSize * page + kWidthFooter + kWidthCell / 2 &&
               offset.x < pageSize * page + pageSize + kWidthFooter / 2) {
        targetX = pageSize * page + pageSize;
    }
    
    return CGPointMake(targetX, offset.y);
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    CGPoint targetOffset = [self nearestTargetOffsetForOffset:*targetContentOffset];
    targetContentOffset->x = targetOffset.x;
    targetContentOffset->y = targetOffset.y;
}

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return collectionView.frame.size;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsZero;
    
    if (section != 0) {
        return UIEdgeInsetsMake(0, 50, 0, 0);
    }
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    // 每一个section中的每一行（列）之间的间隔
    // vertical：同一个section的上下两行（另起一行）之间的最小间隔
    // horizontal：同一个section的左右两列（另起一列）之间的最小间隔
    return 0.0f;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    // 每一个section中的每一行之间的间隔
    // vertical：一行间水平（horizontal）相邻两个item之间的最小间隔
    // horizontal：一列间上下（vertical）相邻两个item之间的最小间隔
    // 而item之间实际的间隔由UIEdgeInsets及item个数共同决定（各item之间尽量保持相同间距，不够就另起一行）
    return 0.0f;
}

// 第0个section有header
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeZero;
    
    if (section != 0) {
        return CGSizeZero;
    }
    return CGSizeMake(200, 250);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeMake(kWidthFooter, CGRectGetHeight(collectionView.frame));
    
    if (section == 0) {
        return CGSizeZero;
    }
    return CGSizeMake(200, 250);
}

@end
