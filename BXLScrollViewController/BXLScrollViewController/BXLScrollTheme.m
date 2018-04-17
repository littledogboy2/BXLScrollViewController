//
//  BXLScrollTheme.m
//  BXLScrollViewController
//
//  Created by 吴书敏 on 2018/4/11.
//  Copyright © 2018年 吴书敏. All rights reserved.
//

#import "BXLScrollTheme.h"

NSString * const kBXLScrollThemeDefaultMenuViewHeight = @"kBXLScrollThemeDefaultMenuViewHeight";
NSString * const kBXLScrollThemeDefaultMenuViewBGColor = @"kBXLScrollThemeDefaultMenuViewBGColor";

NSString * const kBXLScrollThemeDefaultMenuTitleViewMargin = @"kBXLScrollThemeDefaultMenuTitleViewMargin";
NSString * const kBXLScrollThemeDefaultMenuTitleViewHeight = @"kBXLScrollThemeDefaultMenuTitleViewHeight";

NSString * const kBXLScrollThemeDefaultMenuTitleNormalFont = @"kBXLScrollThemeDefaultMenuTitleNormalFont";
NSString * const kBXLScrollThemeDefaultMenuTitleHighlightedFont = @"kBXLScrollThemeDefaultMenuTitleHighlightedFont";
NSString * const kBXLScrollThemeDefaultMenuTitleNormalColor = @"kBXLScrollThemeDefaultMenuTitleNormalColor";
NSString * const kBXLScrollThemeDefaultMenuTitleHighlightedColor = @"kBXLScrollThemeDefaultMenuTitleHighlightedColor";

NSString * const kBXLScrollThemeDefaultMenuTitleHorizonSpacing = @"kBXLScrollThemeDefaultMenuTitleHorizonSpacing";

NSString * const kBXLScrollThemeDefaultMenuScrollLineBeyondWidth = @"kBXLScrollThemeDefaultMenuScrollLineBeyondWidth";
NSString * const kBXLScrollThemeDefaultMenuScrollLineHeight = @"kBXLScrollThemeDefaultMenuScrollLineHeight";
NSString * const kBXLScrollThemeDefaultMenuScrollLineColor = @"kBXLScrollThemeDefaultMenuScrollLineColor";

NSString * const kBXLScrollThemeDefaultMenuBottomLineHeight = @"kBXLScrollThemeDefaultMenuBottomLineHeight";
NSString * const kBXLScrollThemeDefaultMenuBottomLineColor = @"kBXLScrollThemeDefaultMenuBottomLineColor";


@interface BXLScrollTheme () 

@property (nonatomic, weak) id <BXLScrollThemeDelegate> delegate;

@end

#pragma clang diagnostic puch
#pragma clang diagnostic ignored "-Wprotocol"
@implementation BXLScrollTheme
#pragma clang disgnostic pop

+ (instancetype)defaultTheme {
    return [[BXLScrollTheme alloc] init];
}


- (instancetype)init {
    self = [super init];
    if (self) {
        self.delegate = self;
        if (self.delegate && [self.delegate respondsToSelector:@selector(registTheme)]) {
            self.themeDic = [self configTheme];
        } else {
            self.themeDic = [self defaultThemeDictionary];
        }
    }
    return self;
}

- (NSDictionary *)configTheme {
    return [self.delegate registTheme];
}

// 默认主题
- (NSDictionary *)defaultThemeDictionary {
    return @{
             kBXLScrollThemeDefaultMenuViewHeight : @(41),
             kBXLScrollThemeDefaultMenuViewBGColor : [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1],
             
             kBXLScrollThemeDefaultMenuTitleViewMargin : [NSValue valueWithUIEdgeInsets:UIEdgeInsetsMake(16, 22, 12, 22)],
             kBXLScrollThemeDefaultMenuTitleViewHeight : @(13),
             
             kBXLScrollThemeDefaultMenuTitleNormalFont : [UIFont fontWithName:@"PingFangSC-Regular" size:14],
             kBXLScrollThemeDefaultMenuTitleHighlightedFont : [UIFont fontWithName:@"PingFangSC-Semibold" size:14],
             kBXLScrollThemeDefaultMenuTitleNormalColor : [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1],
             kBXLScrollThemeDefaultMenuTitleHighlightedColor : [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1],
             kBXLScrollThemeDefaultMenuTitleHorizonSpacing : @(30),
             
             kBXLScrollThemeDefaultMenuScrollLineBeyondWidth : @(9),
             kBXLScrollThemeDefaultMenuScrollLineHeight : @(2),
             kBXLScrollThemeDefaultMenuScrollLineColor : [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1],
             
             kBXLScrollThemeDefaultMenuBottomLineHeight : @(1),
             kBXLScrollThemeDefaultMenuBottomLineColor : [UIColor colorWithRed:208/255.0 green:208/255.0 blue:208/255.0 alpha:1],
             };
}

- (CGFloat)menuViewHeight {
    return [[self.themeDic objectForKey:kBXLScrollThemeDefaultMenuViewHeight] floatValue];
}

- (UIColor *)menuViewBGColor {
    return [self.themeDic objectForKey:kBXLScrollThemeDefaultMenuViewBGColor];
}


- (CGFloat)menuTitleViewHeight {
    return [[self.themeDic objectForKey:kBXLScrollThemeDefaultMenuTitleViewHeight] floatValue];
}

- (UIEdgeInsets)menuTitleViewMargin {
    return [[self.themeDic objectForKey:kBXLScrollThemeDefaultMenuTitleViewMargin] UIEdgeInsetsValue];
}

- (UIFont *)menuTitleNormalFont {
    return [self.themeDic objectForKey:kBXLScrollThemeDefaultMenuTitleNormalFont];
}

- (UIFont *)menuTitleHighlightedFont {
    return [self.themeDic objectForKey:kBXLScrollThemeDefaultMenuTitleHighlightedFont];
}

- (UIColor *)menuTitleNormalColor {
    return [self.themeDic objectForKey:kBXLScrollThemeDefaultMenuTitleNormalColor];
}

- (UIColor *)menuTitleHightlightedColor {
    return [self.themeDic objectForKey:kBXLScrollThemeDefaultMenuTitleHighlightedColor];
}

- (CGFloat)menuTitleHorizonSpacing {
    return [[self.themeDic objectForKey:kBXLScrollThemeDefaultMenuTitleHorizonSpacing] floatValue];
}

- (CGFloat)menuScrollLineBeyondWidth {
    return [[self.themeDic objectForKey:kBXLScrollThemeDefaultMenuScrollLineBeyondWidth] floatValue];
}

- (CGFloat)menuScrollLineHeight {
    return [[self.themeDic objectForKey:kBXLScrollThemeDefaultMenuScrollLineHeight] floatValue];
}

- (UIColor *)menuScrollLineColor {
    return [self.themeDic objectForKey:kBXLScrollThemeDefaultMenuScrollLineColor];
}

- (CGFloat)menuBottomLineHeight {
    return [[self.themeDic objectForKey:kBXLScrollThemeDefaultMenuBottomLineHeight] floatValue];
}

- (UIColor *)menuBottomLineColor {
    return [self.themeDic objectForKey:kBXLScrollThemeDefaultMenuBottomLineColor];
}
@end
