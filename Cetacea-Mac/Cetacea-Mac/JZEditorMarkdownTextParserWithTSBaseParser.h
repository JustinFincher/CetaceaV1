//
//  JZEditorMarkdownTextParserWithTSBaseParser.h
//  Cetacea-Mac
//
//  Created by Fincher Justin on 16/7/4.
//  Copyright © 2016年 JustZht. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JZEditorMarkdownTextParserWithTSBaseParser : NSObject

+ (id)sharedManager;
- (void)refreshAttributesTheme;
- (NSAttributedString *)attributedStringFromMarkdown:(NSString *)markdown;

@property (nonatomic) BOOL shouldRemoveTags;

@end
