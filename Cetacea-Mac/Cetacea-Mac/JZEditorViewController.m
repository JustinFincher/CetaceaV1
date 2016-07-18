//
//  JZEditorViewController.m
//  Cetacea-Mac
//
//  Created by Fincher Justin on 16/6/27.
//  Copyright © 2016年 JustZht. All rights reserved.
//

#import "JZEditorViewController.h"
#import "JZEditorMarkdownTextStorage.h"
#import "JZFontDisplayManager.h"

#import "JZEditorMarkdownTextParserWithTSBaseParser.h"
#import "JZEditorLinkPopoverContentViewController.h"
#import "JZEditorLayouManager.h"

#import "JZEditorRulerView.h"
#import "JZEditorHighlightThemeManager.h"

@interface JZEditorViewController ()<NSTextViewDelegate>


@property (nonatomic) NSRange range;
@property (nonatomic,strong) JZEditorLayouManager *layoutManager;
@property (nonatomic,strong) JZEditorRulerView *ruleView;

@property (nonatomic) int refreshHighLightCounter;
@property (nonatomic,strong) NSTimer *refreshHighLightTimer;
@end

@implementation JZEditorViewController
@synthesize editorTextView,editorScrollView,ruleView;
@synthesize refreshHighLightCounter,refreshHighLightTimer;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    refreshHighLightCounter = 0;
    self.editorTextView.delegate = self;
    self.editorTextView.wantsLayer = YES;
    self.editorTextView.parser = [[JZEditorMarkdownTextParserWithTSBaseParser alloc] init];
    
    refreshHighLightTimer = [NSTimer scheduledTimerWithTimeInterval:0.5f target:self selector:@selector(refreshHighLightTimerFired:) userInfo:nil repeats:YES];

//    
//    self.ruleView = [[JZEditorRulerView alloc] initWithScrollView:self.editorScrollView
//                                                      orientation:NSVerticalRuler];
//    self.editorTextView.rulerView = self.ruleView;
//    self.editorTextView.automaticDashSubstitutionEnabled = NO;
//    self.ruleView.clientView = self.editorTextView;
//    self.editorScrollView.verticalRulerView = self.ruleView;
//    self.editorScrollView.hasVerticalRuler = YES;
//    self.editorScrollView.rulersVisible = YES;
//    
//    
////    BOOL is1 = self.ruleView.isFlipped ;
////    BOOL is2 = self.editorScrollView.isFlipped ;
//
//    /**
//     设置 NSLAYOUTMANAGER 的正确姿势 ： 设置 textContainer 的 LayoutManager
//     不要去设置 Storage...
//     */
//    self.layoutManager = [[JZEditorLayouManager alloc] init];
//    [self.editorTextView.textContainer replaceLayoutManager:self.layoutManager];
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
    [self refreshHightLight];
}
- (void)viewDidAppear
{
    [self.view setAutoresizingMask:NSViewWidthSizable | NSViewHeightSizable];
    [self.editorTextView setAutoresizingMask:NSViewWidthSizable | NSViewHeightSizable];
    self.editorScrollView.rulersVisible = YES;
    [self.editorTextView setNeedsLayout:YES];
     self.editorTextView.layoutManager.allowsNonContiguousLayout = YES;
}
- (void)refreshHighLightTimerFired:(NSTimer *)timer
{
    if (refreshHighLightCounter > 0)
    {
        [self refreshHightLight];
        refreshHighLightCounter = 0;
    }
}

- (void)setCurrentEditingMarkdown:(JZiCloudFileExtensionCetaceaDoc *)currentEditingMarkdown
{
//    NSError *error;
//    self.editorTextView.string = [NSString stringWithContentsOfFile:[currentEditingMarkdown.url path] encoding:NSUTF8StringEncoding error:&error];
//    if (error)
//    {
//        NSLog(@"%@",[error localizedDescription]);
//    }
    [self.editorTextView.textStorage setAttributedString:currentEditingMarkdown.data.highLightString];
    [self.editorTextView.parser refreshAttributesTheme];
    [self refreshHightLight];
}
- (void)dayNightThemeSwitched:(NSNotification *)aNotification
{
    [self.editorTextView.parser refreshAttributesTheme];
    [self refreshHightLight];
}
- (void)baseFontChanged:(NSNotification *)aNotification
{
    [self.editorTextView.parser refreshAttributesTheme];
    [self refreshHightLight];
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
    refreshHighLightCounter++;
}
- (void)refreshHightLight
{
    self.range = self.editorTextView.selectedRange;
    //NSLog(@"________________________________");
    //NSLog(@"RANGE : %lu,%lu",(unsigned long)self.range.location,(unsigned long)self.range.length);
    [self.editorTextView.textStorage setAttributedString: [self.editorTextView.parser attributedStringFromMarkdown:self.editorTextView.string]];
    [self.editorTextView setSelectedRange:NSMakeRange(self.range.location, 0)];
    //NSLog(@"RANGE : %lu,%lu",(unsigned long)self.editorTextView.selectedRange.location,(unsigned long)self.editorTextView.selectedRange.length);

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
