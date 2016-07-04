//
//  JZEditorLinkPopoverContentViewController.m
//  Cetacea-Mac
//
//  Created by Fincher Justin on 16/7/4.
//  Copyright © 2016年 JustZht. All rights reserved.
//

#import "JZEditorLinkPopoverContentViewController.h"
@import WebKit;

@interface JZEditorLinkPopoverContentViewController ()<WKNavigationDelegate,NSSharingServicePickerDelegate>
@property (strong,nonatomic) WKWebView *webView;
@property (weak) IBOutlet NSProgressIndicator *progressIndicator;
@property (weak) IBOutlet NSView *webViewContainer;
@property (weak) IBOutlet NSView *toolbarView;

@property (nonatomic, strong)NSURL *url;

@property (nonatomic) BOOL isResized;

@end

@implementation JZEditorLinkPopoverContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    [self.view wantsLayer];
    _isResized = NO;
    self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, self.webViewContainer.frame.size.width, self.webViewContainer.frame.size.height)];
    [self.webView setAutoresizingMask:NSViewWidthSizable | NSViewHeightSizable];
    [self.webViewContainer addSubview:self.webView];
    [self.webView setValue:@(YES) forKey:@"drawsTransparentBackground"];
    [self.webView setNavigationDelegate:self];
    self.webView.allowsMagnification = YES;
    self.webView.allowsBackForwardNavigationGestures = YES;
    NSLog(@"TOOLBAR %f",_toolbarView.frame.size.height);
}
- (void)loadURL:(NSURL *)url
{
    self.url = url;
    [self.progressIndicator setHidden:NO];
    [self.progressIndicator startAnimation:self];
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
}
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    [self.progressIndicator stopAnimation:self];
    [self.progressIndicator setHidden:YES];
}
- (IBAction)refreshButtonPressed:(id)sender
{
    [self.progressIndicator setHidden:NO];
    [self.progressIndicator startAnimation:self];
    [self.webView reload];
}
- (IBAction)shareButtonPressed:(NSButton *)sender {
    NSSharingServicePicker *sharingServicePicker = [[NSSharingServicePicker alloc] initWithItems:[NSArray arrayWithObject:self.url]];
    sharingServicePicker.delegate = self;
    [sharingServicePicker showRelativeToRect:[sender bounds]
                                      ofView:sender
                               preferredEdge:NSMinYEdge];
}
@end
