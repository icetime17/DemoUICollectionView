//
//  CollectionReusableView.h
//  DemoCollectionView
//
//  Created by Chris Hu on 16/1/20.
//  Copyright © 2016年 icetime17. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  Base UICollectionReusableView
 */
@interface CollectionReusableView : UICollectionReusableView

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UIButton *button;

@property (weak, nonatomic) IBOutlet UILabel *label;

@end
