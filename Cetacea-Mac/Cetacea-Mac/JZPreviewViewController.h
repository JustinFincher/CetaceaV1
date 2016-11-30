//
//  JZPreviewViewController.h
//  Cetacea-Mac
//
//  Created by Fincher Justin on 16/6/27.
//  Copyright © 2016年 JustZht. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "JZiCloudFileExtensionCetaceaDoc.h"
@import WebKit;

@interface JZPreviewViewController : NSViewController
@property (weak) IBOutlet WebView *previewWebView;

@property (strong,nonatomic) NSString * previewHtmlString;

/**
 *  set current editing Markdown Model (aka a .md file)
 *
 *  @param currentEditingMarkdown a JZiCloudMarkdownFileModel
 */
- (void)setCurrentEditingMarkdown:(JZiCloudFileExtensionCetaceaDoc *)currentEditingMarkdown;

- (void)refreshPreview;

@end
