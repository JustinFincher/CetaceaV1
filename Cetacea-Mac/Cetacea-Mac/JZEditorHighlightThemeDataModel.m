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
    NSColor *backgroundViewColor = [self shouldApplyLightTheme]? [self.EditorViewDataModel.lightBackgroundBlockColor colorFromSelf] : [self.EditorViewDataModel.darkBackgroundBlockColor colorFromSelf];
    return backgroundViewColor;
}

- (NSDictionary<NSString *,id> *)DefaultTextAttributes
{
    NSColor *defaultTextForegroundColor = [self shouldApplyLightTheme]? [self.DefaultDataModel.lightForegroundTextColor colorFromSelf] : [self.DefaultDataModel.darkForegroundTextColor colorFromSelf];
//    NSColor *defaultBlockBackgroundColor = [self shouldApplyLightTheme]? [self.DefaultDataModel.lightForegroundTextColor colorFromSelf] : [self.DefaultDataModel.darkForegroundTextColor colorFromSelf];
    return @{ NSFontAttributeName: [[JZFontDisplayManager sharedManager] getFont],
              NSForegroundColorAttributeName: defaultTextForegroundColor};
}
- (NSDictionary<NSString *,id> *)AtxHeaderTextAttributes
{
    NSColor *AtxHeaderTextForegroundColor = [self shouldApplyLightTheme]? [self.AtxHeaderDataModel.lightForegroundTextColor colorFromSelf] : [self.AtxHeaderDataModel.darkForegroundTextColor colorFromSelf];
    return @{ NSFontAttributeName: [[JZFontDisplayManager sharedManager] getBoldFont],
              NSForegroundColorAttributeName: AtxHeaderTextForegroundColor};
}

- (NSDictionary<NSString *,id> *)AtxHeaderTagAttributes
{
    NSColor *AtxHeaderTagForegroundColor = [self shouldApplyLightTheme]? [self.AtxHeaderDataModel.lightForegroundTagtColor colorFromSelf] : [self.AtxHeaderDataModel.darkForegroundTagtColor colorFromSelf];
    return @{ NSFontAttributeName: [[JZFontDisplayManager sharedManager] getBoldFont],
              NSForegroundColorAttributeName: AtxHeaderTagForegroundColor};
}

- (NSDictionary<NSString *,id> *)SetextHeaderTextAttributes
{
    NSColor *SetextHeaderTextForegroundColor = [self shouldApplyLightTheme]? [self.SetextHeaderDataModel.lightForegroundTextColor colorFromSelf] : [self.SetextHeaderDataModel.darkForegroundTextColor colorFromSelf];
    return @{ NSFontAttributeName: [[JZFontDisplayManager sharedManager] getBoldFont],
              NSForegroundColorAttributeName: SetextHeaderTextForegroundColor};
}

- (NSDictionary<NSString *,id> *)SetextHeaderTagAttributes
{
    NSColor *SetextHeaderTagForegroundColor = [self shouldApplyLightTheme]? [self.SetextHeaderDataModel.lightForegroundTagtColor colorFromSelf] : [self.SetextHeaderDataModel.darkForegroundTagtColor colorFromSelf];
    return @{ NSFontAttributeName: [[JZFontDisplayManager sharedManager] getBoldFont],
              NSForegroundColorAttributeName: SetextHeaderTagForegroundColor};
}

- (NSDictionary<NSString *,id> *)CodeBlockTextAttributes
{
    NSColor *CodeBlockTextForegroundColor = [self shouldApplyLightTheme]? [self.CodeBlockDataModel.lightForegroundTextColor colorFromSelf] : [self.CodeBlockDataModel.darkForegroundTextColor colorFromSelf];
    NSColor *CodeBlockTextBackgroundColor = [self shouldApplyLightTheme]? [self.CodeBlockDataModel.lightBackgroundBlockColor colorFromSelf] : [self.CodeBlockDataModel.darkBackgroundBlockColor colorFromSelf];
    return @{ NSFontAttributeName: [[JZFontDisplayManager sharedManager] getMonospacedFont],
              NSForegroundColorAttributeName: CodeBlockTextForegroundColor,
              NSBackgroundColorAttributeName: CodeBlockTextBackgroundColor};
}

- (NSDictionary<NSString *,id> *)CodeBlockTagAttributes
{
    NSColor *CodeBlockTagForegroundColor = [self shouldApplyLightTheme]? [self.CodeBlockDataModel.lightForegroundTagtColor colorFromSelf] : [self.CodeBlockDataModel.darkForegroundTagtColor colorFromSelf];
    return @{ NSFontAttributeName: [[JZFontDisplayManager sharedManager] getBoldMonospacedFont],
              NSForegroundColorAttributeName: CodeBlockTagForegroundColor};
}

 - (NSDictionary<NSString *,id> *)TabIndentTextAttributes
{
    NSColor *TabIndentTextForegroundColor = [self shouldApplyLightTheme]? [self.TabIndentDataModel.lightForegroundTextColor colorFromSelf] : [self.TabIndentDataModel.darkForegroundTextColor colorFromSelf];
    NSColor *TabIndentTextBackgroundColor = [self shouldApplyLightTheme]? [self.TabIndentDataModel.lightBackgroundBlockColor colorFromSelf] : [self.TabIndentDataModel.darkBackgroundBlockColor colorFromSelf];
    return @{ NSFontAttributeName: [[JZFontDisplayManager sharedManager] getMonospacedFont],
              NSForegroundColorAttributeName: TabIndentTextForegroundColor,
              NSBackgroundColorAttributeName: TabIndentTextBackgroundColor};
}

- (NSDictionary<NSString *,id> *)TabIndentTagAttributes
{
    NSColor *TabIndentTagForegroundColor = [self shouldApplyLightTheme]? [self.TabIndentDataModel.lightForegroundTagtColor colorFromSelf] : [self.TabIndentDataModel.darkForegroundTextColor colorFromSelf];
    return @{ NSFontAttributeName: [[JZFontDisplayManager sharedManager] getMonospacedFont],
              NSForegroundColorAttributeName: TabIndentTagForegroundColor};
}

- (NSDictionary<NSString *,id> *)BoldTextAttributes
{
    NSColor *BoldTextForegroundColor = [self shouldApplyLightTheme]? [self.BoldDataModel.lightForegroundTextColor colorFromSelf] : [self.BoldDataModel.darkForegroundTextColor colorFromSelf];
    NSColor *BoldTextBackgroundColor = [self shouldApplyLightTheme]? [self.BoldDataModel.lightBackgroundBlockColor colorFromSelf] : [self.BoldDataModel.darkBackgroundBlockColor colorFromSelf];
    return @{ NSFontAttributeName: [[JZFontDisplayManager sharedManager] getBoldFont],
              NSForegroundColorAttributeName: BoldTextForegroundColor,
              NSBackgroundColorAttributeName: BoldTextBackgroundColor};
}

- (NSDictionary<NSString *,id> *)BoldTagAttributes
{
    NSColor *BoldTagForegroundColor = [self shouldApplyLightTheme]? [self.BoldDataModel.lightForegroundTagtColor colorFromSelf] : [self.BoldDataModel.darkForegroundTagtColor colorFromSelf];
    NSColor *BoldTagBackgroundColor = [self shouldApplyLightTheme]? [self.BoldDataModel.lightBackgroundBlockColor colorFromSelf] : [self.BoldDataModel.darkBackgroundBlockColor colorFromSelf];
    return @{ NSFontAttributeName: [[JZFontDisplayManager sharedManager] getBoldFont],
              NSForegroundColorAttributeName: BoldTagForegroundColor,
              NSBackgroundColorAttributeName: BoldTagBackgroundColor};
}


- (NSDictionary<NSString *,id> *)ItalicTextAttributes
{
    NSColor *ItalicTextForegroundColor = [self shouldApplyLightTheme]? [self.ItalicDataModel.lightForegroundTextColor colorFromSelf] : [self.ItalicDataModel.darkForegroundTextColor colorFromSelf];
    NSColor *ItalicTextBackgroundColor = [self shouldApplyLightTheme]? [self.ItalicDataModel.lightBackgroundBlockColor colorFromSelf] : [self.ItalicDataModel.darkBackgroundBlockColor colorFromSelf];
    return @{ NSFontAttributeName: [[JZFontDisplayManager sharedManager] getItalicFont],
              NSForegroundColorAttributeName: ItalicTextForegroundColor,
              NSBackgroundColorAttributeName: ItalicTextBackgroundColor};
}

- (NSDictionary<NSString *,id> *)ItalicTagAttributes
{
    NSColor *ItalicTagForegroundColor = [self shouldApplyLightTheme]? [self.ItalicDataModel.lightForegroundTagtColor colorFromSelf] : [self.ItalicDataModel.darkForegroundTagtColor colorFromSelf];
    NSColor *ItalicTagBackgroundColor = [self shouldApplyLightTheme]? [self.ItalicDataModel.lightBackgroundBlockColor colorFromSelf] : [self.ItalicDataModel.darkBackgroundBlockColor colorFromSelf];
    return @{ NSFontAttributeName: [[JZFontDisplayManager sharedManager] getBoldFont],
              NSForegroundColorAttributeName: ItalicTagForegroundColor,
              NSBackgroundColorAttributeName: ItalicTagBackgroundColor};
}
- (NSDictionary<NSString *,id> *)StrikeThroughTextAttributes
{
    NSColor *StrikeThroughTextForegroundColor = [self shouldApplyLightTheme]? [self.ItalicDataModel.lightForegroundTextColor colorFromSelf] : [self.ItalicDataModel.darkForegroundTextColor colorFromSelf];
    NSColor *StrikeThroughTextBackgroundColor = [self shouldApplyLightTheme]? [self.ItalicDataModel.lightBackgroundBlockColor colorFromSelf] : [self.ItalicDataModel.darkBackgroundBlockColor colorFromSelf];
    return @{ NSFontAttributeName: [[JZFontDisplayManager sharedManager] getItalicFont],
              NSForegroundColorAttributeName: StrikeThroughTextForegroundColor,
              NSBackgroundColorAttributeName: StrikeThroughTextBackgroundColor,
              NSStrikethroughStyleAttributeName:
                  [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
}

- (NSDictionary<NSString *,id> *)StrikeThroughTagAttributes
{
    NSColor *StrikeThroughTagForegroundColor = [self shouldApplyLightTheme]? [self.StrikeThroughDataModel.lightForegroundTagtColor colorFromSelf] : [self.StrikeThroughDataModel.darkForegroundTagtColor colorFromSelf];
    NSColor *StrikeThroughTagBackgroundColor = [self shouldApplyLightTheme]? [self.StrikeThroughDataModel.lightBackgroundBlockColor colorFromSelf] : [self.StrikeThroughDataModel.darkBackgroundBlockColor colorFromSelf];
    return @{ NSFontAttributeName: [[JZFontDisplayManager sharedManager] getBoldFont],
              NSForegroundColorAttributeName: StrikeThroughTagForegroundColor,
              NSBackgroundColorAttributeName: StrikeThroughTagBackgroundColor};
}
- (NSDictionary<NSString *,id> *)ListTextAttributes
{
    NSColor *ListTextForegroundColor = [self shouldApplyLightTheme]? [self.ListDataModel.lightForegroundTextColor colorFromSelf] : [self.ListDataModel.darkForegroundTextColor colorFromSelf];
    NSColor *ListTextBackgroundColor = [self shouldApplyLightTheme]? [self.ListDataModel.lightBackgroundBlockColor colorFromSelf] : [self.ListDataModel.darkBackgroundBlockColor colorFromSelf];
    return @{ NSFontAttributeName: [[JZFontDisplayManager sharedManager] getFont],
              NSForegroundColorAttributeName: ListTextForegroundColor,
              NSBackgroundColorAttributeName: ListTextBackgroundColor};
}

- (NSDictionary<NSString *,id> *)ListTagAttributes
{
    NSColor *ListTagForegroundColor = [self shouldApplyLightTheme]? [self.ListDataModel.lightForegroundTagtColor colorFromSelf] : [self.ListDataModel.darkForegroundTagtColor colorFromSelf];
    NSColor *ListTagBackgroundColor = [self shouldApplyLightTheme]? [self.ListDataModel.lightBackgroundBlockColor colorFromSelf] : [self.ListDataModel.darkBackgroundBlockColor colorFromSelf];
    return @{ NSFontAttributeName: [[JZFontDisplayManager sharedManager] getBoldFont],
              NSForegroundColorAttributeName: ListTagForegroundColor,
              NSBackgroundColorAttributeName: ListTagBackgroundColor};
}
- (NSDictionary<NSString *,id> *)QuoteTextAttributes
{
    NSColor *QuoteTextForegroundColor = [self shouldApplyLightTheme]? [self.QuoteDataModel.lightForegroundTextColor colorFromSelf] : [self.QuoteDataModel.darkForegroundTextColor colorFromSelf];
    NSColor *QuoteTextBackgroundColor = [self shouldApplyLightTheme]? [self.QuoteDataModel.lightBackgroundBlockColor colorFromSelf] : [self.QuoteDataModel.darkBackgroundBlockColor colorFromSelf];
    return @{ NSFontAttributeName: [[JZFontDisplayManager sharedManager] getItalicFont],
              NSForegroundColorAttributeName: QuoteTextForegroundColor,
              NSBackgroundColorAttributeName: QuoteTextBackgroundColor};
}

- (NSDictionary<NSString *,id> *)QuoteTagAttributes
{
    NSColor *QuoteTagForegroundColor = [self shouldApplyLightTheme]? [self.QuoteDataModel.lightForegroundTagtColor colorFromSelf] : [self.QuoteDataModel.darkForegroundTagtColor colorFromSelf];
    NSColor *QuoteTagBackgroundColor = [self shouldApplyLightTheme]? [self.QuoteDataModel.lightBackgroundBlockColor colorFromSelf] : [self.QuoteDataModel.darkBackgroundBlockColor colorFromSelf];
    return @{ NSFontAttributeName: [[JZFontDisplayManager sharedManager] getBoldFont],
              NSForegroundColorAttributeName: QuoteTagForegroundColor,
              NSBackgroundColorAttributeName: QuoteTagBackgroundColor};
}
- (NSDictionary<NSString *,id> *)ImageTextAttributes
{
    NSColor *ImageTextForegroundColor = [self shouldApplyLightTheme]? [self.ImageDataModel.lightForegroundTextColor colorFromSelf] : [self.ImageDataModel.darkForegroundTextColor colorFromSelf];
    NSColor *ImageTextBackgroundColor = [self shouldApplyLightTheme]? [self.ImageDataModel.lightBackgroundBlockColor colorFromSelf] : [self.ImageDataModel.darkBackgroundBlockColor colorFromSelf];
    return @{ NSFontAttributeName: [[JZFontDisplayManager sharedManager] getItalicFont],
              NSForegroundColorAttributeName: ImageTextForegroundColor,
              NSBackgroundColorAttributeName: ImageTextBackgroundColor};
}

- (NSDictionary<NSString *,id> *)ImageTagAttributes
{
    NSColor *ImageTagForegroundColor = [self shouldApplyLightTheme]? [self.ImageDataModel.lightForegroundTagtColor colorFromSelf] : [self.ImageDataModel.darkForegroundTagtColor colorFromSelf];
    NSColor *ImageTagBackgroundColor = [self shouldApplyLightTheme]? [self.ImageDataModel.lightBackgroundBlockColor colorFromSelf] : [self.ImageDataModel.darkBackgroundBlockColor colorFromSelf];
    return @{ NSFontAttributeName: [[JZFontDisplayManager sharedManager] getBoldFont],
              NSForegroundColorAttributeName: ImageTagForegroundColor,
              NSBackgroundColorAttributeName: ImageTagBackgroundColor};
}
- (NSDictionary<NSString *,id> *)LinkTextAttributes
{
    NSColor *LinkTextForegroundColor = [self shouldApplyLightTheme]? [self.QuoteDataModel.lightForegroundTextColor colorFromSelf] : [self.QuoteDataModel.darkForegroundTextColor colorFromSelf];
    NSColor *LinkTextBackgroundColor = [self shouldApplyLightTheme]? [self.QuoteDataModel.lightBackgroundBlockColor colorFromSelf] : [self.QuoteDataModel.darkBackgroundBlockColor colorFromSelf];
    return @{ NSFontAttributeName: [[JZFontDisplayManager sharedManager] getItalicFont],
              NSForegroundColorAttributeName: LinkTextForegroundColor,
              NSBackgroundColorAttributeName: LinkTextBackgroundColor};
}

- (NSDictionary<NSString *,id> *)LinkTagAttributes
{
    NSColor *LinkTagForegroundColor = [self shouldApplyLightTheme]? [self.QuoteDataModel.lightForegroundTagtColor colorFromSelf] : [self.QuoteDataModel.darkForegroundTagtColor colorFromSelf];
    NSColor *LinkTagBackgroundColor = [self shouldApplyLightTheme]? [self.QuoteDataModel.lightBackgroundBlockColor colorFromSelf] : [self.QuoteDataModel.darkBackgroundBlockColor colorFromSelf];
    return @{ NSFontAttributeName: [[JZFontDisplayManager sharedManager] getBoldFont],
              NSForegroundColorAttributeName: LinkTagForegroundColor,
              NSBackgroundColorAttributeName: LinkTagBackgroundColor};
}
@end
