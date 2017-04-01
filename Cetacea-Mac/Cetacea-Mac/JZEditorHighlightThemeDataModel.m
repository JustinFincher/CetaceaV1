//
//  JZEditorHighlightThemeDataModel.m
//  Cetacea-Mac
//
//  Created by Fincher Justin on 16/7/8.
//  Copyright © 2016年 JustZht. All rights reserved.
//
#import "JZdayNightThemeManager.h"
#import "JZEditorHighlightThemeDataModel.h"

@implementation JZEditorHighlightThemeDataModel
@synthesize themeName,previewJPG;
- (id)initWithDefault
{
    self=  [super init];
    if (self)
    {
        self.themeName = @"Untitled";
        self.DefaultDataModel = [[JZEditorHighlightThemeSingleRowDataModel alloc] initWithDefaultTextStyle];
        self.AtxHeaderDataModel = [[JZEditorHighlightThemeSingleRowDataModel alloc] initWithDefaultTextStyle];
        self.SetextHeaderDataModel = [[JZEditorHighlightThemeSingleRowDataModel alloc] initWithDefaultTextStyle];
        self.CodeBlockDataModel = [[JZEditorHighlightThemeSingleRowDataModel alloc] initWithDefaultTextStyle];
        self.TabIndentDataModel = [[JZEditorHighlightThemeSingleRowDataModel alloc] initWithDefaultTextStyle];
        self.BoldDataModel = [[JZEditorHighlightThemeSingleRowDataModel alloc] initWithDefaultTextStyle];
        self.ItalicDataModel = [[JZEditorHighlightThemeSingleRowDataModel alloc] initWithDefaultTextStyle];
        self.StrikeThroughDataModel = [[JZEditorHighlightThemeSingleRowDataModel alloc] initWithDefaultTextStyle];
        self.ListDataModel = [[JZEditorHighlightThemeSingleRowDataModel alloc] initWithDefaultTextStyle];
        self.QuoteDataModel = [[JZEditorHighlightThemeSingleRowDataModel alloc] initWithDefaultTextStyle];
        self.ImageDataModel = [[JZEditorHighlightThemeSingleRowDataModel alloc] initWithDefaultTextStyle];
        self.LinkDataModel = [[JZEditorHighlightThemeSingleRowDataModel alloc] initWithDefaultTextStyle];
        self.EditorViewDataModel = [[JZEditorHighlightThemeSingleRowDataModel alloc] initWithDefaultTextStyle];
        self.RuleViewDataModel = [[JZEditorHighlightThemeSingleRowDataModel alloc] initWithDefaultTextStyle];
    }
    return self;
}
- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init])
    {
        self.themeName = [decoder decodeObjectForKey:@"themeName"];
        self.previewJPG = [decoder decodeObjectForKey:@"previewJPG"];
        self.DefaultDataModel = [decoder decodeObjectForKey:@"DefaultDataModel"];
        self.AtxHeaderDataModel = [decoder decodeObjectForKey:@"AtxHeaderDataModel"];
        self.SetextHeaderDataModel = [decoder decodeObjectForKey:@"SetextHeaderDataModel"];
        self.CodeBlockDataModel = [decoder decodeObjectForKey:@"CodeBlockDataModel"];
        self.TabIndentDataModel = [decoder decodeObjectForKey:@"TabIndentDataModel"];
        self.BoldDataModel = [decoder decodeObjectForKey:@"BoldDataModel"];
        self.ItalicDataModel = [decoder decodeObjectForKey:@"ItalicDataModel"];
        self.StrikeThroughDataModel = [decoder decodeObjectForKey:@"StrikeThroughDataModel"];
        self.ListDataModel = [decoder decodeObjectForKey:@"ListDataModel"];
        self.QuoteDataModel = [decoder decodeObjectForKey:@"QuoteDataModel"];
        self.ImageDataModel = [decoder decodeObjectForKey:@"ImageDataModel"];
        self.LinkDataModel = [decoder decodeObjectForKey:@"LinkDataModel"];
        self.EditorViewDataModel = [decoder decodeObjectForKey:@"EditorViewDataModel"];
        self.RuleViewDataModel = [decoder decodeObjectForKey:@"RuleViewDataModel"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:themeName forKey:@"themeName"];
    [encoder encodeObject:previewJPG forKey:@"previewJPG"];
    [encoder encodeObject:_DefaultDataModel forKey:@"DefaultDataModel"];
    [encoder encodeObject:_AtxHeaderDataModel forKey:@"AtxHeaderDataModel"];
    [encoder encodeObject:_SetextHeaderDataModel forKey:@"SetextHeaderDataModel"];
    [encoder encodeObject:_CodeBlockDataModel forKey:@"CodeBlockDataModel"];
    [encoder encodeObject:_TabIndentDataModel forKey:@"TabIndentDataModel"];
    [encoder encodeObject:_BoldDataModel forKey:@"BoldDataModel"];
    [encoder encodeObject:_ItalicDataModel forKey:@"ItalicDataModel"];
    [encoder encodeObject:_StrikeThroughDataModel forKey:@"StrikeThroughDataModel"];
    [encoder encodeObject:_ListDataModel forKey:@"ListDataModel"];
    [encoder encodeObject:_QuoteDataModel forKey:@"QuoteDataModel"];
    [encoder encodeObject:_ImageDataModel forKey:@"ImageDataModel"];
    [encoder encodeObject:_LinkDataModel forKey:@"LinkDataModel"];
    [encoder encodeObject:_EditorViewDataModel forKey:@"EditorViewDataModel"];
    [encoder encodeObject:_RuleViewDataModel forKey:@"RuleViewDataModel"];
}
#pragma mark - Get should applied appearance
/**
 *  method to indicate should apply light theme or not
 *
 *  @return BOOL for is Light theme
 */
- (BOOL)shouldApplyLightTheme
{
    NSString *name = [[JZdayNightThemeManager sharedManager]getShouldAppliedNSAppearanceName];
    if ([name isEqualToString:@"NSAppearanceNameVibrantDark"])
    {
        return NO;
    }else if ([name isEqualToString:@"NSAppearanceNameVibrantLight"])
    {
        return YES;
    }else
    {
        return YES;
    }
}


- (NSColor *)getBackgroundColor
{
    NSColor *backgroundViewColor = [self shouldApplyLightTheme]? [self.EditorViewDataModel.lightBackgroundBlockColor color] : [self.EditorViewDataModel.darkBackgroundBlockColor color];
    return backgroundViewColor;
}
- (NSColor *)getRulerViewBackgroundColor
{
    NSColor *color = [self shouldApplyLightTheme]? [self.RuleViewDataModel.lightBackgroundBlockColor color] : [self.RuleViewDataModel.darkBackgroundBlockColor color];
    return color;
}
- (NSColor *)getRulerViewForegroundTextColor
{
    NSColor *color = [self shouldApplyLightTheme]? [self.RuleViewDataModel.lightForegroundTextColor color] : [self.RuleViewDataModel.darkForegroundTextColor color];
    return color;
}
- (NSColor *)getRulerViewForegroundHightlightTextColor
{
    NSColor *color = [self shouldApplyLightTheme]? [self.RuleViewDataModel.lightForegroundTagtColor color] : [self.RuleViewDataModel.darkForegroundTagtColor color];
    return color;
}

- (NSDictionary<NSString *,id> *)DefaultTextAttributes
{
    NSColor *defaultTextForegroundColor = [self shouldApplyLightTheme]? [self.DefaultDataModel.lightForegroundTextColor color] : [self.DefaultDataModel.darkForegroundTextColor color];
//    NSColor *defaultBlockBackgroundColor = [self shouldApplyLightTheme]? [self.DefaultDataModel.lightForegroundTextColor color] : [self.DefaultDataModel.darkForegroundTextColor color];
    return @{ NSFontAttributeName: [[JZFontDisplayManager sharedManager] getFont],
              NSForegroundColorAttributeName: defaultTextForegroundColor};
}
- (NSDictionary<NSString *,id> *)AtxHeaderTextAttributes
{
    NSColor *AtxHeaderTextForegroundColor = [self shouldApplyLightTheme]? [self.AtxHeaderDataModel.lightForegroundTextColor color] : [self.AtxHeaderDataModel.darkForegroundTextColor color];
    return @{ NSFontAttributeName: [[JZFontDisplayManager sharedManager] getBoldFont],
              NSForegroundColorAttributeName: AtxHeaderTextForegroundColor};
}

- (NSDictionary<NSString *,id> *)AtxHeaderTagAttributes
{
    NSColor *AtxHeaderTagForegroundColor = [self shouldApplyLightTheme]? [self.AtxHeaderDataModel.lightForegroundTagtColor color] : [self.AtxHeaderDataModel.darkForegroundTagtColor color];
    return @{ NSFontAttributeName: [[JZFontDisplayManager sharedManager] getBoldFont],
              NSForegroundColorAttributeName: AtxHeaderTagForegroundColor};
}

- (NSDictionary<NSString *,id> *)SetextHeaderTextAttributes
{
    NSColor *SetextHeaderTextForegroundColor = [self shouldApplyLightTheme]? [self.SetextHeaderDataModel.lightForegroundTextColor color] : [self.SetextHeaderDataModel.darkForegroundTextColor color];
    return @{ NSFontAttributeName: [[JZFontDisplayManager sharedManager] getBoldFont],
              NSForegroundColorAttributeName: SetextHeaderTextForegroundColor};
}

- (NSDictionary<NSString *,id> *)SetextHeaderTagAttributes
{
    NSColor *SetextHeaderTagForegroundColor = [self shouldApplyLightTheme]? [self.SetextHeaderDataModel.lightForegroundTagtColor color] : [self.SetextHeaderDataModel.darkForegroundTagtColor color];
    return @{ NSFontAttributeName: [[JZFontDisplayManager sharedManager] getBoldFont],
              NSForegroundColorAttributeName: SetextHeaderTagForegroundColor};
}

- (NSDictionary<NSString *,id> *)CodeBlockTextAttributes
{
    NSColor *CodeBlockTextForegroundColor = [self shouldApplyLightTheme]? [self.CodeBlockDataModel.lightForegroundTextColor color] : [self.CodeBlockDataModel.darkForegroundTextColor color];
    NSColor *CodeBlockTextBackgroundColor = [self shouldApplyLightTheme]? [self.CodeBlockDataModel.lightBackgroundBlockColor color] : [self.CodeBlockDataModel.darkBackgroundBlockColor color];
    return @{ NSFontAttributeName: [[JZFontDisplayManager sharedManager] getMonospacedFont],
              NSForegroundColorAttributeName: CodeBlockTextForegroundColor,
              NSBackgroundColorAttributeName: CodeBlockTextBackgroundColor};
}

- (NSDictionary<NSString *,id> *)CodeBlockTagAttributes
{
    NSColor *CodeBlockTagForegroundColor = [self shouldApplyLightTheme]? [self.CodeBlockDataModel.lightForegroundTagtColor color] : [self.CodeBlockDataModel.darkForegroundTagtColor color];
    return @{ NSFontAttributeName: [[JZFontDisplayManager sharedManager] getBoldMonospacedFont],
              NSForegroundColorAttributeName: CodeBlockTagForegroundColor};
}

 - (NSDictionary<NSString *,id> *)TabIndentTextAttributes
{
    NSColor *TabIndentTextForegroundColor = [self shouldApplyLightTheme]? [self.TabIndentDataModel.lightForegroundTextColor color] : [self.TabIndentDataModel.darkForegroundTextColor color];
    NSColor *TabIndentTextBackgroundColor = [self shouldApplyLightTheme]? [self.TabIndentDataModel.lightBackgroundBlockColor color] : [self.TabIndentDataModel.darkBackgroundBlockColor color];
    return @{ NSFontAttributeName: [[JZFontDisplayManager sharedManager] getMonospacedFont],
              NSForegroundColorAttributeName: TabIndentTextForegroundColor,
              NSBackgroundColorAttributeName: TabIndentTextBackgroundColor};
}

- (NSDictionary<NSString *,id> *)TabIndentTagAttributes
{
    NSColor *TabIndentTagForegroundColor = [self shouldApplyLightTheme]? [self.TabIndentDataModel.lightForegroundTagtColor color] : [self.TabIndentDataModel.darkForegroundTextColor color];
    return @{ NSFontAttributeName: [[JZFontDisplayManager sharedManager] getMonospacedFont],
              NSForegroundColorAttributeName: TabIndentTagForegroundColor};
}

- (NSDictionary<NSString *,id> *)BoldTextAttributes
{
    NSColor *BoldTextForegroundColor = [self shouldApplyLightTheme]? [self.BoldDataModel.lightForegroundTextColor color] : [self.BoldDataModel.darkForegroundTextColor color];
    NSColor *BoldTextBackgroundColor = [self shouldApplyLightTheme]? [self.BoldDataModel.lightBackgroundBlockColor color] : [self.BoldDataModel.darkBackgroundBlockColor color];
    return @{ NSFontAttributeName: [[JZFontDisplayManager sharedManager] getBoldFont],
              NSForegroundColorAttributeName: BoldTextForegroundColor,
              NSBackgroundColorAttributeName: BoldTextBackgroundColor};
}

- (NSDictionary<NSString *,id> *)BoldTagAttributes
{
    NSColor *BoldTagForegroundColor = [self shouldApplyLightTheme]? [self.BoldDataModel.lightForegroundTagtColor color] : [self.BoldDataModel.darkForegroundTagtColor color];
    NSColor *BoldTagBackgroundColor = [self shouldApplyLightTheme]? [self.BoldDataModel.lightBackgroundBlockColor color] : [self.BoldDataModel.darkBackgroundBlockColor color];
    return @{ NSFontAttributeName: [[JZFontDisplayManager sharedManager] getBoldFont],
              NSForegroundColorAttributeName: BoldTagForegroundColor,
              NSBackgroundColorAttributeName: BoldTagBackgroundColor};
}


- (NSDictionary<NSString *,id> *)ItalicTextAttributes
{
    NSColor *ItalicTextForegroundColor = [self shouldApplyLightTheme]? [self.ItalicDataModel.lightForegroundTextColor color] : [self.ItalicDataModel.darkForegroundTextColor color];
    NSColor *ItalicTextBackgroundColor = [self shouldApplyLightTheme]? [self.ItalicDataModel.lightBackgroundBlockColor color] : [self.ItalicDataModel.darkBackgroundBlockColor color];
    return @{ NSFontAttributeName: [[JZFontDisplayManager sharedManager] getItalicFont],
              NSForegroundColorAttributeName: ItalicTextForegroundColor,
              NSBackgroundColorAttributeName: ItalicTextBackgroundColor};
}

- (NSDictionary<NSString *,id> *)ItalicTagAttributes
{
    NSColor *ItalicTagForegroundColor = [self shouldApplyLightTheme]? [self.ItalicDataModel.lightForegroundTagtColor color] : [self.ItalicDataModel.darkForegroundTagtColor color];
    NSColor *ItalicTagBackgroundColor = [self shouldApplyLightTheme]? [self.ItalicDataModel.lightBackgroundBlockColor color] : [self.ItalicDataModel.darkBackgroundBlockColor color];
    return @{ NSFontAttributeName: [[JZFontDisplayManager sharedManager] getBoldFont],
              NSForegroundColorAttributeName: ItalicTagForegroundColor,
              NSBackgroundColorAttributeName: ItalicTagBackgroundColor};
}
- (NSDictionary<NSString *,id> *)StrikeThroughTextAttributes
{
    NSColor *StrikeThroughTextForegroundColor = [self shouldApplyLightTheme]? [self.ItalicDataModel.lightForegroundTextColor color] : [self.ItalicDataModel.darkForegroundTextColor color];
    NSColor *StrikeThroughTextBackgroundColor = [self shouldApplyLightTheme]? [self.ItalicDataModel.lightBackgroundBlockColor color] : [self.ItalicDataModel.darkBackgroundBlockColor color];
    return @{ NSFontAttributeName: [[JZFontDisplayManager sharedManager] getItalicFont],
              NSForegroundColorAttributeName: StrikeThroughTextForegroundColor,
              NSBackgroundColorAttributeName: StrikeThroughTextBackgroundColor,
              NSStrikethroughStyleAttributeName:
                  [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
}

- (NSDictionary<NSString *,id> *)StrikeThroughTagAttributes
{
    NSColor *StrikeThroughTagForegroundColor = [self shouldApplyLightTheme]? [self.StrikeThroughDataModel.lightForegroundTagtColor color] : [self.StrikeThroughDataModel.darkForegroundTagtColor color];
    NSColor *StrikeThroughTagBackgroundColor = [self shouldApplyLightTheme]? [self.StrikeThroughDataModel.lightBackgroundBlockColor color] : [self.StrikeThroughDataModel.darkBackgroundBlockColor color];
    return @{ NSFontAttributeName: [[JZFontDisplayManager sharedManager] getBoldFont],
              NSForegroundColorAttributeName: StrikeThroughTagForegroundColor,
              NSBackgroundColorAttributeName: StrikeThroughTagBackgroundColor};
}
- (NSDictionary<NSString *,id> *)ListTextAttributes
{
    NSColor *ListTextForegroundColor = [self shouldApplyLightTheme]? [self.ListDataModel.lightForegroundTextColor color] : [self.ListDataModel.darkForegroundTextColor color];
    NSColor *ListTextBackgroundColor = [self shouldApplyLightTheme]? [self.ListDataModel.lightBackgroundBlockColor color] : [self.ListDataModel.darkBackgroundBlockColor color];
    return @{ NSFontAttributeName: [[JZFontDisplayManager sharedManager] getFont],
              NSForegroundColorAttributeName: ListTextForegroundColor,
              NSBackgroundColorAttributeName: ListTextBackgroundColor};
}

- (NSDictionary<NSString *,id> *)ListTagAttributes
{
    NSColor *ListTagForegroundColor = [self shouldApplyLightTheme]? [self.ListDataModel.lightForegroundTagtColor color] : [self.ListDataModel.darkForegroundTagtColor color];
    NSColor *ListTagBackgroundColor = [self shouldApplyLightTheme]? [self.ListDataModel.lightBackgroundBlockColor color] : [self.ListDataModel.darkBackgroundBlockColor color];
    return @{ NSFontAttributeName: [[JZFontDisplayManager sharedManager] getBoldFont],
              NSForegroundColorAttributeName: ListTagForegroundColor,
              NSBackgroundColorAttributeName: ListTagBackgroundColor};
}
- (NSDictionary<NSString *,id> *)QuoteTextAttributes
{
    NSColor *QuoteTextForegroundColor = [self shouldApplyLightTheme]? [self.QuoteDataModel.lightForegroundTextColor color] : [self.QuoteDataModel.darkForegroundTextColor color];
    NSColor *QuoteTextBackgroundColor = [self shouldApplyLightTheme]? [self.QuoteDataModel.lightBackgroundBlockColor color] : [self.QuoteDataModel.darkBackgroundBlockColor color];
    return @{ NSFontAttributeName: [[JZFontDisplayManager sharedManager] getItalicFont],
              NSForegroundColorAttributeName: QuoteTextForegroundColor,
              NSBackgroundColorAttributeName: QuoteTextBackgroundColor};
}

- (NSDictionary<NSString *,id> *)QuoteTagAttributes
{
    NSColor *QuoteTagForegroundColor = [self shouldApplyLightTheme]? [self.QuoteDataModel.lightForegroundTagtColor color] : [self.QuoteDataModel.darkForegroundTagtColor color];
    NSColor *QuoteTagBackgroundColor = [self shouldApplyLightTheme]? [self.QuoteDataModel.lightBackgroundBlockColor color] : [self.QuoteDataModel.darkBackgroundBlockColor color];
    return @{ NSFontAttributeName: [[JZFontDisplayManager sharedManager] getBoldFont],
              NSForegroundColorAttributeName: QuoteTagForegroundColor,
              NSBackgroundColorAttributeName: QuoteTagBackgroundColor};
}
- (NSDictionary<NSString *,id> *)ImageTextAttributes
{
    NSColor *ImageTextForegroundColor = [self shouldApplyLightTheme]? [self.ImageDataModel.lightForegroundTextColor color] : [self.ImageDataModel.darkForegroundTextColor color];
    NSColor *ImageTextBackgroundColor = [self shouldApplyLightTheme]? [self.ImageDataModel.lightBackgroundBlockColor color] : [self.ImageDataModel.darkBackgroundBlockColor color];
    return @{ NSFontAttributeName: [[JZFontDisplayManager sharedManager] getItalicFont],
              NSForegroundColorAttributeName: ImageTextForegroundColor,
              NSBackgroundColorAttributeName: ImageTextBackgroundColor};
}

- (NSDictionary<NSString *,id> *)ImageTagAttributes
{
    NSColor *ImageTagForegroundColor = [self shouldApplyLightTheme]? [self.ImageDataModel.lightForegroundTagtColor color] : [self.ImageDataModel.darkForegroundTagtColor color];
    NSColor *ImageTagBackgroundColor = [self shouldApplyLightTheme]? [self.ImageDataModel.lightBackgroundBlockColor color] : [self.ImageDataModel.darkBackgroundBlockColor color];
    return @{ NSFontAttributeName: [[JZFontDisplayManager sharedManager] getBoldFont],
              NSForegroundColorAttributeName: ImageTagForegroundColor,
              NSBackgroundColorAttributeName: ImageTagBackgroundColor};
}
- (NSDictionary<NSString *,id> *)LinkTextAttributes
{
    NSColor *LinkTextForegroundColor = [self shouldApplyLightTheme]? [self.QuoteDataModel.lightForegroundTextColor color] : [self.QuoteDataModel.darkForegroundTextColor color];
    NSColor *LinkTextBackgroundColor = [self shouldApplyLightTheme]? [self.QuoteDataModel.lightBackgroundBlockColor color] : [self.QuoteDataModel.darkBackgroundBlockColor color];
    return @{ NSFontAttributeName: [[JZFontDisplayManager sharedManager] getItalicFont],
              NSForegroundColorAttributeName: LinkTextForegroundColor,
              NSBackgroundColorAttributeName: LinkTextBackgroundColor};
}

- (NSDictionary<NSString *,id> *)LinkTagAttributes
{
    NSColor *LinkTagForegroundColor = [self shouldApplyLightTheme]? [self.QuoteDataModel.lightForegroundTagtColor color] : [self.QuoteDataModel.darkForegroundTagtColor color];
    NSColor *LinkTagBackgroundColor = [self shouldApplyLightTheme]? [self.QuoteDataModel.lightBackgroundBlockColor color] : [self.QuoteDataModel.darkBackgroundBlockColor color];
    return @{ NSFontAttributeName: [[JZFontDisplayManager sharedManager] getBoldFont],
              NSForegroundColorAttributeName: LinkTagForegroundColor,
              NSBackgroundColorAttributeName: LinkTagBackgroundColor};
}
@end
