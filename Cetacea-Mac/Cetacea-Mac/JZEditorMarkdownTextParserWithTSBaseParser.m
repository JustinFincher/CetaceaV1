//
//  JZEditorMarkdownTextParserWithTSBaseParser.m
//  Cetacea-Mac
//
//  Created by Fincher Justin on 16/7/4.
//  Copyright © 2016年 JustZht. All rights reserved.
//

#import "JZEditorMarkdownTextParserWithTSBaseParser.h"
#import "TSMarkdownParser.h"
#import <AppKit/AppKit.h>
#import "JZFontDisplayManager.h"
#import "JZEditorHighlightThemeManager.h"

@interface JZEditorMarkdownTextParserWithTSBaseParser()

@property (nonatomic,strong) TSMarkdownParser * parser;

@end

@implementation JZEditorMarkdownTextParserWithTSBaseParser
@synthesize shouldRemoveTags;

#pragma mark Singleton Methods


- (id)init {
    if (self = [super init])
    {
        _parser = [TSMarkdownParser new];
        shouldRemoveTags = NO;
        [self addItalicParsing];
        [self addBoldParsing];
        [self addAtxShortHeaderParsing];
        [self addAtxHeaderParsing];
        [self addSetextHeaderParsing];
        [self addQuoteParsing];
        [self addImageParsing];
        [self addLinkParsing];
        [self addBackTickCodeBlockParsing];
        [self addTildeStrikeThroughParsing];
        [self addListParsing];
//        [self addTabBlockParsing];
        self.themeDoc = [[JZEditorHighlightThemeManager sharedManager] selectedDoc];
    }
    return self;
}

- (void)refreshAttributesTheme
{
//    [self.parser getRefreshedAttributes];
    _defaultAttributes = [[self.themeDoc getData] DefaultTextAttributes];
    _JZAtxHeaderTextAttributes =  [[self.themeDoc getData] AtxHeaderTextAttributes];
    _JZAtxHeaderTagAttributes =  [[self.themeDoc getData] AtxHeaderTagAttributes];
    
    _JZSetextHeaderTextAttributes =  [[self.themeDoc getData] SetextHeaderTextAttributes];
    _JZSetextHeaderTagAttributes =  [[self.themeDoc getData] SetextHeaderTagAttributes];
    
    _JZBoldTextAttributes =  [[self.themeDoc getData] BoldTextAttributes];
    _JZBoldTagAttributes =  [[self.themeDoc getData] BoldTagAttributes];
    
    _JZItalicTextAttributes =  [[self.themeDoc getData] ItalicTextAttributes];
    _JZItalicTagAttributes =  [[self.themeDoc getData] ItalicTagAttributes];
    
    _JZStrikeThroughTextAttributes =  [[self.themeDoc getData] StrikeThroughTextAttributes];
    _JZStrikeThroughTagAttributes =  [[self.themeDoc getData] StrikeThroughTagAttributes];
    
    _JZCodeBlockTextAttributes =  [[self.themeDoc getData] CodeBlockTextAttributes];
    _JZCodeBlockTagAttributes =  [[self.themeDoc getData] CodeBlockTagAttributes];
    
    _JZTabIndentTextAttributes =  [[self.themeDoc getData] TabIndentTextAttributes];
    _JZTabIndentTagAttributes =  [[self.themeDoc getData] TabIndentTagAttributes];
    
    _JZListTextAttributes =  [[self.themeDoc getData] ListTextAttributes];
    _JZListTagAttributes =  [[self.themeDoc getData] ListTagAttributes];
    
    _JZQuoteTextAttributes =  [[self.themeDoc getData] QuoteTextAttributes];
    _JZQuoteTagAttributes =  [[self.themeDoc getData] QuoteTagAttributes];
    
    _JZImageTextAttributes =  [[self.themeDoc getData] ImageTextAttributes];
    _JZImageTagAttributes =  [[self.themeDoc getData] ImageTagAttributes];
    
    _JZLinkTextAttributes =  [[self.themeDoc getData] LinkTextAttributes];
    _JZLinkTagAttributes =  [[self.themeDoc getData] LinkTagAttributes];
    
}
- (NSAttributedString *)attributedStringFromMarkdown:(NSString *)markdown
{
    return [self.parser attributedStringFromMarkdown:markdown];
}

- (void)addBoldParsing
{
    NSRegularExpression *boldParsing = [NSRegularExpression regularExpressionWithPattern:@"(\\*\\*|__)(.+?)(\\1)" options:kNilOptions error:nil];
//    __weak TSMarkdownParser *weakSelfParser = self.parser;
    __weak JZEditorMarkdownTextParserWithTSBaseParser *weakSelf = self;
    [self.parser addParsingRuleWithRegularExpression:boldParsing block:^(NSTextCheckingResult *match, NSMutableAttributedString *attributedString)
    {
        [attributedString addAttributes:weakSelf.JZBoldTextAttributes range:[match rangeAtIndex:2]];
        [attributedString addAttributes:weakSelf.JZBoldTagAttributes range:[match rangeAtIndex:1]];
        [attributedString addAttributes:weakSelf.JZBoldTagAttributes range:[match rangeAtIndex:3]];
        if(weakSelf.shouldRemoveTags)
        {
            [attributedString deleteCharactersInRange:[match rangeAtIndex:3]];
            [attributedString deleteCharactersInRange:[match rangeAtIndex:1]];
        }
    }];
}
- (void)addItalicParsing
{
    NSRegularExpression *ItalicParsing = [NSRegularExpression regularExpressionWithPattern:@"(\\*|_)(.+?)(\\1)" options:kNilOptions error:nil];
//    __weak TSMarkdownParser *weakSelfParser = self.parser;
    __weak JZEditorMarkdownTextParserWithTSBaseParser *weakSelf = self;
    [self.parser addParsingRuleWithRegularExpression:ItalicParsing block:^(NSTextCheckingResult *match, NSMutableAttributedString *attributedString)
     {
         if (match.numberOfRanges >= 3)
         {
             [attributedString addAttributes:weakSelf.JZItalicTextAttributes range:[match rangeAtIndex:2]];
             [attributedString addAttributes:weakSelf.JZItalicTagAttributes range:[match rangeAtIndex:1]];
             [attributedString addAttributes:weakSelf.JZItalicTagAttributes range:[match rangeAtIndex:3]];
             if(weakSelf.shouldRemoveTags)
             {
                 [attributedString deleteCharactersInRange:[match rangeAtIndex:3]];
                 [attributedString deleteCharactersInRange:[match rangeAtIndex:1]];
             }
         }
     }];
}
- (void)addAtxHeaderParsing
{
    NSRegularExpression *AtxHeaderParsing = [NSRegularExpression regularExpressionWithPattern:@"^(#{1,6})\\s+([^#].+)\\s+(#{1,6})$" options:NSRegularExpressionAnchorsMatchLines error:nil];
//    __weak TSMarkdownParser *weakSelfParser = self.parser;
    __weak JZEditorMarkdownTextParserWithTSBaseParser *weakSelf = self;
    [self.parser addParsingRuleWithRegularExpression:AtxHeaderParsing block:^(NSTextCheckingResult *match, NSMutableAttributedString *attributedString)
     {
         if([match rangeAtIndex:1].length == [match rangeAtIndex:3].length)
         {
             [attributedString addAttributes:weakSelf.JZAtxHeaderTextAttributes range:[match rangeAtIndex:2]];
             [attributedString addAttributes:weakSelf.JZAtxHeaderTagAttributes range:[match rangeAtIndex:1]];
             [attributedString addAttributes:weakSelf.JZAtxHeaderTagAttributes range:[match rangeAtIndex:3]];
             if(weakSelf.shouldRemoveTags)
             {
                 [attributedString deleteCharactersInRange:[match rangeAtIndex:1]];
             }
         }
     }];
}
- (void)addAtxShortHeaderParsing
{
    NSRegularExpression *AtxShortHeaderParsing = [NSRegularExpression regularExpressionWithPattern:@"^(#{1,6})\\s*([^#].+)$" options:NSRegularExpressionAnchorsMatchLines error:nil];
//    __weak TSMarkdownParser *weakSelfParser = self.parser;
    __weak JZEditorMarkdownTextParserWithTSBaseParser *weakSelf = self;
    [self.parser addParsingRuleWithRegularExpression:AtxShortHeaderParsing block:^(NSTextCheckingResult *match, NSMutableAttributedString *attributedString)
     {
         [attributedString addAttributes:weakSelf.JZAtxHeaderTagAttributes range:[match rangeAtIndex:1]];
         [attributedString addAttributes:weakSelf.JZAtxHeaderTextAttributes range:[match rangeAtIndex:2]];
         if(weakSelf.shouldRemoveTags)
         {
             [attributedString deleteCharactersInRange:[match rangeAtIndex:1]];
         }
     }];
}
- (void)addSetextHeaderParsing
{
    NSRegularExpression *SetextHeaderParsing = [NSRegularExpression regularExpressionWithPattern:@"(\n)((-{1,}|={1,})\n)" options:NSRegularExpressionDotMatchesLineSeparators error:nil];
//    __weak TSMarkdownParser *weakSelfParser = self.parser;
    __weak JZEditorMarkdownTextParserWithTSBaseParser *weakSelf = self;
    [self.parser addParsingRuleWithRegularExpression:SetextHeaderParsing block:^(NSTextCheckingResult *match, NSMutableAttributedString *attributedString)
     {
         NSRange firstLineChar = [match rangeAtIndex:1];
         NSRange firstLine = [attributedString.string lineRangeForRange:firstLineChar];
         if (firstLine.length == [match rangeAtIndex:2].length)
         {
             [attributedString addAttributes:weakSelf.JZSetextHeaderTextAttributes range:firstLine];
             [attributedString addAttributes:weakSelf.JZSetextHeaderTagAttributes range:[match rangeAtIndex:2]];
         }
     }];
}
- (void)addQuoteParsing
{
    NSRegularExpression *QuoteParsing = [NSRegularExpression regularExpressionWithPattern:@"^(\\>{1,3})\\s+(.+)$" options:NSRegularExpressionAnchorsMatchLines error:nil];
//    __weak TSMarkdownParser *weakSelfParser = self.parser;
    __weak JZEditorMarkdownTextParserWithTSBaseParser *weakSelf = self;
    [self.parser addParsingRuleWithRegularExpression:QuoteParsing block:^(NSTextCheckingResult *match, NSMutableAttributedString *attributedString)
     {
         [attributedString addAttributes:weakSelf.JZQuoteTagAttributes range:[match rangeAtIndex:1]];
         [attributedString addAttributes:weakSelf.JZQuoteTextAttributes range:[match rangeAtIndex:2]];
         if(weakSelf.shouldRemoveTags)
         {
             [attributedString deleteCharactersInRange:[match rangeAtIndex:1]];
         }
     }];
}
- (void)addImageParsing
{
    NSRegularExpression *ImageParsing = [NSRegularExpression regularExpressionWithPattern:@"\\!\\[[^\\[]*?\\]\\(\\S*\\)" options:NSRegularExpressionDotMatchesLineSeparators error:nil];
    //__weak TSMarkdownParser *weakSelfParser = self.parser;
    __weak JZEditorMarkdownTextParserWithTSBaseParser *weakSelf = self;
    [self.parser addParsingRuleWithRegularExpression:ImageParsing block:^(NSTextCheckingResult *match, NSMutableAttributedString *attributedString)
     {
         if (match.range.length > 0)
         {
             NSUInteger imagePathStart = [attributedString.string rangeOfString:@"(" options:(NSStringCompareOptions)0 range:match.range].location;
             NSRange linkRange = NSMakeRange(imagePathStart, match.range.length + match.range.location - imagePathStart - 1);
             
             NSString *imagePath = [attributedString.string substringWithRange:NSMakeRange(linkRange.location + 1, linkRange.length - 1)];
             NSURL *imageURL = [NSURL URLWithString:[imagePath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
             [attributedString addAttributes:weakSelf.JZImageTextAttributes range:match.range];
             [attributedString addAttribute:NSLinkAttributeName value:imageURL range:linkRange];
         }
     }];
}
- (void)addLinkParsing
{
    NSRegularExpression *LinkParsing = [NSRegularExpression regularExpressionWithPattern:@"\\[[^\\[]*?\\]\\([^\\)]*\\)" options:NSRegularExpressionDotMatchesLineSeparators error:nil];
    //__weak TSMarkdownParser *weakSelfParser = self.parser;
    __weak JZEditorMarkdownTextParserWithTSBaseParser *weakSelf = self;
    [self.parser addParsingRuleWithRegularExpression:LinkParsing block:^(NSTextCheckingResult *match, NSMutableAttributedString *attributedString)
     {
         NSUInteger imagePathStart = [attributedString.string rangeOfString:@"(" options:(NSStringCompareOptions)0 range:match.range].location;
         NSRange linkRange = NSMakeRange(imagePathStart, match.range.length + match.range.location - imagePathStart - 1);
         
         NSString *imagePath = [attributedString.string substringWithRange:NSMakeRange(linkRange.location + 1, linkRange.length - 1)];
         NSURL *imageURL = [NSURL URLWithString:[imagePath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
         [attributedString addAttributes:weakSelf.JZLinkTextAttributes range:match.range];
         [attributedString addAttribute:NSLinkAttributeName value:imageURL range:linkRange];
     }];
}
- (void)addBackTickCodeBlockParsing
{
    NSRegularExpression *CodeBlockParsing = [NSRegularExpression regularExpressionWithPattern:@"(?<!\\\\)(?:\\\\\\\\)*+(`+)(.*?[^`].*?)(\\1)(?!`)" options:NSRegularExpressionDotMatchesLineSeparators error:nil];
    __weak TSMarkdownParser *weakSelfParser = self.parser;
    __weak JZEditorMarkdownTextParserWithTSBaseParser *weakSelf = self;
    [self.parser addParsingRuleWithRegularExpression:CodeBlockParsing block:^(NSTextCheckingResult *match, NSMutableAttributedString *attributedString)
     {
         NSLog(@"%lu",(unsigned long)match.numberOfRanges);
         if (match.numberOfRanges == 4)
         {
             [attributedString addAttributes:weakSelf.JZCodeBlockTextAttributes range:[match rangeAtIndex:2]];
             [attributedString addAttributes:weakSelf.JZCodeBlockTagAttributes range:[match rangeAtIndex:1]];
             [attributedString addAttributes:weakSelf.JZCodeBlockTagAttributes range:[match rangeAtIndex:3]];
         }
     }];
}
- (void)addTildeStrikeThroughParsing
{
    NSRegularExpression *CodeBlockParsing = [NSRegularExpression regularExpressionWithPattern:@"(?<!\\\\)(?:\\\\\\\\)*+(~+)(.*?[^~].*?)(\\1)(?!~)" options:NSRegularExpressionDotMatchesLineSeparators error:nil];
    //__weak TSMarkdownParser *weakSelfParser = self.parser;
    __weak JZEditorMarkdownTextParserWithTSBaseParser *weakSelf = self;
    [self.parser addParsingRuleWithRegularExpression:CodeBlockParsing block:^(NSTextCheckingResult *match, NSMutableAttributedString *attributedString)
     {
         if (match.numberOfRanges == 4)
         {
             [attributedString addAttributes:weakSelf.JZStrikeThroughTextAttributes range:[match rangeAtIndex:2]];
             [attributedString addAttributes:weakSelf.JZStrikeThroughTagAttributes range:[match rangeAtIndex:1]];
             [attributedString addAttributes:weakSelf.JZStrikeThroughTagAttributes range:[match rangeAtIndex:3]];
         }
     }];
}
- (void)addListParsing
{
    NSRegularExpression *ListParsing = [NSRegularExpression regularExpressionWithPattern:@"^(\t?[\\*\\+\\-]{1})\\s+(.+)$" options:NSRegularExpressionAnchorsMatchLines error:nil];
//    __weak TSMarkdownParser *weakSelfParser = self.parser;
    __weak JZEditorMarkdownTextParserWithTSBaseParser *weakSelf = self;
    [self.parser addParsingRuleWithRegularExpression:ListParsing block:^(NSTextCheckingResult *match, NSMutableAttributedString *attributedString)
     {
         [attributedString addAttributes:weakSelf.JZListTextAttributes range:[match rangeAtIndex:2]];
         [attributedString addAttributes:weakSelf.JZListTagAttributes range:[match rangeAtIndex:1]];
     }];
}
- (void)addTabBlockParsing
{
    NSRegularExpression *ListParsing = [NSRegularExpression regularExpressionWithPattern:@"^[\t]+(.+)$" options:NSRegularExpressionAnchorsMatchLines error:nil];
//    __weak TSMarkdownParser *weakSelfParser = self.parser;
    __weak JZEditorMarkdownTextParserWithTSBaseParser *weakSelf = self;
    [self.parser addParsingRuleWithRegularExpression:ListParsing block:^(NSTextCheckingResult *match, NSMutableAttributedString *attributedString)
     {
         [attributedString addAttributes:weakSelf.JZTabIndentTextAttributes range:[match rangeAtIndex:1]];
     }];
}
@end
