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
//        NSAttributedString *attStr = [self.parser attributedStringFromMarkdown:self.string];
//        [self.textStorage setAttributedString: attStr];
        
         [self.textStorage setAttributedString: [self proccessTextWithVisibleRectOnly]];
        [self setSelectedRange:NSMakeRange(range.location, 0)];
    }
    
     [self setWantsLayer:YES];
    NSColor *color = [[self.parser.themeDoc getData] getBackgroundColor];
    [self setBackgroundColor:color];
}

- (NSAttributedString *)proccessTextWithVisibleRectOnly
{
    NSRange range = [self characterRangeFromVisibleRect];
    NSMutableAttributedString *finalAttString;
    
    
    NSAttributedString *attStrWithinVisiableRange = [self.parser attributedStringFromMarkdown:[self.string substringWithRange:range]];
    finalAttString = [attStrWithinVisiableRange mutableCopy];
    
    if (range.location != 0 )
    {
        // before
        NSMutableAttributedString *attStrBeforeVisiableRange = [[[NSAttributedString alloc] initWithString:[self.string substringWithRange:NSMakeRange(0, range.location)] attributes:self.parser.defaultAttributes] mutableCopy];
        
        [attStrBeforeVisiableRange appendAttributedString:attStrWithinVisiableRange];
        finalAttString = attStrBeforeVisiableRange;
    }
    
    if (range.length + range.location < [self.string length])
    {
        // after
        NSMutableAttributedString *attStrAfterVisiableRange = [[[NSAttributedString alloc] initWithString:[self.string substringWithRange:NSMakeRange(range.length + range.location, [self.string length] - range.length - range.location)] attributes:self.parser.defaultAttributes] mutableCopy];
        [finalAttString appendAttributedString:attStrAfterVisiableRange];
    }
    
    return finalAttString;
}

- (NSRange)characterRangeFromVisibleRect
{
    return [self characterRangeForRect: [self visibleRect]];
}

- (NSRange)characterRangeForRect:(NSRect)aRect
{
    NSRange glyphRange, charRange;
    NSLayoutManager *layoutManager = [self
                                      layoutManager];
    NSTextContainer *textContainer = [self
                                      textContainer];
    NSPoint containerOrigin = [self
                               textContainerOrigin];
    
    // Convert from view coordinates to container coordinates
    aRect = NSOffsetRect(aRect, -containerOrigin.x,
                         -containerOrigin.y);
    
    glyphRange = [layoutManager
                  glyphRangeForBoundingRect:aRect
                  inTextContainer:textContainer];
    charRange = [layoutManager
                 characterRangeForGlyphRange:glyphRange
                 actualGlyphRange:NULL];
    
    return charRange;
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
