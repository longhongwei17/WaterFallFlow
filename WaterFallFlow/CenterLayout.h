//
//  CenterLayout.h
//  LayoutTest
//
//  Created by hongweilong on 2017/9/26.
//  Copyright © 2017年 hongweilong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CenterLayout : UICollectionViewFlowLayout

+ (instancetype)initWithItemSize:(CGSize)itemSize
                    sectionInset:(UIEdgeInsets)sectionSet
         minimumInteritemSpacing:(CGFloat)minimumInteritemSpacing;

@end
