//
//  CollectionViewCell.h
//  DemoCollectionView
//
//  Created by Chris Hu on 16/1/20.
//  Copyright © 2016年 icetime17. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *labelIndexPath;

@end
