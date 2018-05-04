//
//  BXLScrollViewController.m
//  BXLScrollViewController
//
//  Created by 吴书敏 on 2018/4/11.
//  Copyright © 2018年 吴书敏. All rights reserved.
//

#import "BXLScrollViewController.h"
#import <Masonry.h>

static NSString * const kRegisterCellIdentifier = @"kRegisterCellIdentifier_";


@interface BXLScrollViewController ()

@property (nonatomic, strong, readwrite) BXLScrollMenuView *menuView;
@property (nonatomic, strong, readwrite) BXLScrollContentView *contentView;
@property (nonatomic, strong) NSMutableDictionary *registMenuCellDic;


@end

@implementation BXLScrollViewController

#pragma mark - Lifecycle

- (instancetype)init {
    self = [super init];
    if (self) {
        self.registMenuCellDic = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSubviews];
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupSubviews {
    [self.menuView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(self.view);
        make.height.mas_equalTo(self.scrollTheme.menuViewHeight);
    }];
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.menuView.mas_bottom);
        make.left.right.bottom.mas_equalTo(self.view);
    }];
}

- (void)registMenuCell:(Class)menuCellClass {
    NSString *cellIdentifier = [kRegisterCellIdentifier stringByAppendingString:NSStringFromClass(menuCellClass)];
    [self.registMenuCellDic setObject:menuCellClass forKey:cellIdentifier];
}

- (void)loadData {
    self.menuView.menuTitles = self.menuTitles;
    self.contentView.viewControllers = self.viewControllers;
    for (NSString *key in self.registMenuCellDic) {
        self.menuView.registCellIdentifier = key;
        [self.menuView registerClass:self.registMenuCellDic[key] forCellWithReuseIdentifier:key];
    }
}

#pragma mark - Lazy Load

- (BXLScrollMenuView *)menuView {
    if (!_menuView) {
        _menuView = [[BXLScrollMenuView alloc] initWithFrame:CGRectZero scrollTheme:self.scrollTheme];
        _menuView.scrollDelegate = self.contentView;
        [self.view addSubview:_menuView];
    }
    return _menuView;
}

- (BXLScrollContentView *)contentView {
    if (!_contentView) {
        _contentView = [[BXLScrollContentView alloc] initWithFrame:CGRectZero scrollTheme:self.scrollTheme];
        _contentView.scrollDelegate = self.menuView;
        [self.view addSubview:_contentView];
    }
    return  _contentView;
}

#pragma mark - Setter

- (void)setMenuTitles:(NSArray<NSString *> *)menuTitles {
    _menuTitles = [menuTitles copy];
}

- (void)setViewControllers:(NSArray<UIViewController *> *)viewControllers {
    _viewControllers = viewControllers;
}
@end
