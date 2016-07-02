//
//  JZEditorPreviewSplitViewController.h
//  Cetacea-Mac
//
//  Created by Fincher Justin on 16/6/27.
//  Copyright © 2016年 JustZht. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "JZiCloudMarkdownFileModel.h"

@interface JZEditorPreviewSplitViewController : NSSplitViewController
@property (weak) IBOutlet NSSplitViewItem *editorSplitViewItem;
@property (weak) IBOutlet NSSplitViewItem *previewSplitViewItem;


@property (nonatomic,strong) JZiCloudMarkdownFileModel* currentEditingMarkdown;
- (BOOL)isLeftEditorViewCollapsed;
- (BOOL)isRightPreviewViewCollapsed;

@end
