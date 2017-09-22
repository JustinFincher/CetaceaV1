//
//  JZEditorViewController.h
//  Cetacea-Mac
//
//  Created by Fincher Justin on 16/6/27.
//  Copyright © 2016年 JustZht. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "JZiCloudFileExtensionCetaceaDocument.h"
#import "JZEditorTextView.h"
#import <CetaceaSharedFramework/CSFEditorTextView.h>

@interface JZEditorViewController : NSViewController
@property (weak) IBOutlet NSScrollView *editorScrollView;
@property (unsafe_unretained) IBOutlet CSFEditorTextView *editorTextView;
@property (weak) IBOutlet NSView *editorBottomHelperView;
@property (weak) IBOutlet NSTextField *editorBottomStatLabel;
@property (strong) IBOutlet NSVisualEffectView *visualEffectBackgroundView;


- (void)setCurrentEditingMarkdown:(JZiCloudFileExtensionCetaceaDocument *)currentEditingMarkdown;

- (void)refreshHighLight;

@end
