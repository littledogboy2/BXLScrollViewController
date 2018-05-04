//
//  BXLScrollMenuView.m
//  BXLScrollViewController
//
//  Created by 吴书敏 on 2018/4/11.
//  Copyright © 2018年 吴书敏. All rights reserved.
//
#import "BXLScrollMenuView.h"
#import "BXLScrollContentView.h"
#import "BXLScrollMenuTitleCell.h"
#import <Masonry.h>

static NSString * const kTitleCellIdentifier = @"kTitleCellIdentifier";
static NSString * const kRegisterCellIdentifier = @"kRegisterCellIdentifier_";


@interface BXLScrollMenuView () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong, readwrite) UIView *scrollLine;
@property (nonatomic, strong, readwrite) UIView *bottomLine;
@property (nonatomic, strong) NSIndexPath *lastSelectedIndexPath;
@property (nonatomic, strong) NSIndexPath * selectedIndexPath;
@property (nonatomic, strong) BXLScrollTheme *scrollTheme;

@property (nonatomic, assign) CGFloat prepareToScrollX;
@property (nonatomic, assign) CGFloat destinationToScrollX;
@property (nonatomic, assign) CGFloat prepareScrollLineWidth;
@property (nonatomic, assign) CGFloat destinationScrollLineWidth;
@property (nonatomic, assign) CGFloat prepareScrollLineCenterX;
@property (nonatomic, assign) CGFloat destinationScrollLineCenterX;
@property (nonatomic, assign) CGFloat latestContentSizeWidth;

@property (nonatomic, assign) BOOL scrollAgainFlag;
@property (nonatomic, assign) BOOL updateScrollLineCenterXFlag;
@property (nonatomic, assign) BOOL updateScrollLineWidthFlag;
@end

@implementation BXLScrollMenuView

#pragma mark - Lifecycle

- (instancetype)initWithFrame:(CGRect)frame scrollTheme:(BXLScrollTheme *)scrollTheme {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.minimumInteritemSpacing = (30 / 41.0) * scrollTheme.menuViewHeight;
    flowLayout.minimumLineSpacing = scrollTheme.menuTitleHorizonSpacing;
    flowLayout.estimatedItemSize = CGSizeMake(50, scrollTheme.menuTitleViewHeight);
    flowLayout.sectionInset = scrollTheme.menuTitleViewMargin;
    
    self = [super initWithFrame:frame collectionViewLayout:flowLayout];
    if (self) {
        self.backgroundColor = scrollTheme.menuViewBGColor;
        self.showsHorizontalScrollIndicator = NO;
        self.dataSource = self;
        self.delegate = self;
        self.backgroundView = [[UIView alloc] init];
        self.backgroundView.backgroundColor = scrollTheme.menuViewBGColor;
        [self registerClass:[BXLScrollMenuTitleCell class] forCellWithReuseIdentifier:kTitleCellIdentifier];
        self.scrollTheme = scrollTheme;
        self.selectedIndexPath = [NSIndexPath indexPathForItem:0 inSection:0];
        self.lastSelectedIndexPath = self.selectedIndexPath;
        self.scrollAgainFlag = NO;
        self.updateScrollLineCenterXFlag = NO;
        self.updateScrollLineWidthFlag = NO;
        [self setupSubviews];
    }
    return self;
}


- (void)setupSubviews {
    [self.scrollLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).offset(self.scrollTheme.menuViewHeight - self.scrollTheme.menuScrollLineHeight); // bottom is not work, I don't know why.
        make.centerX.mas_equalTo(self.mas_left).offset(0);
        make.width.mas_equalTo(0);
        make.height.mas_equalTo(self.scrollTheme.menuScrollLineHeight);
    }];
    
    
    CGFloat bottomLineTop = self.scrollTheme.menuViewHeight - self.scrollTheme.menuBottomLineHeight;
    [self.bottomLine mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.backgroundView);
        make.top.mas_equalTo(self.backgroundView).offset(bottomLineTop);
        make.height.mas_equalTo(self.scrollTheme.menuBottomLineHeight);
    }];
}

- (void)updateConstraints {
    [super updateConstraints];
    [self updateScrollLineConstraintsOfIndexPath:self.selectedIndexPath];
}

#pragma mark - Private

- (void)updateCellOfIndexPath:(NSIndexPath *)indexPath {
    NSIndexPath *lastIndexPath = self.lastSelectedIndexPath;
    BXLScrollMenuTitleCell *lastCell = (BXLScrollMenuTitleCell *)[self cellForItemAtIndexPath:lastIndexPath];
    lastCell.choosed = NO;
    
    BXLScrollMenuTitleCell *cell = (BXLScrollMenuTitleCell *)[self cellForItemAtIndexPath:indexPath];
    cell.choosed = YES;
}

- (void)updateScrollLineConstraintsOfIndexPath:(NSIndexPath *)indexPath {
    CGFloat scrollLineCenterX = [self scrollLineCenterXOfIndexPath:indexPath];
    self.prepareScrollLineCenterX = scrollLineCenterX;
    CGFloat scrollLineWidth = [self scrollLineWidthOfIndexPath:indexPath];
    self.prepareScrollLineWidth = scrollLineWidth;
    [self.scrollLine mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_left).offset(scrollLineCenterX);
        make.width.mas_equalTo(scrollLineWidth);
    }];
}

- (void)updateScrollLineWithDesCenterX:(CGFloat)desCenterX desWidth:(CGFloat)desWidth {
    [self.scrollLine mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_left).offset(desCenterX);
        make.width.mas_equalTo(desWidth);
    }];
}

- (CGFloat)scrollLineCenterXOfIndexPath:(NSIndexPath *)indexPath {
    CGFloat cellCenterX = [self cellCenterOfIndexPath:indexPath].x;
    return cellCenterX;
}

- (CGFloat)scrollLineWidthOfIndexPath:(NSIndexPath *)indexPath {
    CGRect cellFrame = [self cellFrameOfIndexPath:indexPath];
    CGFloat cellWidth = cellFrame.size.width;
    CGFloat scrollLineWidth = cellWidth + 2 * self.scrollTheme.menuScrollLineBeyondWidth;
    return scrollLineWidth;
}

- (CGRect)cellFrameOfIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell * cell = [self collectionView:self cellForItemAtIndexPath:indexPath];
    CGRect cellFrame = [self convertRect:cell.frame toView:self];
    return cellFrame;
}

- (CGPoint)cellCenterOfIndexPath:(NSIndexPath *)indexPath {
    CGRect cellFrame = [self cellFrameOfIndexPath:indexPath];
    CGFloat cellX = cellFrame.origin.x;
    CGFloat cellWidth = cellFrame.size.width;
    CGFloat cellCenterX = cellX + cellWidth / 2.0;
    CGPoint center = CGPointMake(cellCenterX, cellFrame.origin.y
                                 );
    return center;
}

- (CGFloat)scrollToXOfSelectedIndexPath:(NSIndexPath *)indexPath {
    CGPoint cellCenter = [self cellCenterOfIndexPath:indexPath];
    CGFloat viewWidth = self.frame.size.width;
    CGFloat viewHalfWidth = viewWidth / 2.0;
    CGFloat scrollToX = cellCenter.x - viewHalfWidth;
    return scrollToX;
}

- (void)collectionView:(UICollectionView *)collectionView  scrollToXOfSelectedIndexPath:(NSIndexPath *)indexPath {
    CGPoint cellCenter = [self cellCenterOfIndexPath:indexPath];
    CGFloat viewWidth = self.frame.size.width;
    CGFloat viewHalfWidth = viewWidth / 2.0;
    CGFloat scrollToX = cellCenter.x - viewHalfWidth;
    self.prepareToScrollX = scrollToX;
    if (scrollToX <= 0) {
        [collectionView setContentOffset:CGPointZero animated:YES];
    } else if (scrollToX >= self.contentSize.width - self.bounds.size.width) {
        [collectionView setContentOffset:CGPointMake(self.contentSize.width - viewWidth, 0) animated:YES];
    } else {
        [collectionView setContentOffset:CGPointMake(scrollToX, 0) animated:YES];
    }
}

#pragma mark - <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.menuTitles.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = self.registCellIdentifier.length > 0 ? self.registCellIdentifier : kTitleCellIdentifier;
    BXLScrollMenuTitleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.theme = self.scrollTheme;
    cell.titleLabel.text = self.menuTitles[indexPath.item];
    if (indexPath.item == self.selectedIndexPath.item) { // 默认选中 cell
        cell.choosed = YES;
    }

    return cell;
}

#pragma mark - <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    self.selectedIndexPath = indexPath;
    [self collectionView:collectionView scrollToXOfSelectedIndexPath:indexPath];
    [self updateCellOfIndexPath:indexPath];
    [self updateScrollLineConstraintsOfIndexPath:indexPath];
    self.lastSelectedIndexPath = self.selectedIndexPath;

    if (self.scrollDelegate && [self.scrollDelegate respondsToSelector:@selector(bxlScrollMenuView:didSelectItemAtIndexPath:)]) {
        [self.scrollDelegate bxlScrollMenuView:self didSelectItemAtIndexPath:indexPath];
    }
}

#pragma mark - <UIScrollDelegate>
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    self.destinationToScrollX = [self scrollToXOfSelectedIndexPath:self.selectedIndexPath];
    self.destinationScrollLineCenterX = [self scrollLineCenterXOfIndexPath:self.selectedIndexPath];
    self.destinationScrollLineWidth = [self scrollLineWidthOfIndexPath:self.selectedIndexPath];
    
    BOOL isContentSizeChange = self.latestContentSizeWidth != scrollView.contentSize.width;
    
    BOOL isScrollXChange = self.destinationToScrollX != self.prepareToScrollX && self.scrollAgainFlag == NO;
    if (isScrollXChange || isContentSizeChange) {
        self.scrollAgainFlag = YES;
        self.prepareToScrollX = self.destinationToScrollX;
        
        if (self.destinationToScrollX >= scrollView.contentSize.width - scrollView.bounds.size.width) {
            [scrollView setContentOffset:CGPointMake(scrollView.contentSize.width - scrollView.bounds.size.width, 0) animated:YES];
        } else if (self.destinationToScrollX < 0) {
            // just do nothing
        } else {
            [scrollView setContentOffset:CGPointMake(self.destinationToScrollX, 0) animated:YES];
        }
    }
    
    BOOL isLineCenterXChange = self.destinationScrollLineCenterX != self.prepareScrollLineCenterX && self.updateScrollLineCenterXFlag == NO;
    if (isLineCenterXChange || isContentSizeChange) {
        self.updateScrollLineCenterXFlag = YES;
        self.prepareScrollLineCenterX = self.destinationToScrollX;
        
        [self.scrollLine mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_left).offset(self.destinationScrollLineCenterX);
        }];
    }
    
    BOOL isLineWidthChange = self.destinationScrollLineWidth != self.prepareScrollLineWidth && self.updateScrollLineWidthFlag == NO;
    if (isLineWidthChange || isContentSizeChange) {
        self.updateScrollLineWidthFlag = YES;
        self.prepareScrollLineWidth = self.destinationScrollLineWidth;
        // Update latestContentSizeWidth after ScrollX, LineCenterX,
        // ScrollLineWidth have updated.
        self.latestContentSizeWidth = scrollView.contentSize.width;
        
        [self.scrollLine mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_offset(self.destinationScrollLineWidth);
        }];
    }
    
    if (scrollView.contentOffset.x == self.destinationToScrollX) {
        self.scrollAgainFlag = NO;
        self.updateScrollLineCenterXFlag = NO;
        self.updateScrollLineWidthFlag = NO;
    }
}

#pragma mark - <BXLScrollContentViewDelegate>

- (void)bxlScrollContentViewDidEndDecelerating:(NSIndexPath *)indexPath {
    [self collectionView:self didSelectItemAtIndexPath:indexPath];
}

- (void)bxlScrollContentViewDidScroll:(BXLScrollContentView *)contentView {
    // 获取百分比偏移量
//    NSInteger currentPage = contentView.contentOffset.x /
    CGFloat percent = contentView.contentOffset.x / contentView.contentSize.width;
    CGPoint velocity = [contentView.panGestureRecognizer velocityInView:contentView];
}


#pragma mark - Setter

- (void)setMenuTitles:(NSArray<NSString *> *)menuTitles {
    _menuTitles = [menuTitles copy];
    [self reloadData];
    [self collectionView:self scrollToXOfSelectedIndexPath:self.selectedIndexPath];
}

#pragma mark - Lazy Load

- (UIView *)scrollLine {
    if (!_scrollLine) {
        _scrollLine = [[UIView alloc] initWithFrame:CGRectZero];
        _scrollLine.backgroundColor = [self.scrollTheme menuScrollLineColor];
        [self addSubview:_scrollLine];
    }
    return _scrollLine;
}

- (UIView *)bottomLine {
    if (!_bottomLine) {
        _bottomLine = [[UIView alloc] initWithFrame:CGRectZero];
        _bottomLine.backgroundColor = [self.scrollTheme menuBottomLineColor];
        [self.backgroundView addSubview:_bottomLine];
    }
    return _bottomLine;
}

@end
