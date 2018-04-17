//
//  BXLScrollContentView.m
//  BXLScrollViewController
//
//  Created by 吴书敏 on 2018/4/11.
//  Copyright © 2018年 吴书敏. All rights reserved.
//

#import "BXLScrollContentView.h"
#import "BXLScrollMenuView.h"
#import <Masonry.h>


static NSString * const kBXLScrollContentCellIdentifier = @"kBXLScrollContentCellIdentifier";

@interface BXLScrollContentView () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, assign) NSInteger lastSelectedIndex;

@end

@implementation BXLScrollContentView

#pragma mark - Lifecycle

- (instancetype)initWithFrame:(CGRect)frame
                  scrollTheme:(BXLScrollTheme *)scrollTheme {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumLineSpacing = 0;
    
    self = [super initWithFrame:frame collectionViewLayout:flowLayout];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.delegate = self;
        self.dataSource = self;
        self.pagingEnabled = YES;
        self.showsHorizontalScrollIndicator = NO;
        self.scrollTheme = scrollTheme;
        self.lastSelectedIndex = 0;
        [self registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kBXLScrollContentCellIdentifier];
    }
    return self;
}

#pragma mark - <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.viewControllers.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kBXLScrollContentCellIdentifier forIndexPath:indexPath];
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    UIViewController *vc = self.viewControllers[indexPath.item];
    [cell.contentView addSubview:vc.view];
    [vc.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.width.height.mas_equalTo(cell.contentView);
    }];
    return cell;
}

#pragma mark - <UIScrollViewDelegate>

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
     if (self.scrollDelegate && [self.scrollDelegate respondsToSelector:@selector(bxlScrollContentViewDidScroll:)]) {
         [self.scrollDelegate bxlScrollContentViewDidScroll:self];
     }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (self.scrollDelegate && [self.scrollDelegate respondsToSelector:@selector(bxlScrollContentViewDidEndDecelerating:)]) {
        NSInteger pBXLe = scrollView.contentOffset.x / scrollView.frame.size.width;
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:pBXLe inSection:0];
        [self.scrollDelegate bxlScrollContentViewDidEndDecelerating:indexPath];
        self.lastSelectedIndex = pBXLe;
    }
}

#pragma mark - <UICollectionViewDelegateFlowLayout>

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return self.frame.size;
}

#pragma mark - <BXLScrollMenuViewDelegate>

- (void)bxlScrollMenuView:(BXLScrollMenuView *)menuView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat offsetX = indexPath.item * self.frame.size.width;
    if (labs(indexPath.item - self.lastSelectedIndex) > 1) {
        [self setContentOffset:CGPointMake(offsetX, 0) animated:NO];
    } else {
        [self setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    }
    self.lastSelectedIndex = indexPath.item;
}

#pragma mark - Lazy Load

- (void)setViewControllers:(NSArray<UIViewController *> *)viewControllers {
    _viewControllers = viewControllers;
    [self reloadData];
}

@end
