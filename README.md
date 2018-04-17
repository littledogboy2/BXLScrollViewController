# BXLScrollViewController

BXLScrollViewController 是一个便捷的容器滚动框架。

![效果图](https://ws1.sinaimg.cn/large/006tKfTcgy1fqfns28vgyg309n0h7wvl.gif)


## 使用方式

### 使用默认主题

``` Object-C 
NSArray *titles = @[@"title1",@"title2", @"title3"];
NSArray *vcs = @[vc1, vc2, vc3];
BXLScrollTheme *theme = [BXLScrollTheme defaultTheme]; 

BXLScrollViewController *scrollVC = [[BXLScrollViewController alloc] init];
scrollVC.scrollTheme = theme;
scrollVC.menuTitles = titles;
scrollVC.viewControllers = vcs;
[parentVC.view addSubview:scrollVC.view];
[parentVC addChildViewController:scrollVC];

// ... layout  scrollVC.view ... //
```

### 使用自定义主题

1. 创建一个子类继承自 BXLScrollTheme
2. 实现方法 `- (NSDictionary *)registTheme` , 返回一个样式字典，可参考 BXLScrollTheme。

例如： 

```
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
```

3 . 使用子类创建 theme。

```
// menuTitles
// viewControllers
FanScrollTheme *theme = [[FanScrollTheme alloc] init];
BXLScrollViewController *scrollVC = [[BXLScrollViewController alloc] init];
scrollVC.scrollTheme = theme;
scrollVC.menuTitles = titles;
scrollVC.viewControllers = vcs;
[parentVC.view addSubview:scrollVC.view];
[parentVC addChildViewController:scrollVC];

// ... layout  scrollVC.view ... //
```



## 支持自定义的主题属性

![](https://ws3.sinaimg.cn/large/006tKfTcgy1fqfoq7ljcvj30af028jra.jpg)

```
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
```