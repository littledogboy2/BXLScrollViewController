//
//  BXLScrollContentView.h
//  BXLScrollViewController
//
//  Created by 吴书敏 on 2018/4/11.
//  Copyright © 2018年 吴书敏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BXLScrollTheme.h"
#import "BXLScrollViewProtocol.h"

@interface BXLScrollContentView : UICollectionView <BXLScrollMenuViewDelegate>

@property (nonatomic, strong) NSArray<UIViewController *> *viewControllers;
@property (nonatomic, strong) BXLScrollTheme *scrollTheme;
@property (nonatomic, weak) id <BXLScrollContentViewDelegate> scrollDelegate;

- (instancetype)initWithFrame:(CGRect)frame
                  scrollTheme:(BXLScrollTheme *)scrollTheme;


@end
