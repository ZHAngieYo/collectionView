//
//  CollectionViewFlowLayout.m
//  CollectionView
//
//  Created by zhaohang on 2018/5/30.
//  Copyright © 2018年 HangZhao. All rights reserved.
//

#import "CollectionViewFlowLayout.h"

@implementation CollectionViewFlowLayout

- (instancetype)init{
    self = [super init];
    if (self) {
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.itemSize = CGSizeMake(100, 100);
        self.minimumLineSpacing = 100;
        self.sectionInset = UIEdgeInsetsMake(0, 100, 0, 100);
    }
    return self;
}

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity{
    CGRect oldRect;
    oldRect.origin = proposedContentOffset;
    oldRect.size = self.collectionView.frame.size;
    //获取该范围的所有属性
    NSArray *array = [self layoutAttributesForElementsInRect:oldRect];
    //中点
    CGFloat minOffset = MAXFLOAT;
    CGFloat centerX = proposedContentOffset.x + self.collectionView.frame.size.width/2;
    
    //边界判断
    if ((self.collectionView.frame.size.width+proposedContentOffset.x >= self.collectionView.contentSize.width + self.collectionView.contentInset.right) ||(proposedContentOffset.x <= - self.collectionView.contentInset.left) ) {
        return [super targetContentOffsetForProposedContentOffset:proposedContentOffset withScrollingVelocity:velocity];
    }
    //遍历取出最小的中点差
    for (UICollectionViewLayoutAttributes *attribute in array) {
        if (ABS(attribute.center.x - centerX ) < ABS(minOffset)) {
            minOffset = attribute.center.x - centerX ;
        }
    }
    return CGPointMake(proposedContentOffset.x + minOffset, proposedContentOffset.y);
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return YES;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    CGRect visibleRect;
    visibleRect.origin = self.collectionView.contentOffset;
    visibleRect.size = self.collectionView.frame.size;
    //继承父类，默认的cell属性，
    NSArray *array = [super layoutAttributesForElementsInRect:visibleRect];
    
    CGFloat centerX = self.collectionView.frame.size.width/2 + self.collectionView.contentOffset.x;
    
    for (UICollectionViewLayoutAttributes *attrs in array) {
        if (!CGRectIntersectsRect(visibleRect, attrs.frame)) {
            continue;
        }
        CGFloat itemCenterX = attrs.center.x;
        
        CGFloat scale = 1+(1-ABS(itemCenterX - centerX)/self.collectionView.frame.size.width)*0.6;
        
        attrs.transform3D = CATransform3DMakeScale(scale, scale, 1.0);
    }
    return array;
}

@end
