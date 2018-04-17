//
//  FanScrollTheme.m
//  BXLScrollViewController
//
//  Created by 吴书敏 on 2018/4/12.
//  Copyright © 2018年 吴书敏. All rights reserved.
//

#import "FanScrollTheme.h"

@implementation FanScrollTheme

- (NSDictionary *)registTheme {
    return @{
             kBXLScrollThemeDefaultMenuViewHeight : @(41),
             kBXLScrollThemeDefaultMenuViewBGColor : [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1],
             
             kBXLScrollThemeDefaultMenuTitleViewMargin : [NSValue valueWithUIEdgeInsets:UIEdgeInsetsMake(16, 0, 12, 0)],
             kBXLScrollThemeDefaultMenuTitleViewHeight : @(13),
             
             kBXLScrollThemeDefaultMenuTitleNormalFont : [UIFont fontWithName:@"PingFangSC-Regular" size:14],
             kBXLScrollThemeDefaultMenuTitleHighlightedFont : [UIFont fontWithName:@"PingFangSC-Semibold" size:14],
             kBXLScrollThemeDefaultMenuTitleNormalColor : [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1],
             kBXLScrollThemeDefaultMenuTitleHighlightedColor : [UIColor redColor],
             kBXLScrollThemeDefaultMenuTitleHorizonSpacing : @(30),
             
             kBXLScrollThemeDefaultMenuScrollLineBeyondWidth : @(9),
             kBXLScrollThemeDefaultMenuScrollLineHeight : @(2),
             kBXLScrollThemeDefaultMenuScrollLineColor : [UIColor redColor],
             
             kBXLScrollThemeDefaultMenuBottomLineHeight : @(1),
             kBXLScrollThemeDefaultMenuBottomLineColor : [UIColor redColor],
             };
}

@end
