//
//  JZPreviewViewController.m
//  Cetacea-Mac
//
//  Created by Fincher Justin on 16/6/27.
//  Copyright © 2016年 JustZht. All rights reserved.
//

#import "JZPreviewViewController.h"
#import <MMMarkdown/MMMarkdown.h>
#import "JZHeader.h"


@interface JZPreviewViewController ()<WebFrameLoadDelegate>

@property (weak, nonatomic) JZiCloudFileExtensionCetaceaDocument *currentEditingMarkdown;

@end

@implementation JZPreviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    [self.previewWebView setDrawsBackground:NO];
    self.previewWebView.frameLoadDelegate = self;
    self.previewHtmlString = [NSString stringWithFormat:@""];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(dayNightThemeSwitched:)
                                                 name:@"dayNightThemeSwitched"
                                               object:nil];
    
}

- (void)setPreviewHtmlString:(NSString *)previewHtmlString
{
    _previewHtmlString = previewHtmlString;
    [[self.previewWebView mainFrame] loadHTMLString:_previewHtmlString baseURL:[NSURL URLWithString:@""]];
}

- (void)refreshPreview
{
    if (_currentEditingMarkdown)
    {
        self.previewHtmlString = [MMMarkdown HTMLStringWithMarkdown:_currentEditingMarkdown.markdownString extensions:MMMarkdownExtensionsGitHubFlavored error:NULL];
    }
}
- (void)setCurrentEditingMarkdown:(JZiCloudFileExtensionCetaceaDocument *)currentEditingMarkdown
{
    _currentEditingMarkdown = currentEditingMarkdown;
    [self refreshPreview];
}

- (void)dayNightThemeSwitched:(NSNotification *)aNotification
{
    
}

#pragma mark - WebFrameLoadDelegate
- (void)webView:(WebView *)webView didClearWindowObject:(WebScriptObject *)windowObject forFrame:(WebFrame *)frame
{
    [windowObject setValue:[[JZApplicationInfoManager sharedManager] getBuildNumber] forKey:@"AppBuildNumber"];
    [windowObject setValue:[[JZApplicationInfoManager sharedManager] getAppVersion] forKey:@"AppVersion"];
}
- (void)webView:(WebView *)sender didFinishLoadForFrame:(WebFrame *)frame
{
    
}

@end
