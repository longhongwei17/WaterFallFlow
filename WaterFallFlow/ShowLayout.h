//
//  ShowLayout.h
//  WaterFallFlow
//
//  Created by appleDeveloper on 16/4/25.
//  Copyright © 2016年 appleDeveloper. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShowLayout : UICollectionViewLayout

@property (nonatomic) CGFloat rowSpacing;

@property (nonatomic) CGFloat itemSpacing;

@property (nonatomic) UIEdgeInsets sectionInset;

@property (nonatomic, strong) NSMutableArray <UICollectionViewLayoutAttributes *> *attributesList;

@property (nonatomic) CGFloat  maxContentY;


+ (instancetype)showLayout;

@end
