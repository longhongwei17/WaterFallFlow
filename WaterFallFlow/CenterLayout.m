//
//  CenterLayout.m
//  LayoutTest
//
//  Created by hongweilong on 2017/9/26.
//  Copyright © 2017年 hongweilong. All rights reserved.
//

#import "CenterLayout.h"

#define MainSize [[UIScreen mainScreen] bounds].size

@interface CenterLayout()

@property (nonatomic, strong) NSMutableArray <UICollectionViewLayoutAttributes *> *attributesList;

@end

@implementation CenterLayout

+ (instancetype)initWithItemSize:(CGSize)itemSize
                    sectionInset:(UIEdgeInsets)sectionSet
         minimumInteritemSpacing:(CGFloat)minimumInteritemSpacing
{
    CenterLayout *layout = [CenterLayout init];
    layout.itemSize = itemSize;
    layout.sectionInset = sectionSet;
    layout.minimumInteritemSpacing = minimumInteritemSpacing;
    return layout;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self= [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    self.minimumInteritemSpacing = 10;
    self.sectionInset = UIEdgeInsetsZero;
    self.itemSize = CGSizeMake(50, 100);
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
}

- (void)prepareLayout
{
    [super prepareLayout];
    
    NSInteger counter = [self.collectionView numberOfItemsInSection:0];
    NSLog(@"now frame===%@",NSStringFromCGRect(self.collectionView.frame));
    
    self.attributesList = [NSMutableArray array];
    
    for (NSInteger index = 0; index != counter; index ++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];
        UICollectionViewLayoutAttributes *attribute = [self layoutAttributesForItemAtIndexPath:indexPath];
        [self.attributesList addObject:attribute];
    }
}

- (CGSize)collectionViewContentSize
{
    NSInteger counter = [self.collectionView numberOfItemsInSection:0];
    return CGSizeMake(self.itemSize.width * counter + 10 * (counter - 1) , self.itemSize.height);
}

- (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return self.attributesList;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *attribute = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    CGFloat deviceWidth = MainSize.width;
    CGFloat needCount = deviceWidth / (self.itemSize.width + self.minimumInteritemSpacing);
    NSInteger counter = [self.collectionView numberOfItemsInSection:0];
    if (counter > needCount) {
        CGFloat left = indexPath.item * (self.itemSize.width + self.minimumInteritemSpacing);
        CGFloat top = 0.f;
        CGRect frame = CGRectMake(left, top, self.itemSize.width, self.itemSize.height);
        attribute.frame = frame;
    } else {
        CGFloat contentSizeWidth = counter * self.itemSize.width + (counter - 1 ) * self.minimumInteritemSpacing;
        CGFloat offsetX = (deviceWidth - contentSizeWidth) / 2;
        attribute.frame = CGRectMake(offsetX + indexPath.item * (self.itemSize.width + self.minimumInteritemSpacing) , 0, self.itemSize.width, self.itemSize.height);
    }
    return attribute;
}

@end
