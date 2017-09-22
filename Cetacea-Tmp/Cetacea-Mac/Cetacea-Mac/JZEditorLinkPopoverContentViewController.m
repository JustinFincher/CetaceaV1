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
}

- (void)proccessURL:(NSURL *)url
{
    self.url = url;
    if (self.webView == nil)
    {
        self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, self.webViewContainer.frame.size.width, self.webViewContainer.frame.size.height)];
        [self.webView setAutoresizingMask:NSViewWidthSizable | NSViewHeightSizable];
        [self.webViewContainer addSubview:self.webView];
        [self.webView setValue:@(YES) forKey:@"drawsTransparentBackground"];
        [self.webView setNavigationDelegate:self];
        self.webView.allowsMagnification = YES;
        self.webView.allowsBackForwardNavigationGestures = YES;
    }
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
    [self proccessURL:self.url];
}
- (IBAction)shareButtonPressed:(NSButton *)sender {
    NSArray *shareArray;
    shareArray =  [NSArray arrayWithObject:self.url];
    NSSharingServicePicker *sharingServicePicker = [[NSSharingServicePicker alloc] initWithItems:shareArray];
    sharingServicePicker.delegate = self;
    [sharingServicePicker showRelativeToRect:[sender bounds]
                                      ofView:sender
                               preferredEdge:NSMinYEdge];
}
@end
