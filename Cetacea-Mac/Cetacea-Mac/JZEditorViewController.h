//
//  JZEditorViewController.h
//  Cetacea-Mac
//
//  Created by Fincher Justin on 16/6/27.
//  Copyright © 2016年 JustZht. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "JZiCloudMarkdownFileModel.h"

@interface JZEditorViewController : NSViewController
@property (weak) IBOutlet NSScrollView *editorScrollView;
@property (unsafe_unretained) IBOutlet NSTextView *editorTextView;

- (void)setCurrentEditingMarkdown:(JZiCloudMarkdownFileModel *)currentEditingMarkdown;

@end
