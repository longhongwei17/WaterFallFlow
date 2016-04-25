//
//  WaterFlowCollectionViewLayout.m
//  WaterFallFlow
//
//  Created by appleDeveloper on 16/4/25.
//  Copyright © 2016年 appleDeveloper. All rights reserved.
//

#import "WaterFlowCollectionViewLayout.h"

@interface WaterFlowCollectionViewLayout ()

@property (nonatomic, strong) NSMutableDictionary <id<NSCopying>,NSNumber *> *maxYDict;

@property (nonatomic, strong) NSMutableArray *attributeList;
@end

@implementation WaterFlowCollectionViewLayout

#pragma mark- init

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.columnCount = 2;
        self.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        self.rowSpacing = 10;
        self.columnSpacing = 10;
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.columnCount = 2;
    }
    return self;
}

- (instancetype)initWithColumnCount:(NSUInteger)columnColumn
{
    self = [super init];
    if (self) {
        self.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        self.rowSpacing = 10;
        self.columnSpacing = 10;
        self.columnCount = columnColumn;
    }
    return self;
}

+ (instancetype)waterFlowCollectiobViewLayoutWithColumn:(NSInteger)column
{
    return [[WaterFlowCollectionViewLayout alloc] initWithColumnCount:column];
}


#pragma mark - getter - setter

- (NSMutableDictionary *)maxYDict
{
    if (!_maxYDict) {
        _maxYDict = @{}.mutableCopy;
    }
    return _maxYDict;
}

- (NSMutableArray *)attributeList
{
    if (!_attributeList) {
        _attributeList = @[].mutableCopy;
    }
    return _attributeList;
}

- (void)setColumnSpacing:(NSUInteger)columnSpacing
{
    _columnSpacing = columnSpacing;
}

- (void)setRowSpacing:(NSUInteger)rowSpacing
{
    _rowSpacing = rowSpacing;
}

- (void)setSectionInset:(UIEdgeInsets )sectionInset
{
    _sectionInset = sectionInset;
}

#pragma mark - must

- (void)prepareLayout
{
    [super prepareLayout];
    
    // save max Y value
    for (NSUInteger index = 0; index < self.columnCount; index ++) {
        self.maxYDict[@(index)] = @(self.sectionInset.top);
    }
    
    // get CollectionVewi all Item
    NSInteger itemCount = [self.collectionView numberOfItemsInSection:0];
    
    // init all Attribute with per item
    
    for (NSUInteger index = 0; index < itemCount; index ++) {
        UICollectionViewLayoutAttributes *attribute = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0]];
        [self.attributeList addObject:attribute];
    }
}

- (CGSize)collectionViewContentSize
{
    __block NSNumber *maxIndex = @0;
    //遍历字典，找出最长的那一列
    [self.maxYDict enumerateKeysAndObjectsUsingBlock:^(NSNumber *key, NSNumber *obj, BOOL *stop) {
        if ([self.maxYDict[maxIndex] floatValue] < obj.floatValue) {
            maxIndex = key;
        }
    }];
    
    //collectionView的contentSize.height就等于最长列的最大y值+下内边距
    return CGSizeMake(0, [self.maxYDict[maxIndex] floatValue] + self.sectionInset.bottom);
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    CGFloat collectionViewWidth = CGRectGetWidth(self.collectionView.frame);
    
    // cal itemwith
    CGFloat itemWidth = (collectionViewWidth - self.sectionInset.left - self.sectionInset.right - (self.columnCount - 1) * self.columnSpacing)/self.columnCount;
    
    
    // get Item Height  from delegate;
    CGFloat itemHeight = 0.f;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(waterViewFlowLayout:itemHeightForIndexPath:)]) {
        itemHeight = [self.delegate waterViewFlowLayout:self itemHeightForIndexPath:indexPath];
    }
    
    // get shortest item column
    __block NSNumber *minIndex = @0;
    [self.maxYDict enumerateKeysAndObjectsUsingBlock:^(id<NSCopying>  _Nonnull key, NSNumber * _Nonnull obj, BOOL * _Nonnull stop) {
        if ([[self.maxYDict objectForKey:minIndex] floatValue] > obj.floatValue) {
            minIndex = (NSNumber *)key;
        }
    }];
    
    // get shortest item x
    CGFloat itemX = self.sectionInset.left + (self.columnSpacing + itemWidth) *minIndex.floatValue;
    // get shortest item y
    CGFloat itemY = self.maxYDict[minIndex].floatValue + self.rowSpacing;
    
    // now frame
    attributes.frame = CGRectMake(itemX, itemY, itemWidth, itemHeight);
    
    // update maxY
    
    self.maxYDict[minIndex] = @(CGRectGetMaxY( attributes.frame));
    
    return attributes;
}

- (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return self.attributeList;
}

@end
