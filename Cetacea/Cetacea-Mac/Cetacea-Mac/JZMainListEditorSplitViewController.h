//
//  JZMainListEditorSplitViewController.h
//  Cetacea-Mac
//
//  Created by Fincher Justin on 16/6/30.
//  Copyright © 2016年 JustZht. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface JZMainListEditorSplitViewController : NSSplitViewController

/**
 *  indicates the Left Panel (including Folder and Markdown Lsit) is Collapsed or not
 *
 *  @return BOOL is Collapsed
 */
- (BOOL)isLeftFolderListViewCollapsed;

@end
