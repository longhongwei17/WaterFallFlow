//
//  NextViewController.m
//  WaterFallFlow
//
//  Created by appleDeveloper on 16/4/25.
//  Copyright © 2016年 appleDeveloper. All rights reserved.
//

#import "NextViewController.h"
#import "Cell.h"
#import "MainLayout.h"

@interface NextViewController () <UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSMutableArray <NSString *>* dataList;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@end

static NSString * const cellIdentifier = @"cellIdentifier";
@implementation NextViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    [self initUI];
}

- (void)initUI
{
    MainLayout *layout = [MainLayout layout];
    self.collectionView.collectionViewLayout = layout;
    self.collectionView.pagingEnabled = YES;
    self.collectionView.bounces = NO;
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([Cell class]) bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:NSStringFromClass([Cell class])];
}

- (NSMutableArray *)dataList
{
    if (!_dataList) {
        _dataList = [NSMutableArray array];
        for (NSInteger index = 0; index < 100; index ++) {
            [_dataList addObject:@(index).stringValue];
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
    Cell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    cell.label.text = self.dataList[indexPath.item];
    cell.backgroundColor = [UIColor purpleColor];
    
    NSLog(@"frame ====%@", NSStringFromCGRect(cell.frame));
    return cell;
}

- (void)didReceiveMemoryWarning
{
   [super didReceiveMemoryWarning];
}

@end
