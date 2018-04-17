//
//  BXLScrollViewProtocol.h
//  BXLScrollViewController
//
//  Created by 吴书敏 on 2018/4/13.
//  Copyright © 2018年 吴书敏. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class BXLScrollContentView;
@class BXLScrollMenuView;

@protocol BXLScrollContentViewDelegate <NSObject>

- (void)bxlScrollContentViewDidScroll:(BXLScrollContentView *)contentView;
- (void)bxlScrollContentViewDidEndDecelerating:(NSIndexPath *)indexPath;

@end


@protocol BXLScrollMenuViewDelegate <NSObject>

- (void)bxlScrollMenuView:(BXLScrollMenuView *)menuView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;

@end

