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
    self.visualEffectBackgroundView.translatesAutoresizingMaskIntoConstraints = true;
    [self.previewWebView setDrawsBackground:NO];
    self.previewWebView.frameLoadDelegate = self;
    self.previewHtmlString = [NSString stringWithFormat:@""];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(dayNightThemeSwitched:)
                                                 name:@"dayNightThemeSwitched"
                                               object:nil];
    
}
- (void)setCurrentEditingMarkdown:(JZiCloudFileExtensionCetaceaDocument *)currentEditingMarkdown
{
    _currentEditingMarkdown = currentEditingMarkdown;
    [self refreshPreview];
}
- (void)refreshPreview
{
    NSString *stringToPreview = self.currentEditingMarkdown.markdownString != nil ? self.currentEditingMarkdown.markdownString : @"";
    self.previewHtmlString = [MMMarkdown HTMLStringWithMarkdown:stringToPreview extensions:MMMarkdownExtensionsGitHubFlavored error:NULL];
}
- (void)setPreviewHtmlString:(NSString *)previewHtmlString
{
    _previewHtmlString = previewHtmlString;
    [[self.previewWebView mainFrame] loadHTMLString:_previewHtmlString baseURL:[NSURL URLWithString:@""]];
}

- (void)dayNightThemeSwitched:(NSNotification *)aNotification
{
    
}

#pragma mark - WebFrameLoadDelegate
- (void)webView:(WebView *)webView didClearWindowObject:(WebScriptObject *)windowObject forFrame:(WebFrame *)frame
{
    [windowObject setValue:[[JZApplicationInfoManager sharedManager] getBuildNumber] forKey:@"CetaceaMainAppBuildNumber"];
    [windowObject setValue:[[JZApplicationInfoManager sharedManager] getAppVersion] forKey:@"CetaceaMainAppVersion"];
}
- (void)webView:(WebView *)sender didCommitLoadForFrame:(WebFrame *)frame
{
    
}
- (void)webView:(WebView *)sender didFinishLoadForFrame:(WebFrame *)frame
{
    DOMDocument* domDocument = [sender mainFrameDocument];
    NSString *jqueryPath = [[NSBundle mainBundle] pathForResource:@"jquery.min" ofType:@"js"];
    NSString *jqueryContent = [NSString stringWithContentsOfFile:jqueryPath encoding:NSUTF8StringEncoding error:nil];
    [self addJSStringToHead:jqueryContent byDomDocument:domDocument];
    
    NSString *csspath = [[NSBundle mainBundle] pathForResource:@"atom-one-light" ofType:@"css"];
    NSString *csscontent = [NSString stringWithContentsOfFile:csspath encoding:NSUTF8StringEncoding error:nil];
    [self addCSSStringToHead:csscontent byDomDocument:domDocument];
    
    NSString *jspath = [[NSBundle mainBundle] pathForResource:@"highlight.pack" ofType:@"js"];
    NSString *jscontent = [NSString stringWithContentsOfFile:jspath encoding:NSUTF8StringEncoding error:nil];
    [self addJSStringToHead:jscontent byDomDocument:domDocument];
    
    [self addJSStringToHead:@"$(document).ready(function() {$('pre code').each(function(i, block) {hljs.highlightBlock(block);});});" byDomDocument:domDocument];
}
#pragma mark - Helpers
- (void)addCSSStringToHead:(NSString *)string
       byDomDocument:(DOMDocument *)domDocument
{
    DOMElement* styleElement = [domDocument createElement:@"style"];
    [styleElement setAttribute:@"type" value:@"text/css"];
    DOMText* cssText = [domDocument createTextNode:string];
    [styleElement appendChild:cssText];
    DOMElement* headElement=(DOMElement*)[[domDocument getElementsByTagName:@"head"] item:0];
    [headElement appendChild:styleElement];
}
- (void)addJSStringToHead:(NSString *)string
             byDomDocument:(DOMDocument *)domDocument
{
    DOMElement* styleElement = [domDocument createElement:@"script"];
    DOMText* jsText = [domDocument createTextNode:string];
    [styleElement appendChild:jsText];
    DOMElement* headElement=(DOMElement*)[[domDocument getElementsByTagName:@"head"] item:0];
    [headElement appendChild:styleElement];
}

@end
