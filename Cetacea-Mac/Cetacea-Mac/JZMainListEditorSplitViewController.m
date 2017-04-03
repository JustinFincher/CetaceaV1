//
//  JZMainListEditorSplitViewController.m
//  Cetacea-Mac
//
//  Created by Fincher Justin on 16/6/30.
//  Copyright © 2016年 JustZht. All rights reserved.
//

#import "JZMainListEditorSplitViewController.h"
#import "JZMarkdownListViewController.h"
#import "JZEditorPreviewSplitViewController.h"
#import "JZMarkdownListViewController.h"
#import "JZHeader.h"

@interface JZMainListEditorSplitViewController ()<JZMarkdownListViewDelegate,NSSplitViewDelegate>
@property (weak) IBOutlet NSSplitViewItem *folderListViewItem;
@property (weak) IBOutlet NSSplitViewItem *editorViewItem;
@end

@implementation JZMainListEditorSplitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.

    self.splitView.delegate = self;
    [_folderListViewItem setMaximumThickness:600];
    [_folderListViewItem setMinimumThickness:270];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(sideBarSegmentSelectedNotification:)
                                                 name:@"sideBarSegmentSelectedNotification"
                                               object:nil];
    
    
    JZMarkdownListViewController *markdownListVC = (JZMarkdownListViewController *)(_folderListViewItem.viewController);
    markdownListVC.delegate = self;
    
    [self.folderListViewItem setCollapseBehavior:NSSplitViewItemCollapseBehaviorUseConstraints];
    [self.editorViewItem setCollapseBehavior:NSSplitViewItemCollapseBehaviorUseConstraints];
}

- (void)sideBarSegmentSelectedNotification:(NSNotification *) notification
{
    NSDictionary *dict = [notification userInfo];
    NSNumber * selectNumber = (NSNumber *)[dict valueForKey:@"selectedSegment"];
    switch ([selectNumber integerValue])
    {
        case 1:
            if ([self isLeftFolderListViewCollapsed])
            {
                //ALREADY COLLAPSED DO NOTHING
            }else
            {
                [self toggleSidebar:_folderListViewItem];
            }
            break;
        case 0:
            if ([self isLeftFolderListViewCollapsed])
            {
                [self toggleSidebar:_folderListViewItem];
            }else
            {
                //ALREADY UNCOLLAPSED DO NOTHING
            }
            break;
    }
    [self.splitView adjustSubviews];
}

- (void)viewDidLayout
{

}

- (BOOL)isLeftFolderListViewCollapsed
{
    return _folderListViewItem.collapsed;
}

- (BOOL)splitView:(NSSplitView *)splitView
canCollapseSubview:(NSView *)subview
{
    return [super splitView:splitView canCollapseSubview:subview];
}

#pragma mark - JZMarkdownListViewDelegate
- (void)rowSelected:(JZiCloudFileExtensionCetaceaDocument *)markdown
{
//    JZLog(@"rowSelected: %@",markdown.markdownString);
    JZEditorPreviewSplitViewController *editorPreviewSplitVC = (JZEditorPreviewSplitViewController *)_editorViewItem.viewController;
    [editorPreviewSplitVC setCurrentEditingMarkdown:markdown];
}

#pragma mark - NSSplitViewDelegate
- (void)splitViewDidResizeSubviews:(NSNotification *)notification
{
    if (notification.object == self.splitView)
    {
        if (self.folderListViewItem.isCollapsed)
        {
            [[NSNotificationCenter defaultCenter]
             postNotificationName:@"sideBarSegmentWillSelectNotification" object:self userInfo:@{@"selectedSegment":@1}];
        }
    }
}
@end
