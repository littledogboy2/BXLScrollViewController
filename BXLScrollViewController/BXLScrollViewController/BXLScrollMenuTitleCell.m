//
//  BXLScrollMenuTitleCell.m
//  BXLScrollViewController
//
//  Created by 吴书敏 on 2018/4/11.
//  Copyright © 2018年 吴书敏. All rights reserved.
//

#import "BXLScrollMenuTitleCell.h"
#import "BXLScrollTheme.h"
#import <Masonry.h>

@interface BXLScrollMenuTitleCell ()

@property (nonatomic, strong, readwrite) UILabel *titleLabel;

@end

@implementation BXLScrollMenuTitleCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews {
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(self);
        make.height.mas_equalTo(13);
        make.right.mas_equalTo(self.titleLabel.mas_right);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.height.mas_equalTo(self.contentView);
    }];
}

- (void)updateConstraints {
    [super updateConstraints];
    [self.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo([self.theme menuTitleViewHeight]);
    }];
}

- (void)prepareForReuse {
    [super prepareForReuse];
    self.choosed = NO;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [self.theme menuTitleNormalFont];
        _titleLabel.textColor = [self.theme menuTitleNormalColor];
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UICollectionViewLayoutAttributes *)preferredLayoutAttributesFittingAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
    [self setNeedsLayout];
    [self layoutIfNeeded];
    CGSize size = [self.contentView systemLayoutSizeFittingSize:layoutAttributes.size]; // important
    CGRect newFrame = layoutAttributes.frame;
    newFrame.size.width = size.width;
    layoutAttributes.frame = newFrame;
    return layoutAttributes;
}

#pragma mark - setter

- (void)setTheme:(BXLScrollTheme *)theme {
    _theme = theme;
    _titleLabel.font = [self.theme menuTitleNormalFont];
    _titleLabel.textColor = [self.theme menuTitleNormalColor];
    [self layoutIfNeeded];
}

- (void)setChoosed:(BOOL)choosed {
    _choosed = choosed;
    if (_choosed) {
        _titleLabel.font = [self.theme menuTitleHighlightedFont];
        _titleLabel.textColor = [self.theme menuTitleHightlightedColor];
    } else {
        _titleLabel.font = [self.theme menuTitleNormalFont];
        _titleLabel.textColor = [self.theme menuTitleNormalColor];
    }
    [self layoutIfNeeded];
}

@end
