//
//  CollectionReusableView.m
//  DemoCollectionView
//
//  Created by Chris Hu on 16/1/20.
//  Copyright © 2016年 icetime17. All rights reserved.
//

#import "CollectionReusableView.h"

@implementation CollectionReusableView {

    BOOL switchOn;
}

- (void)awakeFromNib {
    // Initialization code
}

- (IBAction)buttonClicked:(UIButton *)sender {
    switchOn = !switchOn;
    if (switchOn) {
        [self.button setBackgroundImage:[UIImage imageNamed:@"on"] forState:UIControlStateNormal];
        [self.button setBackgroundImage:[UIImage imageNamed:@"on"] forState:UIControlStateHighlighted];
    } else {
        [self.button setBackgroundImage:[UIImage imageNamed:@"off"] forState:UIControlStateNormal];
        [self.button setBackgroundImage:[UIImage imageNamed:@"on"] forState:UIControlStateHighlighted];
    }
}

@end
