//
//  BXLScrollTheme.h
//  BXLScrollViewController
//
//  Created by 吴书敏 on 2018/4/11.
//  Copyright © 2018年 吴书敏. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#pragma mark - BXLScrollThemeMacro

#define BXLScrollThemeRGBColor(r, g, b) BXLScrollThemeRGBAColor(r, g, b, 1.0)
#define BXLScrollThemeRGBAColor(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

#pragma mark - BXLScrollThemeDefault
extern NSString * const kBXLScrollThemeDefaultMenuViewHeight; // 菜单视图高度
extern NSString * const kBXLScrollThemeDefaultMenuViewBGColor; // 菜单视图背景色

extern NSString * const kBXLScrollThemeDefaultMenuTitleViewHeight; // 标题视图高度
extern NSString * const kBXLScrollThemeDefaultMenuTitleViewMargin; // 标题视图与菜单视图的间距

extern NSString * const kBXLScrollThemeDefaultMenuTitleNormalFont; // 标题字体
extern NSString * const kBXLScrollThemeDefaultMenuTitleHighlightedFont; // 标题高亮字体
extern NSString * const kBXLScrollThemeDefaultMenuTitleNormalColor; // 标题颜色
extern NSString * const kBXLScrollThemeDefaultMenuTitleHighlightedColor; // 标题高亮颜色
extern NSString * const kBXLScrollThemeDefaultMenuTitleHorizonSpacing; // 标题水平间距

extern NSString * const kBXLScrollThemeDefaultMenuScrollLineBeyondWidth; // 滚动条比标题多出来的平均长度 beyondWidth = (line.width - title.width) / 2.0
extern NSString * const kBXLScrollThemeDefaultMenuScrollLineHeight; // 滚动条高度
extern NSString * const kBXLScrollThemeDefaultMenuScrollLineColor; // 滚动条颜色

extern NSString * const kBXLScrollThemeDefaultMenuBottomLineHeight; // 底部条高度
extern NSString * const kBXLScrollThemeDefaultMenuBottomLineColor; // 底部条颜色


@protocol BXLScrollThemeDelegate <NSObject>
- (NSDictionary *)registTheme; // 子类注册主题
@end

@interface BXLScrollTheme : NSObject <BXLScrollThemeDelegate>

@property (nonatomic, strong) NSDictionary *themeDic;

+ (instancetype)defaultTheme; // 默认主题

- (NSDictionary *)defaultThemeDictionary;

- (CGFloat)menuViewHeight;
- (UIColor *)menuViewBGColor;

- (CGFloat)menuTitleViewHeight;
- (UIEdgeInsets)menuTitleViewMargin;

- (UIFont *)menuTitleNormalFont;
- (UIFont *)menuTitleHighlightedFont;
- (UIColor *)menuTitleNormalColor;
- (UIColor *)menuTitleHightlightedColor;
- (CGFloat)menuTitleHorizonSpacing;

- (CGFloat)menuScrollLineBeyondWidth;
- (CGFloat)menuScrollLineHeight;
- (UIColor *)menuScrollLineColor;

- (CGFloat)menuBottomLineHeight;
- (UIColor *)menuBottomLineColor;

@end
