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
#import "JZHeader.h"

@interface JZEditorPreviewSplitViewController ()

@property (nonatomic,strong) JZPreviewViewController* previewVC;
@property (nonatomic,strong) JZEditorViewController* editorVC;
@property (nonatomic,strong) JZEditorPreviewSplitViewForegroundBlurViewController *foregroundVC;

@property (nonatomic) int refreshHighLightCounter;
@property (nonatomic,strong) NSTimer *refreshHighLightTimer;

@end

@implementation JZEditorPreviewSplitViewController
@synthesize foregroundVC;
@synthesize refreshHighLightCounter,refreshHighLightTimer;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
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
    
    
    foregroundVC = [[JZEditorPreviewSplitViewForegroundBlurViewController alloc] init];
    [self.view addSubview:foregroundVC.view];
    [foregroundVC.view setFrameSize:self.view.frame.size];
    [foregroundVC.view setAutoresizingMask:NSViewWidthSizable | NSViewHeightSizable];
    
    refreshHighLightCounter = 0;
    refreshHighLightTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(refreshHighLightTimerFired:) userInfo:nil repeats:YES];

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
- (void)setCurrentEditingMarkdown:(JZiCloudFileExtensionCetaceaDoc *)currentEditingMarkdown
{
    if (![_currentEditingMarkdown isEqualToDoc:currentEditingMarkdown])
    {
        _currentEditingMarkdown = currentEditingMarkdown;
        [_editorVC setCurrentEditingMarkdown:currentEditingMarkdown];
        [_previewVC setCurrentEditingMarkdown:currentEditingMarkdown];
    }
    if (!foregroundVC.view.hidden)
    {
        [foregroundVC.view setHidden:YES];
    }
    
}


- (void)markdownEditorTextDidChanged:(NSNotification *) notification
{
    
    if (_editorVC.editorTextView)
    {
        NSOperationQueue *myQueue = [[NSOperationQueue alloc] init];
        [myQueue addOperationWithBlock:^{
            
            // Background work
            self.currentEditingMarkdown.data.markdownString = _editorVC.editorTextView.string;
            self.currentEditingMarkdown.data.highLightString = _editorVC.editorTextView.attributedString;
            self.currentEditingMarkdown.data.updateDate = [NSDate new];
            self.currentEditingMarkdown.data.title = [_editorVC.editorTextView.string substringWithRange:[_editorVC.editorTextView.string lineRangeForRange:NSMakeRange(0, 0)]];
            [self.currentEditingMarkdown saveData];
            
            [[NSOperationQueue mainQueue] addOperationWithBlock:^
             {
                 JZLog(@"Text Changed and Saved. RefreshHighLightCounter ++ ")
                 refreshHighLightCounter++;
             }];
        }];
    }
}
- (void)addNewButtonPressed:(NSNotification *) notification
{
    if (_editorVC.editorTextView)
    {
        NSString *docPath = [[JZiCloudFileExtensionCetaceaDataBase sharedManager] nextDocPath];
        JZiCloudFileExtensionCetaceaDoc *doc = [[JZiCloudFileExtensionCetaceaDoc alloc] initWithDocPath:docPath];
        doc.data.markdownString = @"";
        doc.data.createDate = [NSDate new];
        doc.data.updateDate = [NSDate new];
        doc.data.title = @"";
        doc.data.highLightString = [[NSAttributedString alloc] initWithString:@""];
        [doc saveData];
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

@end
