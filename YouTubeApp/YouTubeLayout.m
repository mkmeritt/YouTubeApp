//
//  YouTubeLayout.m
//  YouTubeApp
//
//  Created by Mark Meritt on 2016-07-26.
//  Copyright © 2016 Apptist. All rights reserved.
//

#import "YouTubeLayout.h"

@interface YouTubeLayout() {
    NSArray *points;
}

@end

@implementation YouTubeLayout

-(void)prepareLayout{
    [super prepareLayout];
}

-(CGSize)collectionViewContentSize{
    return self.collectionView.bounds.size;
}

-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    
    NSMutableArray *attrs = [[NSMutableArray alloc] init];
    for(NSInteger section = 0; section < self.collectionView.numberOfSections; section++) {
        for(NSInteger item = 0; item < [self.collectionView numberOfItemsInSection:section]; item++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:item inSection:section];
            [attrs addObject:[self layoutAttributesForItemAtIndexPath:indexPath]];
        }
    }
    
    return attrs;
    
}

-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
   
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    NSArray *sectionPoints = points[indexPath.section];
    CGPoint point = [(NSValue*)sectionPoints[indexPath.item] CGPointValue];
    attrs.center = point;
    attrs.size = CGSizeMake(100, 100);
    
    return attrs;
    
}

@end
