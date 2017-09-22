//
//  JZEditorRulerView.h
//  Cetacea-Mac
//
//  Created by Fincher Justin on 16/7/6.
//  Copyright © 2016年 JustZht. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "JZEditorTextView.h"
@import AppKit;

@class JZEditorTextView;
@interface JZEditorRulerView : NSRulerView

@property (weak,nonatomic)NSScrollView *textScrollView;
@property (nonatomic,strong) NSFont *font;
@property (nonatomic,strong) NSFont *boldFont;

- (JZEditorTextView *)getTextView;

@end
