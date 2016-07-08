//
//  FilterCollectionViewCell.m
//  DemoCollectionView
//
//  Created by Chris Hu on 16/7/8.
//  Copyright © 2016年 icetime17. All rights reserved.
//

#import "FilterCollectionViewCell.h"

@implementation FilterCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.contentView.layer.cornerRadius = 3.0f;
    self.contentView.layer.masksToBounds = YES;
    
    _imageVIew.image = [UIImage imageNamed:@"Model.jpg"];
}

@end
