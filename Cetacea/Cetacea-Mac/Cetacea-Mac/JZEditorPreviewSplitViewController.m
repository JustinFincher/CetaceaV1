//
//  JZEditorPreviewSplitViewController.m
//  Cetacea-Mac
//
//  Created by Fincher Justin on 16/6/27.
//  Copyright © 2016年 JustZht. All rights reserved.
//

#import "JZEditorPreviewSplitViewController.h"
#import "JZPreviewViewController.h"
#import "JZEditorViewController.h"
#import "JZEditorPreviewSplitViewForegroundBlurViewController.h"
#import "JZdayNightThemeManager.h"
#import "JZiCloudFileExtensionCetaceaDataBase.h"

@interface JZEditorPreviewSplitViewController ()

@property (nonatomic,strong) JZPreviewViewController* previewVC;
@property (nonatomic,strong) JZEditorViewController* editorVC;
@property (nonatomic,strong) JZEditorPreviewSplitViewForegroundBlurViewController *foregroundVC;

@property (nonatomic) int refreshHighLightCounter;
@property (nonatomic,strong) NSTimer *refreshHighLightTimer;

@property () BOOL isSwitchingDocumentFlag;

@end

@implementation JZEditorPreviewSplitViewController
@synthesize foregroundVC;
@synthesize refreshHighLightCounter,refreshHighLightTimer;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    
    self.isSwitchingDocumentFlag = NO;
    
    [self.previewSplitViewItem setCanCollapse:YES];
    [self.editorSplitViewItem setCanCollapse:YES];
    _previewVC = (JZPreviewViewController *)(self.previewSplitViewItem.viewController);
    _editorVC = (JZEditorViewController *)(self.editorSplitViewItem.viewController);
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(markdownEditorTextDidChanged:)
                                                 name:@"markdownEditorTextDidChanged"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(addNewButtonPressed:)
                                                 name:@"addNewButtonPressedNotification"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(editPreviewSwithSegmentSelectedNotification:)
                                                 name:@"editPreviewSwithSegmentSelectedNotification"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(dayNightThemeSwitched:)
                                                 name:@"dayNightThemeSwitched"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(splitViewWillResizeSubviews:)
                                                 name:NSSplitViewWillResizeSubviewsNotification
                                               object:self.splitView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(splitViewDidResizeSubviews:)
                                                 name:NSSplitViewDidResizeSubviewsNotification
                                               object:self.splitView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(markdownListSelectionChanged:)
                                                 name:@"markdownListSelectionChanged"
                                               object:nil];
    
    
    foregroundVC = [[JZEditorPreviewSplitViewForegroundBlurViewController alloc] init];
    [self.view addSubview:foregroundVC.view];
    [foregroundVC.view setFrameSize:self.view.frame.size];
    [foregroundVC.view setAutoresizingMask:NSViewWidthSizable | NSViewHeightSizable];
    
    refreshHighLightCounter = 0;
    refreshHighLightTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(refreshHighLightTimerFired:) userInfo:nil repeats:YES];

    [self.editorSplitViewItem setCollapseBehavior:NSSplitViewItemCollapseBehaviorUseConstraints];
    [self.previewSplitViewItem setCollapseBehavior:NSSplitViewItemCollapseBehaviorUseConstraints];
}
- (void)viewWillAppear
{
    [self refreshEditPreviewBackgroundView];
}

- (void)refreshHighLightTimerFired:(NSTimer *)timer
{
    if (refreshHighLightCounter > 0)
    {
        [self.editorVC refreshHighLight];
        [self.previewVC refreshPreview];
        
        refreshHighLightCounter = 0;
    }
}


#pragma mark - Text Editing
- (void)setCurrentEditingMarkdown:(JZiCloudFileExtensionCetaceaDocument *)currentEditingMarkdown
{
    if (currentEditingMarkdown == nil)
    {
        _currentEditingMarkdown = nil;
        if (foregroundVC.view.hidden)
        {
            [foregroundVC.view setHidden:NO];
            [_editorVC setCurrentEditingMarkdown:nil];
            [_previewVC setCurrentEditingMarkdown:nil];
        }
    }else
    {
        self.isSwitchingDocumentFlag = YES;
        if (![_currentEditingMarkdown isEqualToDocument:currentEditingMarkdown])
        {
            _currentEditingMarkdown = currentEditingMarkdown;
            [_editorVC setCurrentEditingMarkdown:currentEditingMarkdown];
            [_previewVC setCurrentEditingMarkdown:currentEditingMarkdown];
        }
        if (!foregroundVC.view.hidden)
        {
            [foregroundVC.view setHidden:YES];
        }
        self.isSwitchingDocumentFlag = NO;
    }
}
- (void)markdownListSelectionChanged:(NSNotification *) notification
{
    JZiCloudFileExtensionCetaceaDocument * doc = notification.userInfo[@"newValue"];
    [self setCurrentEditingMarkdown:doc];
}

- (void)markdownEditorTextDidChanged:(NSNotification *) notification
{
    if (!self.isSwitchingDocumentFlag)
    {
        self.currentEditingMarkdown.markdownString = _editorVC.editorTextView.string;
        self.currentEditingMarkdown.highLightString = _editorVC.editorTextView.attributedString;
        self.currentEditingMarkdown.title = [self.currentEditingMarkdown.markdownString substringWithRange:[self.currentEditingMarkdown.markdownString lineRangeForRange:NSMakeRange(0, 0)]];
        
        [self.currentEditingMarkdown saveCetaceaDocument];
        
        refreshHighLightCounter++;
    }
}
- (void)addNewButtonPressed:(NSNotification *) notification
{
    JZiCloudFileExtensionCetaceaDocument *doc = [JZiCloudFileExtensionCetaceaDocument newCetaceaDocument];
    if (doc)
    {
        [self setCurrentEditingMarkdown:doc];
    }
}


#pragma mark - UI
- (void)editPreviewSwithSegmentSelectedNotification:(NSNotification *) notification
{
    
    NSDictionary *dict = [notification userInfo];
    NSNumber * selectNumber = (NSNumber *)[dict valueForKey:@"selectedSegment"];
    switch ([selectNumber integerValue])
    {
        case 2:
        {
            [self.editorSplitViewItem setCollapsed:YES];
            [self.previewSplitViewItem setCollapsed:NO];
        }
            break;
        case 1:
        {
            [self.editorSplitViewItem setCollapsed:NO];
            [self.previewSplitViewItem setCollapsed:NO];
        }
            break;
        case 0:
        {
            [self.editorSplitViewItem setCollapsed:NO];
            [self.previewSplitViewItem setCollapsed:YES];
        }
    }
    [self.splitView adjustSubviews];

}
- (void)dayNightThemeSwitched:(NSNotification *) notification
{
    [self refreshEditPreviewBackgroundView];
}
- (void)refreshEditPreviewBackgroundView
{
    NSVisualEffectView *editVisualView = (NSVisualEffectView *)(_editorVC.view);
    NSVisualEffectView *previewVisualView = (NSVisualEffectView *)(_previewVC.view);
    if ([[JZdayNightThemeManager sharedManager] getEditPreviewPanelShouldUsingBlurredBackground])
    {
        [editVisualView setState:NSVisualEffectStateActive];
        [previewVisualView setState:NSVisualEffectStateActive];
    }else
    {
        [editVisualView setState:NSVisualEffectStateInactive];
        [previewVisualView setState:NSVisualEffectStateInactive];
    }
}
- (BOOL)isLeftEditorViewCollapsed
{
    return _editorSplitViewItem.collapsed;
}
- (BOOL)isRightPreviewViewCollapsed
{
    return _previewSplitViewItem.collapsed;
}
- (void)splitViewWillResizeSubviews:(NSNotification *)notification
{
    
}
- (void)splitViewDidResizeSubviews:(NSNotification *)notification
{

}
- (NSRect)splitView:(NSSplitView *)splitView effectiveRect:(NSRect)proposedEffectiveRect forDrawnRect:(NSRect)drawnRect ofDividerAtIndex:(NSInteger)dividerIndex
{
    if (splitView == self.splitView)
    {
        // make divider not draggable
        return NSZeroRect;
    }
    return [super splitView:splitView effectiveRect:proposedEffectiveRect forDrawnRect:drawnRect ofDividerAtIndex:dividerIndex];
}

@end
