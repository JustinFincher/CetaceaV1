//
//  JZEditorImageAttachmentCell.m
//  Cetacea-Mac
//
//  Created by Fincher Justin on 16/7/4.
//  Copyright © 2016年 JustZht. All rights reserved.
//

#import "JZEditorImageAttachmentCell.h"
#import "JZFontDisplayManager.h"
@implementation JZEditorImageAttachmentCell

- (NSSize)cellSize
{
    CGFloat size = [[JZFontDisplayManager sharedManager] getFontSize];
    return NSMakeSize(size, size);
}

- (void)drawWithFrame:(NSRect)cellFrame
               inView:(NSView *)controlView
{
    
}
@end
