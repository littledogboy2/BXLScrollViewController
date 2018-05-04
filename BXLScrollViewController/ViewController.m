//
//  ViewController.m
//  BXLScrollViewController
//
//  Created by 吴书敏 on 2018/4/17.
//  Copyright © 2018年 borderxlab. All rights reserved.
//

#import "ViewController.h"
#import "BXLScrollViewController.h"
#import "FanScrollTheme.h"
#import "MyScrollMemuTitleCell.h"
#import <Masonry.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self testBXLScrollVC];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)testBXLScrollVC {
    NSArray *titles = @[@"推荐", @"护肤", @"套装", @"小众", @"美妆直通车", @"衣服", @"鞋子", @"那兔那年那些事情啊啊啊啊啊啊啊啊"];
    NSMutableArray *vcs = [NSMutableArray array];
    for (int i = 0; i < titles.count; i++) {
        CGFloat r = (arc4random() % 11) / 10.0;
        CGFloat g = (arc4random() % 11) / 10.0;
        CGFloat b = (arc4random() % 11) / 10.0;
        UIViewController *vc = [[UIViewController alloc] init];
        vc.view.backgroundColor = [UIColor colorWithRed:r green:g blue:b alpha:1.0];
        [vcs addObject:vc];
    }
    BXLScrollTheme *theme = [BXLScrollTheme defaultTheme];
    //    FanScrollTheme *theme = [[FanScrollTheme alloc] init];
    BXLScrollViewController *scrollVC = [[BXLScrollViewController alloc] init];
    scrollVC.scrollTheme = theme;
    scrollVC.menuTitles = titles;
    scrollVC.viewControllers = vcs;
    [scrollVC registMenuCell:[MyScrollMemuTitleCell class]];
    [self.view addSubview:scrollVC.view];
    [self addChildViewController:scrollVC];
    
    [scrollVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).offset(64);
        make.left.right.mas_equalTo(self.view);
        if (@available(iOS 11, *)) {
            make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        } else {
            make.bottom.mas_equalTo(self.view);
        }
    }];
}


@end
