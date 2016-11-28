//
//  JZPreviewViewController.m
//  Cetacea-Mac
//
//  Created by Fincher Justin on 16/6/27.
//  Copyright © 2016年 JustZht. All rights reserved.
//

#import "JZPreviewViewController.h"


@interface JZPreviewViewController ()

@end

@implementation JZPreviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.

    [self.previewWebView setDrawsBackground:NO];
    self.previewHtmlString = [NSString stringWithFormat:@""];
    
}

- (void)setPreviewHtmlString:(NSString *)previewHtmlString
{
    _previewHtmlString = previewHtmlString;
    [[self.previewWebView mainFrame] loadHTMLString:_previewHtmlString baseURL:[NSURL URLWithString:@""]];
}

@end
