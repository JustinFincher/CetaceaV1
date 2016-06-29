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
    
    
//    NSURL*url=[NSURL URLWithString:@"https://fincher.im"];
//    NSURLRequest*request=[NSURLRequest requestWithURL:url];
    //[[self.previewWebView mainFrame] loadRequest:request];
}

@end
