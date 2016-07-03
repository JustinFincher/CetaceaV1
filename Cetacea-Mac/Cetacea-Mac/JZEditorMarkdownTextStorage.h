//
//  JZEditorMarkdownTextStorage.h
//  Cetacea-Mac
//
//  Created by Fincher Justin on 16/7/3.
//  Copyright © 2016年 JustZht. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface JZEditorMarkdownTextStorage : NSTextStorage

/**
 *  update this NSTextStorage with highlight attributes
 */
- (void)updateAllFileHighLight;

@end
