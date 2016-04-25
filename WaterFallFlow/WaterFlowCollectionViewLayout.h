//
//  WaterFlowCollectionViewLayout.h
//  WaterFallFlow
//
//  Created by appleDeveloper on 16/4/25.
//  Copyright © 2016年 appleDeveloper. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WaterFlowCollectionViewLayoutDelegate ;

@interface WaterFlowCollectionViewLayout : UICollectionViewLayout

@property (nonatomic) NSUInteger columnCount;

@property (nonatomic) NSUInteger columnSpacing;

@property (nonatomic) NSUInteger rowSpacing;

@property (nonatomic) UIEdgeInsets sectionInset;

@property (nonatomic, weak) id<WaterFlowCollectionViewLayoutDelegate> delegate;

#pragma mark - init
- (instancetype)initWithColumnCount:(NSUInteger)columnColumn;
+ (instancetype)waterFlowCollectiobViewLayoutWithColumn:(NSInteger)column;
@end

@protocol WaterFlowCollectionViewLayoutDelegate <NSObject>

- (CGFloat)waterViewFlowLayout:(WaterFlowCollectionViewLayout *)waterViewFlowLayout itemHeightForIndexPath:(NSIndexPath *)indexPath;
@end


