//
//  JZEditorTextView.m
//  Cetacea-Mac
//
//  Created by Fincher Justin on 16/7/6.
//  Copyright © 2016年 JustZht. All rights reserved.
//

#import "JZEditorTextView.h"

@implementation JZEditorTextView

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

- (void)updateRuler
{
    [super updateRuler];
    self.rulerView.needsDisplay = YES;
}
@end
