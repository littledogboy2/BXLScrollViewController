//
//  BXLScrollViewController.h
//  BXLScrollViewController
//
//  Created by 吴书敏 on 2018/4/11.
//  Copyright © 2018年 吴书敏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BXLScrollTheme.h"
#import "BXLScrollMenuView.h"
#import "BXLScrollContentView.h"

@interface BXLScrollViewController : UIViewController

@property (nonatomic, strong, readonly) BXLScrollMenuView *menuView;
@property (nonatomic, strong, readonly) BXLScrollContentView *contentView;
@property (nonatomic, copy) NSArray<NSString *> *menuTitles;
@property (nonatomic, strong) NSArray<UIViewController *> *viewControllers;
@property (nonatomic, strong) BXLScrollTheme *scrollTheme;

- (void)registMenuCell:(Class)menuCellClass;

@end
