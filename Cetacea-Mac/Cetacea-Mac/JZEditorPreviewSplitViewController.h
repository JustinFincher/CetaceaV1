//
//  JZEditorPreviewSplitViewController.h
//  Cetacea-Mac
//
//  Created by Fincher Justin on 16/6/27.
//  Copyright © 2016年 JustZht. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface JZEditorPreviewSplitViewController : NSSplitViewController
@property (weak) IBOutlet NSSplitViewItem *editorSplitViewItem;
@property (weak) IBOutlet NSSplitViewItem *previewSplitViewItem;

@end
