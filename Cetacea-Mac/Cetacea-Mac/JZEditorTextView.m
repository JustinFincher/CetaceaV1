//
//  JZEditorTextView.m
//  Cetacea-Mac
//
//  Created by Fincher Justin on 16/7/6.
//  Copyright © 2016年 JustZht. All rights reserved.
//

#import "JZEditorTextView.h"
#import "JZEditorHighlightThemeManager.h"

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
//    [self setWantsLayer:YES];
//    [self.layer setBackgroundColor:[[NSColor blueColor] CGColor]];


    self.automaticDashSubstitutionEnabled = NO;
    if (self.enclosingScrollView)
    {
        self.rulerView = [[JZEditorRulerView alloc] initWithScrollView:self.enclosingScrollView
                                                           orientation:NSVerticalRuler];
        self.rulerView.clientView = self;
        self.enclosingScrollView.verticalRulerView = self.rulerView;
        self.enclosingScrollView.hasVerticalRuler = YES;
        self.enclosingScrollView.rulersVisible = YES;
    }
    JZEditorLayouManager *layoutManager = [[JZEditorLayouManager alloc] init];
    [self.textContainer replaceLayoutManager:layoutManager];
    
    _hasSetup = YES;
}
- (void)viewDidMoveToSuperview
{
    if (!_hasSetup)
    {
        [self setupTextView];
    }
}

- (void)updateRuler
{
    [super updateRuler];
    self.rulerView.needsDisplay = YES;
}

@end
