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
#import "JZFolderListSplitViewController.h"

@interface JZMainListEditorSplitViewController ()<JZMarkdownListViewDelegate>
@property (weak) IBOutlet NSSplitViewItem *folderListViewItem;
@property (weak) IBOutlet NSSplitViewItem *editorViewItem;
@end

@implementation JZMainListEditorSplitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.

    [_folderListViewItem setMaximumThickness:600];
    [_folderListViewItem setMinimumThickness:270];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(sideBarSegmentSelectedNotification:)
                                                 name:@"sideBarSegmentSelectedNotification"
                                               object:nil];
    
    
    JZFolderListSplitViewController *folderListSplitVC = (JZFolderListSplitViewController *)(_folderListViewItem.viewController);
    JZMarkdownListViewController *markdownListVC = (JZMarkdownListViewController *)([folderListSplitVC.markdownListSplitViewItem viewController]);
    markdownListVC.delegate = self;
}

- (void)sideBarSegmentSelectedNotification:(NSNotification *) notification
{
    NSDictionary *dict = [notification userInfo];
    NSNumber * selectNumber = (NSNumber *)[dict valueForKey:@"selectedSegment"];
    switch ([selectNumber integerValue])
    {
        case 2:
            if ([self isLeftFolderListViewCollapsed])
            {
                //ALREADY COLLAPSED DO NOTHING
            }else
            {
                [self toggleSidebar:_folderListViewItem];
            }
            break;
        case 1:
            if ([self isLeftFolderListViewCollapsed])
            {
                [self toggleSidebar:_folderListViewItem];
            }else
            {
                //ALREADY UNCOLLAPSED DO NOTHING
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
            
        default:
            break;
    }
}

- (void)viewDidLayout
{

}

- (BOOL)isLeftFolderListViewCollapsed
{
    return _folderListViewItem.collapsed;
}

#pragma mark - JZMarkdownListViewDelegate
- (void)rowSelected:(JZiCloudFileExtensionCetaceaDoc *)markdown
{
    JZEditorPreviewSplitViewController *editorPreviewSplitVC = (JZEditorPreviewSplitViewController *)_editorViewItem.viewController;
    [editorPreviewSplitVC setCurrentEditingMarkdown:markdown];
}

@end
