//
//  JZEditorTextView.h
//  Cetacea-Mac
//
//  Created by Fincher Justin on 16/7/6.
//  Copyright © 2016年 JustZht. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "JZEditorRulerView.h"
#import "JZEditorLayouManager.h"
#import "JZEditorMarkdownTextParserWithTSBaseParser.h"

@interface JZEditorTextView : NSTextView

@property (atomic)BOOL hasSetup;
;
@property (nonatomic,strong) JZEditorMarkdownTextParserWithTSBaseParser *parser;

- (void)refreshHightLight;

@end
