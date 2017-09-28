//
//  JZEditorPreviewSplitViewController.h
//  Cetacea-Mac
//
//  Created by Fincher Justin on 16/6/27.
//  Copyright © 2016年 JustZht. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <CetaceaSharedFramework/CSFCetaceaSharedDocument.h>

@interface JZEditorPreviewSplitViewController : NSSplitViewController
@property (weak) IBOutlet NSSplitViewItem *editorSplitViewItem;
@property (weak) IBOutlet NSSplitViewItem *previewSplitViewItem;


@property (nonatomic,strong) CSFCetaceaAbstractSharedDocument* currentEditingMarkdown;

/**
 *  indicates the left edit view is collasped or not
 *
 *  @return BOOL is collapsed
 */
- (BOOL)isLeftEditorViewCollapsed;

/**
 *  indicates the right preview view is collasped or not
 *
 *  @return BOOL is collapsed
 */
- (BOOL)isRightPreviewViewCollapsed;

/**
 *  Set current JZiCloudMarkdownFileModel to Split VC
 *
 *  @param currentEditingMarkdown the CSFCetaceaAbstractSharedDocument to be updated on view
 */
- (void)setCurrentEditingMarkdown:(CSFCetaceaAbstractSharedDocument *)currentEditingMarkdown;
@end
