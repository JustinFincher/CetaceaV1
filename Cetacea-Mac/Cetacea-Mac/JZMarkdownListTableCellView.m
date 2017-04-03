//
//  JZMarkdownListTableCellView.m
//  Cetacea-Mac
//
//  Created by Fincher Justin on 16/7/1.
//  Copyright © 2016年 JustZht. All rights reserved.
//

#import "JZMarkdownListTableCellView.h"

@implementation JZMarkdownListTableCellView

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

- (void)mouseDown:(NSEvent *)event
{
    [super mouseDown:event];
    
    NSMenu *menu = [[NSMenu alloc] initWithTitle:@"Edit Article"];
    
    [NSMenu popUpContextMenu:menu withEvent:event forView:self];
}

@end
