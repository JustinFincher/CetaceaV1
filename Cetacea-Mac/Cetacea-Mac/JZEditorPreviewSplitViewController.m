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

@interface JZEditorPreviewSplitViewController ()

@property (nonatomic,strong) JZPreviewViewController* previewVC;
@property (nonatomic,strong) JZEditorViewController* editorVC;

@end

@implementation JZEditorPreviewSplitViewController

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
                                             selector:@selector(editPreviewSwithSegmentSelectedNotification:)
                                                 name:@"editPreviewSwithSegmentSelectedNotification"
                                               object:nil];

}

#pragma mark - Text Editing
- (void)setCurrentEditingMarkdown:(JZiCloudMarkdownFileModel *)currentEditingMarkdown
{
    if (_currentEditingMarkdown != currentEditingMarkdown)
    {
        _currentEditingMarkdown = currentEditingMarkdown;
        [_editorVC setCurrentEditingMarkdown:currentEditingMarkdown];
    }
    
    
}
- (void)markdownEditorTextDidChanged:(NSNotification *) notification
{
    if (_editorVC.editorTextView)
    {
        NSError *error;
        [[_editorVC.editorTextView string] writeToFile:[self.currentEditingMarkdown.url path] atomically:YES encoding:NSUTF8StringEncoding error:&error];
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
- (BOOL)isLeftEditorViewCollapsed
{
    return _editorSplitViewItem.collapsed;
}
- (BOOL)isRightPreviewViewCollapsed
{
    return _previewSplitViewItem.collapsed;
}

@end
