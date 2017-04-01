//
//  JZEditorViewController.m
//  Cetacea-Mac
//
//  Created by Fincher Justin on 16/6/27.
//  Copyright © 2016年 JustZht. All rights reserved.
//

#import "JZEditorViewController.h"
#import "JZFontDisplayManager.h"

#import "JZEditorMarkdownTextParserWithTSBaseParser.h"
#import "JZEditorLinkPopoverContentViewController.h"
#import "JZEditorLayouManager.h"

#import "JZEditorRulerView.h"
#import "JZEditorHighlightThemeManager.h"

#import "JZHeader.h"

@interface JZEditorViewController ()<NSTextViewDelegate>


@property (nonatomic) NSRange range;
@property (nonatomic,strong) JZEditorLayouManager *layoutManager;
@property (nonatomic,strong) JZEditorRulerView *ruleView;


@end

@implementation JZEditorViewController
@synthesize editorTextView,editorScrollView,ruleView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    
    self.editorTextView.delegate = self;
    self.editorTextView.wantsLayer = YES;
    self.editorTextView.parser = [[JZEditorMarkdownTextParserWithTSBaseParser alloc] init];

    self.editorTextView.linkTextAttributes = @{ NSForegroundColorAttributeName: [[JZFontDisplayManager sharedManager] getLinkForegroundColor],
                                                NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle)};
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(baseFontChanged:)
                                                 name:@"baseFontChanged"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(dayNightThemeSwitched:)
                                                 name:@"dayNightThemeSwitched"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(themeChangedOnHighLightEditView:)
                                                 name:@"themeChangedOnHighLightEditView"
                                               object:nil];
    [self.editorTextView refreshHightLight];
}
- (void)viewDidAppear
{
    [self.view setAutoresizingMask:NSViewWidthSizable | NSViewHeightSizable];
    [self.editorTextView setAutoresizingMask:NSViewWidthSizable | NSViewHeightSizable];
    self.editorScrollView.rulersVisible = YES;
    [self.editorTextView setNeedsLayout:YES];
     self.editorTextView.layoutManager.allowsNonContiguousLayout = YES;
}

- (void)setCurrentEditingMarkdown:(JZiCloudFileExtensionCetaceaDocument *)currentEditingMarkdown
{
//    [self.editorTextView.textStorage setAttributedString:currentEditingMarkdown.highLightString];
    [self.editorTextView setString:currentEditingMarkdown.markdownString];
    [self.editorTextView.parser refreshAttributesTheme];
    [self.editorTextView refreshHightLight];
    [self updateStatView];
}
- (void)dayNightThemeSwitched:(NSNotification *)aNotification
{
    [self.editorTextView.parser refreshAttributesTheme];
    [self.editorTextView  refreshHightLight];
}
- (void)baseFontChanged:(NSNotification *)aNotification
{
    [self.editorTextView.parser refreshAttributesTheme];
    [self.editorTextView  refreshHightLight];
}
- (void)themeChangedOnHighLightEditView:(NSNotification *)aNotification
{
    self.editorTextView.parser.themeDoc = [[JZEditorHighlightThemeManager sharedManager] selectedDoc];
    [self.editorTextView.parser refreshAttributesTheme];
    [self.editorTextView  refreshHightLight];
    [self.editorTextView updateRuler];
}
- (void)refreshHighLight
{
    [self.editorTextView refreshHightLight];
}


#pragma mark - NSTextViewDelegate
/**
 *  this delegate called when TextView 's text have delete or input
 *
 *  @param notification NSNotification
 */
-(void)textDidChange:(NSNotification *)notification
{
    [[NSNotificationCenter defaultCenter] postNotificationName: @"markdownEditorTextDidChanged" object:nil userInfo:nil];
    [self updateStatView];
    
}

- (void)updateStatView
{
    __block int wordCount = 0;
    __block int charCount = 0;
    [self.editorTextView.string enumerateSubstringsInRange:NSMakeRange(0, [self.editorTextView.string length])
                                                   options:NSStringEnumerationByWords
                                                usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                                    wordCount += 1;
                                                    charCount += substringRange.length;
                                                }];
    NSLog(@"%d", wordCount); // Output: 4
    NSLog(@"%d", charCount); // Output: 16
    self.editorBottomStatLabel.stringValue = [NSString stringWithFormat:@"%d words, %d chars",wordCount,charCount];
}

- (void)textView:(NSTextView *)textView
   clickedOnCell:(id<NSTextAttachmentCell>)cell
          inRect:(NSRect)cellFrame
         atIndex:(NSUInteger)charIndex
{
    
}
- (BOOL)textView:(NSTextView *)aTextView
   clickedOnLink:(id)link
         atIndex:(NSUInteger)charIndex
{
    NSPopover *linkPopover = [[NSPopover alloc] init];
    JZEditorLinkPopoverContentViewController *vc = [[JZEditorLinkPopoverContentViewController alloc] init];
    NSRect rect = [self.editorTextView firstRectForCharacterRange:NSMakeRange(charIndex, 1) actualRange:nil];
    NSRect windowRect =  [self.editorTextView.window convertRectFromScreen:rect];
    NSPoint viewPoint  = [self.editorTextView convertPoint:windowRect.origin fromView: nil];
    vc.parentPopover = linkPopover;
    [linkPopover setContentSize:NSMakeSize(300.0f, 200.0f)];
    linkPopover.contentViewController = vc;
    linkPopover.behavior = NSPopoverBehaviorTransient;
    [linkPopover showRelativeToRect:NSMakeRect(viewPoint.x, viewPoint.y - [[JZFontDisplayManager sharedManager] getFontSize], windowRect.size.width, windowRect.size.height) ofView:aTextView preferredEdge:NSMinYEdge];
    
        
    [vc proccessURL:(NSURL *)link];
    return YES;
}
#pragma mark - RulerView

@end
