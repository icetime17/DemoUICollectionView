//
//  FilterDecorationCollectionViewCell.h
//  DemoCollectionView
//
//  Created by Chris Hu on 16/7/8.
//  Copyright © 2016年 icetime17. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FilterDecorationCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIView *lineLeft;
@property (weak, nonatomic) IBOutlet UIView *lineRight;

@property (weak, nonatomic) IBOutlet UILabel *labelTitle;

@end
