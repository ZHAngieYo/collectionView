//
//  CollectionViewCell.m
//  CollectionView
//
//  Created by zhaohang on 2018/5/30.
//  Copyright © 2018年 HangZhao. All rights reserved.
//

#import "CollectionViewCell.h"

@implementation CollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel = [[UILabel alloc] initWithFrame:self.bounds];
        [self.titleLabel setTextAlignment:(NSTextAlignmentCenter)];
        [self.titleLabel setBackgroundColor:[UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1.0]];
        [self addSubview:self.titleLabel];
    }
    return self;
}

@end
