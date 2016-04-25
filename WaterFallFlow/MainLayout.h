//
//  MainLayout.h
//  WaterFallFlow
//
//  Created by appleDeveloper on 16/4/25.
//  Copyright © 2016年 appleDeveloper. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainLayout : UICollectionViewLayout

@property (nonatomic) CGFloat itemSpace;

@property (nonatomic) CGFloat rowSpace;

@property (nonatomic) UIEdgeInsets sectionInset;

+ (instancetype)layout;

@end
