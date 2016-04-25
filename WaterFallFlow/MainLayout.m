//
//  MainLayout.m
//  WaterFallFlow
//
//  Created by appleDeveloper on 16/4/25.
//  Copyright © 2016年 appleDeveloper. All rights reserved.
//

#import "MainLayout.h"

#define MainSize [[UIScreen mainScreen] bounds].size

@interface MainLayout ()

@property (nonatomic) NSUInteger perNumberOfPage;

@property (nonatomic) NSUInteger pageNo;

@property (nonatomic) CGFloat itemWidth;

@property (nonatomic) CGFloat itemHeight;

@property (nonatomic, strong) NSMutableArray <UICollectionViewLayoutAttributes *> *attributeList;

@end

@implementation MainLayout

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

+ (instancetype)layout
{
    return [[MainLayout alloc] init];
}

- (void)initialize
{
    self.itemSpace = 30.f;
    self.rowSpace = 30.f;
    
    self.sectionInset = UIEdgeInsetsMake(30, 20, 30, 20);
    self.perNumberOfPage = 16;
}

- (void)prepareLayout
{
    [super prepareLayout];
    
    NSInteger counter = [self.collectionView numberOfItemsInSection:0];
    
    self.pageNo = (NSUInteger)ceil(counter / (CGFloat)self.perNumberOfPage);
    
    // 计算item
    self.itemWidth = (MainSize.width - self.sectionInset.left - self.sectionInset.right - self.itemSpace * 3)/4;
    self.itemHeight = self.itemWidth + 30;
    
    self.attributeList = [NSMutableArray array];
    
    for (NSInteger index = 0; index < counter; index ++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];
        UICollectionViewLayoutAttributes  *attribute = [self layoutAttributesForItemAtIndexPath:indexPath];
        [self.attributeList addObject:attribute];
    }
}

- (CGSize)collectionViewContentSize
{
    return CGSizeMake(MainSize.width * self.pageNo, 0);
}

- (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return self.attributeList;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *attribute = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    // 当前的页数
    NSUInteger curPageNo = indexPath.item / self.perNumberOfPage;
    
    // 当前页数 对应的Item
    NSUInteger curPageItem = indexPath.item % self.perNumberOfPage;
    
    // 当前的行数
    NSUInteger curLine = curPageItem / 4;
    
    // 当前的列数
    NSUInteger curItem = curPageItem % 4;
    
    CGFloat itemX = [self showOffsetXWithPageNo:curPageNo] + [self curItemXWithItemIndex:curItem];
    
    CGFloat itemY = [self curItemYWithItemIndex:curLine];
    
    attribute.frame = CGRectMake(itemX, itemY, self.itemWidth, self.itemHeight);
    return attribute;
}

- (CGFloat)showOffsetXWithPageNo:(NSUInteger)pageNo
{
    return MainSize.width * pageNo;
}

- (CGFloat)curItemXWithItemIndex:(NSUInteger)itemIndex
{
    return (self.itemWidth + self.itemSpace) * itemIndex + self.sectionInset.left;
}

- (CGFloat)curItemYWithItemIndex:(NSInteger)itemIndex
{
    return (self.itemHeight + self.rowSpace) * itemIndex + self.sectionInset.top;
}

@end
