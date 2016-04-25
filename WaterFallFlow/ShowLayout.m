//
//  ShowLayout.m
//  WaterFallFlow
//
//  Created by appleDeveloper on 16/4/25.
//  Copyright © 2016年 appleDeveloper. All rights reserved.
//

#import "ShowLayout.h"

@interface ShowLayout ()

@property (nonatomic) CGFloat itemWidth;

@property (nonatomic) CGFloat itemBigHeight;

@property (nonatomic) CGFloat itemSmallHeight;

@end

@implementation ShowLayout

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initialize];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initialize];
    }
    return self;
}

+ (instancetype)showLayout
{
    return [[ShowLayout alloc] init];
}

- (void)initialize
{
    self.rowSpacing = 10.f;
    self.itemSpacing = 10.f;
    self.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
}

- (void)prepareLayout
{
    [super prepareLayout];
    
    self.maxContentY = 10;
    self.attributesList = [NSMutableArray array];
    
    CGFloat collectionViewWidth = CGRectGetWidth(self.collectionView.frame);
    
    self.itemWidth = (collectionViewWidth - self.sectionInset.left - self.sectionInset.right - self.itemSpacing)/2;
    self.itemBigHeight = self.itemWidth;
    self.itemSmallHeight = (self.itemWidth - self.rowSpacing)/2;

    NSUInteger itemCount = [self.collectionView numberOfItemsInSection:0];
    
    for (NSInteger index = 0; index < itemCount; index ++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0    ];
        UICollectionViewLayoutAttributes *attribute = [self layoutAttributesForItemAtIndexPath:indexPath];
        [self.attributesList addObject:attribute];
    }
}

- (CGSize)collectionViewContentSize
{
    return CGSizeMake(0, self.maxContentY);
}

- (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return self.attributesList;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *attribute = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    NSInteger count = indexPath.item;
    
    NSInteger numberCount = count / 6;
    
    NSInteger index = count % 6;
    
    CGFloat itemX;
    CGFloat itemY;
    
    CGFloat itemHeight;
    
    switch (index) {
        case 0:
        {
            itemX = self.sectionInset.left;
            itemY = [self allCountHeightWithNumberCount:numberCount];
            itemHeight = self.itemBigHeight;
            self.maxContentY = itemY + self.itemWidth + self.sectionInset.bottom;
        }
            break;
        case 1:
        {
            itemX = self.sectionInset.left + self.itemWidth + self.itemSpacing;
            itemY = [self allCountHeightWithNumberCount:numberCount];
            itemHeight = self.itemSmallHeight;
        }
            break;
        case 2:
        {
            itemX = self.sectionInset.left + self.itemWidth + self.itemSpacing;
            itemY = [self allCountHeightWithNumberCount:numberCount] + self.rowSpacing + self.itemSmallHeight;
            itemHeight = self.itemSmallHeight;
        }
            break;
        case 3:
        {
            itemX = self.sectionInset.left;
            itemY = [self allCountHeightWithNumberCount:numberCount] + self.rowSpacing + self.itemBigHeight;
            itemHeight = self.itemSmallHeight;
        }
            break;
        case 4:
        {
            itemX = self.sectionInset.left;
            itemY = [self allCountHeightWithNumberCount:numberCount] + self.rowSpacing * 2 + self.itemBigHeight + self.itemSmallHeight;
            itemHeight = self.itemSmallHeight;
            self.maxContentY = itemY + self.itemSmallHeight + self.sectionInset.bottom;
        }
            break;
        case 5:
        {
            itemX = self.sectionInset.left + self.itemWidth + self.itemSpacing;
            itemY = [self allCountHeightWithNumberCount:numberCount] + self.rowSpacing + self.itemBigHeight ;
            itemHeight = self.itemBigHeight;
        }
            break;
            
        default:
            break;
    }
    
    attribute.frame = CGRectMake(itemX, itemY, self.itemWidth, itemHeight);
    
    return attribute;
}

- (CGFloat)allCountHeightWithNumberCount:(NSInteger)numberCount
{
    CGFloat height = self.sectionInset.top + (2 * self.itemWidth + 2* self.rowSpacing) * numberCount;
    return height;
}

@end
