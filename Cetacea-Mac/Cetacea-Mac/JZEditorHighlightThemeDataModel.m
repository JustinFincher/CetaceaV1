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
    return @{ NSFontAttributeName: [[JZFontDisplayManager sharedManager] getFont],
              NSForegroundColorAttributeName: CodeBlockTextForegroundColor,
              NSBackgroundColorAttributeName: CodeBlockTextBackgroundColor};
}

- (NSDictionary<NSString *,id> *)CodeBlockTagAttributes
{
    NSColor *CodeBlockTagForegroundColor = [self shouldApplyLightTheme]? [self.CodeBlockDataModel.lightForegroundTagtColor colorFromSelf] : [self.CodeBlockDataModel.darkForegroundTagtColor colorFromSelf];
    return @{ NSFontAttributeName: [[JZFontDisplayManager sharedManager] getFont],
              NSForegroundColorAttributeName: CodeBlockTagForegroundColor};
}


@end
