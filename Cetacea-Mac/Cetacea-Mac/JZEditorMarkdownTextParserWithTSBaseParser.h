//
//  JZEditorMarkdownTextParserWithTSBaseParser.h
//  Cetacea-Mac
//
//  Created by Fincher Justin on 16/7/4.
//  Copyright © 2016年 JustZht. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_OPTIONS(NSUInteger, JZMarkdownHighLightSyntax)
{
    JZMarkdownHighLightSyntaxHeader     = 0,
    JZMarkdownHighLightSyntaxShortHeader     = 1 << 0,
    JZMarkdownHighLightSyntaxHTMLHeader   = 1 << 1,
    JZMarkdownHighLightSyntaxQuote    = 1 << 2,
    JZMarkdownHighLightSyntaxShortQuote    = 1 << 3,
    JZMarkdownHighLightSyntaxLink    = 1 << 4,
    JZMarkdownHighLightSyntaxImage    = 1 << 5,
    JZMarkdownHighLightSyntaxCodeBlock    = 1 << 6,
};

@interface JZEditorMarkdownTextParserWithTSBaseParser : NSObject

+ (id)sharedManager;
- (void)refreshAttributesTheme;
- (NSAttributedString *)attributedStringFromMarkdown:(NSString *)markdown;

@property (nonatomic) BOOL shouldRemoveTags;

@end
