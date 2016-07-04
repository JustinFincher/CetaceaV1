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


@interface JZEditorViewController ()<NSTextViewDelegate>


@property (nonatomic) NSRange range;
@property (nonatomic,strong) JZEditorLayouManager *layoutManager;

@end

@implementation JZEditorViewController
@synthesize editorTextView,editorScrollView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    self.editorTextView.delegate = self;
    
    /**
     设置 NSLAYOUTMANAGER 的正确姿势 ： 设置 textContainer 的 LayoutManager
     不要去设置 Storage...
     */
    self.layoutManager = [[JZEditorLayouManager alloc] init];
    [self.editorTextView.textContainer replaceLayoutManager:self.layoutManager];
    
    
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
}

- (void)setCurrentEditingMarkdown:(JZiCloudMarkdownFileModel *)currentEditingMarkdown
{
    NSError *error;
    self.editorTextView.string = [NSString stringWithContentsOfFile:[currentEditingMarkdown.url path] encoding:NSUTF8StringEncoding error:&error];
    if (error)
    {
        NSLog(@"%@",[error localizedDescription]);
    }
    [[JZEditorMarkdownTextParserWithTSBaseParser sharedManager] refreshAttributesTheme];
    [self refreshHightLight];
}
- (void)dayNightThemeSwitched:(NSNotification *)aNotification
{
    [[JZEditorMarkdownTextParserWithTSBaseParser sharedManager] refreshAttributesTheme];
    [self refreshHightLight];
}
- (void)baseFontChanged:(NSNotification *)aNotification
{
    [[JZEditorMarkdownTextParserWithTSBaseParser sharedManager] refreshAttributesTheme];
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
    [self refreshHightLight];
}
- (void)refreshHightLight
{
    self.range = self.editorTextView.selectedRange;
    NSLog(@"________________________________");
    NSLog(@"RANGE : %lu,%lu",(unsigned long)self.range.location,(unsigned long)self.range.length);
    [self.editorTextView.textStorage setAttributedString: [[JZEditorMarkdownTextParserWithTSBaseParser sharedManager] attributedStringFromMarkdown:self.editorTextView.string]];
    [self.editorTextView setSelectedRange:NSMakeRange(self.range.location, 0)];
    NSLog(@"RANGE : %lu,%lu",(unsigned long)self.editorTextView.selectedRange.location,(unsigned long)self.editorTextView.selectedRange.length);

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
    
    [vc loadURL:(NSURL *)link];
    return YES;
}
@end
