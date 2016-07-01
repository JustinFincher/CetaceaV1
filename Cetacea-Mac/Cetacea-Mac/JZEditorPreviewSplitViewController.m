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
    _editorVC = (JZEditorViewController *)(self.previewSplitViewItem.viewController);
}
- (void)setCurrentEditingMarkdown:(JZiCloudMarkdownFileModel *)currentEditingMarkdown
{
    _currentEditingMarkdown = currentEditingMarkdown;
}

@end
