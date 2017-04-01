//
//  JZHighlighThemePreviewCollectionViewItem.m
//  Cetacea-Mac
//
//  Created by Fincher Justin on 16/7/8.
//  Copyright © 2016年 JustZht. All rights reserved.
//

#import "JZHeader.h"
#import "JZHighlighThemePreviewCollectionViewItem.h"
#import "JZEditorMarkdownTextParserWithTSBaseParser.h"
#import "DynamicColor-Swift.h"

@interface JZHighlighThemePreviewCollectionViewItem ()

@property (nonatomic,strong) NSShadow *shadow;
@property (weak) IBOutlet NSView *shadowView;

@end

@implementation JZHighlighThemePreviewCollectionViewItem

- (void)initWithTheme:(JZiCloudFileExtensionCetaceaThemeDoc *)doc
            themeName:(NSString *)string
{
    [_themePreviewTextView setEditable:NO];
    _themePreviewScrollView.hasVerticalScroller = NO;
    [_themePreviewScrollView setWantsLayer:YES];
    _themePreviewScrollView.layer.masksToBounds = YES;
    
    if (self.shadow == nil)
    {
        self.shadow = [[NSShadow alloc] init];
    }
    [self.shadow setShadowOffset:NSMakeSize(0, -3.0)];
    [self.shadow setShadowBlurRadius:10.0f];
    self.shadow.shadowColor = [JZColor blackColor];
    
    [self.shadowView setWantsLayer:YES];
    self.shadowView.layer.backgroundColor = [NSColor whiteColor].CGColor;
    self.shadowView.layer.masksToBounds = NO;
    [self.shadowView setShadow:self.shadow];
    
    self.themeName.stringValue = string;
    
    JZColor *color = [doc.getData getBackgroundColor];
    _shadow.shadowColor = [color isLight] ? [color darkened:0.2] : [color lighter:0.2];
    
    //high light
    _themePreviewTextView.string = JZ_MARKDOWN_SAMPLE_TEXT;
    _themePreviewTextView.parser = [[JZEditorMarkdownTextParserWithTSBaseParser alloc] init];
    _themePreviewTextView.parser.themeDoc = doc;
    [_themePreviewTextView.parser refreshAttributesTheme];
    [_themePreviewTextView.textStorage setAttributedString: [_themePreviewTextView.parser attributedStringFromMarkdown:_themePreviewTextView.string]];
    [_themePreviewScrollView.layer setCornerRadius:5.0f];
    _themePreviewScrollView.layer.masksToBounds = YES;
    [_themePreviewScrollView.contentView setWantsLayer:YES];
    //[_themePreviewScrollView.contentView.layer setCornerRadius:5.0f];
    [_themePreviewTextView refreshHightLight];
    

}
@end
