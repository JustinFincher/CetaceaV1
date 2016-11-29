//
//  JZEditorMarkdownTextParserWithTSBaseParser.h
//  Cetacea-Mac
//
//  Created by Fincher Justin on 16/7/4.
//  Copyright © 2016年 JustZht. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JZiCloudFileExtensionCetaceaThemeDataBase.h"


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

- (void)refreshAttributesTheme;
- (NSAttributedString *)attributedParagraphParserStringFromMarkdown:(NSString *)markdown;
- (NSAttributedString *)attributedLineParserStringFromMarkdown:(NSString *)markdown;
- (NSAttributedString *)attributedStringFromMarkdown:(NSString *)markdown;

@property (nonatomic,weak) JZiCloudFileExtensionCetaceaThemeDoc *themeDoc;

@property (nonatomic) BOOL shouldRemoveTags;

@property (nonatomic, strong) NSDictionary<NSString *, id> *defaultAttributes;
@property (nonatomic, strong) NSDictionary<NSString *, id> *JZAtxHeaderTextAttributes;
@property (nonatomic, strong) NSDictionary<NSString *, id> *JZAtxHeaderTagAttributes;

@property (nonatomic, strong) NSDictionary<NSString *, id> *JZSetextHeaderTextAttributes;
@property (nonatomic, strong) NSDictionary<NSString *, id> *JZSetextHeaderTagAttributes;

@property (nonatomic, strong) NSDictionary<NSString *, id> *JZCodeBlockTextAttributes;
@property (nonatomic, strong) NSDictionary<NSString *, id> *JZCodeBlockTagAttributes;

@property (nonatomic, strong) NSDictionary<NSString *, id> *JZBoldTextAttributes;
@property (nonatomic, strong) NSDictionary<NSString *, id> *JZBoldTagAttributes;

@property (nonatomic, strong) NSDictionary<NSString *, id> *JZItalicTextAttributes;
@property (nonatomic, strong) NSDictionary<NSString *, id> *JZItalicTagAttributes;

@property (nonatomic, strong) NSDictionary<NSString *, id> *JZStrikeThroughTextAttributes;
@property (nonatomic, strong) NSDictionary<NSString *, id> *JZStrikeThroughTagAttributes;

@property (nonatomic, strong) NSDictionary<NSString *, id> *JZTabIndentTextAttributes;
@property (nonatomic, strong) NSDictionary<NSString *, id> *JZTabIndentTagAttributes;

@property (nonatomic, strong) NSDictionary<NSString *, id> *JZListTextAttributes;
@property (nonatomic, strong) NSDictionary<NSString *, id> *JZListTagAttributes;

@property (nonatomic, strong) NSDictionary<NSString *, id> *JZQuoteTextAttributes;
@property (nonatomic, strong) NSDictionary<NSString *, id> *JZQuoteTagAttributes;

@property (nonatomic, strong) NSDictionary<NSString *, id> *JZImageTextAttributes;
@property (nonatomic, strong) NSDictionary<NSString *, id> *JZImageTagAttributes;

@property (nonatomic, strong) NSDictionary<NSString *, id> *JZLinkTextAttributes;
@property (nonatomic, strong) NSDictionary<NSString *, id> *JZLinkTagAttributes;

@end
