//
//  MyScrollMemuTitleCell.m
//  AGScrollViewController
//
//  Created by 吴书敏 on 2018/5/3.
//  Copyright © 2018年 吴书敏. All rights reserved.
//

#import "MyScrollMemuTitleCell.h"
#import <Masonry.h>

@interface MyScrollMemuTitleCell ()

@property (nonatomic, strong) UIImageView *iconImageview;

@end

@implementation MyScrollMemuTitleCell

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
        make.right.mas_equalTo(self.iconImageview.mas_right);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.mas_equalTo(self.contentView);
    }];
    
    [self.iconImageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel.mas_right).offset(10);
        make.centerY.mas_equalTo(self.titleLabel);
        make.height.mas_equalTo(13);
        make.width.mas_equalTo(13);
    }];
}

- (void)updateConstraints {
    [super updateConstraints];
    [self.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo([self.theme menuTitleViewHeight]);
    }];
}

- (UIImageView *)iconImageview {
    if (!_iconImageview) {
        _iconImageview = [[UIImageView alloc] initWithFrame:CGRectZero];
        _iconImageview.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:_iconImageview];
    }
    return _iconImageview;
}





@end
