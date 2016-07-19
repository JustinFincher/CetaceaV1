//
//  JZHighlighThemePreviewCollectionViewItem.m
//  Cetacea-Mac
//
//  Created by Fincher Justin on 16/7/8.
//  Copyright © 2016年 JustZht. All rights reserved.
//

#import "JZHighlighThemePreviewCollectionViewItem.h"
#import "JZEditorMarkdownTextParserWithTSBaseParser.h"

@interface JZHighlighThemePreviewCollectionViewItem ()

@property (nonatomic,strong) NSShadow *shadow;
@property (weak) IBOutlet NSView *shadowView;

@end

@implementation JZHighlighThemePreviewCollectionViewItem

- (void)initWithisAddButton:(BOOL)isAdd
                      Theme:(JZiCloudFileExtensionCetaceaThemeDoc *)doc
                  themeName:(NSString *)string
{
    [_themePreviewTextView setEditable:NO];
    _themePreviewScrollView.hasVerticalScroller = NO;
    [_themePreviewScrollView setWantsLayer:YES];
    _themePreviewScrollView.layer.masksToBounds = YES;
    
    if (_shadow == nil)
    {
        _shadow = [[NSShadow alloc] init];
    }
    [_shadow setShadowOffset:NSMakeSize(0, -3.0)];
    [_shadow setShadowBlurRadius:10.0f];
    if (isAdd)
    {
        self.themeName.stringValue = @"Add New";
        _themePreviewTextView.string = @"Add New Markdown Theme Here";
        _shadow.shadowColor = [NSColor blackColor];
    }else
    {
        self.themeName.stringValue = string;
        _shadow.shadowColor = [doc.getData getBackgroundColor];
        //high light
        _themePreviewTextView.string = @"# About Cetacea\nCetacea is a `markdown editor` **designed** *to* ~~make~~ writing things simple, with various themes and multi-platform sync.";
        _themePreviewTextView.parser = [[JZEditorMarkdownTextParserWithTSBaseParser alloc] init];
        _themePreviewTextView.parser.themeDoc = doc;
        [_themePreviewTextView.parser refreshAttributesTheme];
        [_themePreviewTextView.textStorage setAttributedString: [_themePreviewTextView.parser attributedStringFromMarkdown:_themePreviewTextView.string]];
    }

    [self.shadowView setWantsLayer:YES];
    self.shadowView.layer.backgroundColor = [NSColor whiteColor].CGColor;
    self.shadowView.layer.masksToBounds = NO;
    [self.shadowView setShadow:_shadow];
    [_themePreviewScrollView.layer setCornerRadius:5.0f];
    _themePreviewScrollView.layer.masksToBounds = YES;
    [_themePreviewScrollView.contentView setWantsLayer:YES];
    //[_themePreviewScrollView.contentView.layer setCornerRadius:5.0f];
    [_themePreviewTextView refreshHightLight];
    

}
@end
