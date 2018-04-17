//
//  BXLScrollMenuView.h
//  BXLScrollViewController
//
//  Created by 吴书敏 on 2018/4/11.
//  Copyright © 2018年 吴书敏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BXLScrollTheme.h"
#import "BXLScrollViewProtocol.h"

@interface BXLScrollMenuView : UICollectionView  <BXLScrollContentViewDelegate>

@property (nonatomic, strong, readonly) UIView *scrollLine;
@property (nonatomic, strong, readonly) UIView *bottomLine;
@property (nonatomic, weak) id <BXLScrollMenuViewDelegate> scrollDelegate;
@property (nonatomic, strong) NSArray<NSString *> *menuTitles;

- (instancetype)initWithFrame:(CGRect)frame
                  scrollTheme:(BXLScrollTheme *)scrollTheme;
@end
