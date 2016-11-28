//
//  JZEditorTextView.m
//  Cetacea-Mac
//
//  Created by Fincher Justin on 16/7/6.
//  Copyright © 2016年 JustZht. All rights reserved.
//

#import "JZEditorTextView.h"
#import "JZEditorHighlightThemeManager.h"
#import "JZHeader.h"

@implementation JZEditorTextView

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    // Drawing code here.
    
}

- (id)init
{
    if (self = [super init])
    {
        _hasSetup = NO;
    }
    return self;
}
- (id)initWithCoder:(NSCoder *)coder
{
    if (self = [super initWithCoder:coder])
    {
        _hasSetup = NO;
    }
    return self;
}
- (id)initWithFrame:(NSRect)frameRect
{
    if (self = [super initWithFrame:frameRect])
    {
        _hasSetup = NO;
    }
    return self;
}

- (void)setupTextView
{
    
    _hasSetup = YES;
    JZLog(@"setupTextView");
    self.automaticDashSubstitutionEnabled = NO;
    if (self.enclosingScrollView)
    {
        self.enclosingScrollView.verticalRulerView = [[JZEditorRulerView alloc] initWithScrollView:self.enclosingScrollView
                                                                                       orientation:NSVerticalRuler];
        self.enclosingScrollView.verticalRulerView.clientView = self;
        self.enclosingScrollView.hasVerticalRuler = YES;
        self.enclosingScrollView.rulersVisible = YES;
    }
    JZEditorLayouManager *layoutManager = [[JZEditorLayouManager alloc] init];
    [self.textContainer replaceLayoutManager:layoutManager];
    
    self.allowsDocumentBackgroundColorChange = YES;
    self.layoutManager.allowsNonContiguousLayout = YES;
    
    self.enclosingScrollView.rulersVisible = YES;
}

- (void)viewDidMoveToWindow
{
    if (!_hasSetup)
    {
        [self setupTextView];
    }
}
- (void)refreshHightLight
{
    if (self.string)
    {
        NSRange range = self.selectedRange;
//        [self.parser refreshAttributesTheme];
        NSAttributedString *attStr = [self.parser attributedStringFromMarkdown:self.string];
        [self.textStorage setAttributedString: attStr];
        [self setSelectedRange:NSMakeRange(range.location, 0)];
    }
    
     [self setWantsLayer:YES];
    NSColor *color = [[self.parser.themeDoc getData] getBackgroundColor];
    [self setBackgroundColor:color];
}
- (void)updateRuler
{
    [super updateRuler];
    self.enclosingScrollView.verticalRulerView.needsDisplay = YES;
}
- (void)dealloc
{
}

@end
