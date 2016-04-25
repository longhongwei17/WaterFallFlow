//
//  ViewController.m
//  WaterFallFlow
//
//  Created by appleDeveloper on 16/4/25.
//  Copyright © 2016年 appleDeveloper. All rights reserved.
//

#import "ViewController.h"
#import "MyCell.h"
#import "WaterFlowCollectionViewLayout.h"
#import "ShowLayout.h"
#import "NextViewController.h"

@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,WaterFlowCollectionViewLayoutDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray <NSNumber *>*dataList;

@end

static NSString * const cellIdentifier = @"cellIdentifier";

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initUI];
    
}

- (void)initUI
{
//    WaterFlowCollectionViewLayout *waterFlowLayout = [WaterFlowCollectionViewLayout waterFlowCollectiobViewLayoutWithColumn:3];
//  
//    waterFlowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
//    waterFlowLayout.columnSpacing = 10;
//    waterFlowLayout.rowSpacing = 10;
//    waterFlowLayout.delegate = self;
//    self.collectionView.collectionViewLayout = waterFlowLayout;
    
    ShowLayout *layout = [ShowLayout showLayout];
    self.collectionView.collectionViewLayout = layout;
    
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([MyCell class]) bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"MyCell"];
    self.collectionView.alwaysBounceVertical = YES;
    
}

- (NSMutableArray *)dataList
{
    if (!_dataList) {
        _dataList = [NSMutableArray array];
        for (NSInteger index = 0; index < 20; index ++) {
            NSUInteger number = arc4random_uniform(100) + 100;
            [_dataList addObject:@(number)];
        }
    }
    return _dataList;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MyCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MyCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];
    
//    NSLog(@"cell.frame=====%@",NSStringFromCGRect(cell.frame));
    return cell;
}

- (CGFloat)waterViewFlowLayout:(WaterFlowCollectionViewLayout *)waterViewFlowLayout itemHeightForIndexPath:(NSIndexPath *)indexPath
{
    return [self.dataList[indexPath.item] floatValue];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"item====%@",@(indexPath.item));
    
    NextViewController *nextVC = [[NextViewController alloc] initWithNibName:NSStringFromClass([NextViewController class]) bundle:nil];
    [self.navigationController pushViewController:nextVC animated:YES];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
