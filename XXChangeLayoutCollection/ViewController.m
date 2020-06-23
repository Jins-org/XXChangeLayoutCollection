//
//  ViewController.m
//  XXChangeLayoutCollection
//
//  Created by Jins on 2020/6/23.
//  Copyright © 2020 Jins-org. All rights reserved.
//

#import "ViewController.h"
#import "XXProductCell.h"

@interface ViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic) BOOL isList;
@property (nonatomic, strong) UICollectionViewFlowLayout *listLayout;
@property (nonatomic, strong) UICollectionViewFlowLayout *gridLayout;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.collectionView];
}

- (IBAction)changeListStyle:(UIBarButtonItem *)sender {
    _isList = !_isList;
    if (_isList) {
        [self.collectionView setCollectionViewLayout:self.listLayout animated:YES];
    } else {
        [self.collectionView setCollectionViewLayout:self.gridLayout animated:YES];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ListTypeDidChange" object:@(_isList)];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 100;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    XXProductCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([XXProductCell class]) forIndexPath:indexPath];
    cell.imageName = [NSString stringWithFormat:@"%ld", indexPath.item % 4];
    cell.isList = _isList;
    return cell;
}

#pragma mark - Getters

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:self.gridLayout];
        _collectionView.backgroundColor = UIColor.lightGrayColor;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[XXProductCell class] forCellWithReuseIdentifier:NSStringFromClass([XXProductCell class])];
    }
    return _collectionView;;
}

- (UICollectionViewFlowLayout *)gridLayout {
    if (!_gridLayout) {
        _gridLayout = [[UICollectionViewFlowLayout alloc] init];
        CGFloat space = 5.f;
        CGFloat width = (self.view.frame.size.width - space * 3) * 0.5;
        _gridLayout.itemSize = CGSizeMake(width, width + 75);
        _gridLayout.minimumLineSpacing = space;
        _gridLayout.minimumInteritemSpacing = space;
        _gridLayout.sectionInset = UIEdgeInsetsMake(space, space, space, space);
    }
    return _gridLayout;
}

- (UICollectionViewFlowLayout *)listLayout {
    if (!_listLayout) {
        _listLayout = [[UICollectionViewFlowLayout alloc] init];
        _listLayout.itemSize = CGSizeMake(self.view.frame.size.width, 150);
        _listLayout.minimumLineSpacing = 0.5;
        _listLayout.sectionInset = UIEdgeInsetsZero;
    }
    return _listLayout;
}

@end
