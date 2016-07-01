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
    _previewVC = (JZPreviewViewController *)(self.previewSplitViewItem.viewController);
    _editorVC = (JZEditorViewController *)(self.editorSplitViewItem.viewController);
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(markdownEditorTextDidChanged:)
                                                 name:@"markdownEditorTextDidChanged"
                                               object:nil];
}

- (void)setCurrentEditingMarkdown:(JZiCloudMarkdownFileModel *)currentEditingMarkdown
{
    _currentEditingMarkdown = currentEditingMarkdown;
}
- (void)markdownEditorTextDidChanged:(NSNotification *) notification
{
    if (_editorVC.editorTextView)
    {
        NSError *error;
        [[_editorVC.editorTextView string] writeToFile:[self.currentEditingMarkdown.url path] atomically:YES encoding:NSUTF8StringEncoding error:&error];
    }
}

@end
