//
//  JZFolderListSplitViewController.h
//  Cetacea-Mac
//
//  Created by Fincher Justin on 16/7/2.
//  Copyright © 2016年 JustZht. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface JZFolderListSplitViewController : NSSplitViewController
@property (weak) IBOutlet NSSplitViewItem *markdownListSplitViewItem;
@property (weak) IBOutlet NSSplitViewItem *folderSplitViewItem;

- (BOOL)isLeftFolderViewCollapsed;
@end
