//
//  JZHighlighThemePreviewCollectionViewItem.m
//  Cetacea-Mac
//
//  Created by Fincher Justin on 16/7/8.
//  Copyright © 2016年 JustZht. All rights reserved.
//

#import "JZHighlighThemePreviewCollectionViewItem.h"

@interface JZHighlighThemePreviewCollectionViewItem ()
@property (weak) IBOutlet NSView *previewContentView;

@end

@implementation JZHighlighThemePreviewCollectionViewItem
@synthesize previewContentView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    self.view.wantsLayer = YES;
    previewContentView.wantsLayer = YES;
    previewContentView.layer.masksToBounds = NO;
    previewContentView.layer.backgroundColor = [NSColor whiteColor].CGColor;
    if (previewContentView.layer)
    {
        [previewContentView.layer setCornerRadius:5.0];
        NSShadow *dropShadow = [[NSShadow alloc] init];
        [dropShadow setShadowColor:[NSColor colorWithWhite:0.0f alpha:0.3f]];
        [dropShadow setShadowOffset:NSMakeSize(0, -3.0)];
        [dropShadow setShadowBlurRadius:10.0];
        [previewContentView setShadow: dropShadow];
    }
    if (self.isAddState)
    {
    }
}

@end
