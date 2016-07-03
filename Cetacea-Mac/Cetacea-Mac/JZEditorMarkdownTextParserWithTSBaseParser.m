//
//  JZEditorMarkdownTextParserWithTSBaseParser.m
//  Cetacea-Mac
//
//  Created by Fincher Justin on 16/7/4.
//  Copyright © 2016年 JustZht. All rights reserved.
//

#import "JZEditorMarkdownTextParserWithTSBaseParser.h"
#import "TSMarkdownParser.h"

@interface JZEditorMarkdownTextParserWithTSBaseParser()

@property (nonatomic,strong) TSMarkdownParser * parser;

@end

@implementation JZEditorMarkdownTextParserWithTSBaseParser
@synthesize shouldRemoveTags;

#pragma mark Singleton Methods

+ (id)sharedManager {
    static JZEditorMarkdownTextParserWithTSBaseParser *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (id)init {
    if (self = [super init])
    {
        _parser = [TSMarkdownParser new];
        shouldRemoveTags = NO;
        [self addItalicParsing];
        [self addBoldParsing];
        [self addHeaderParsing];
    }
    return self;
}

- (void)dealloc {
    // Should never be called, but just here for clarity really.
}

- (void)refreshAttributesTheme
{
    [self.parser getRefreshedAttributes];
}
- (NSAttributedString *)attributedStringFromMarkdown:(NSString *)markdown
{
    return [self.parser attributedStringFromMarkdown:markdown];
}

- (void)addBoldParsing
{
    NSRegularExpression *boldParsing = [NSRegularExpression regularExpressionWithPattern:@"(\\*\\*|__)(.+?)(\\1)" options:kNilOptions error:nil];
    __weak TSMarkdownParser *weakSelfParser = self.parser;
    __weak JZEditorMarkdownTextParserWithTSBaseParser *weakSelf = self;
    [self.parser addParsingRuleWithRegularExpression:boldParsing block:^(NSTextCheckingResult *match, NSMutableAttributedString *attributedString)
    {
        [attributedString addAttributes:weakSelfParser.strongAttributes range:[match rangeAtIndex:2]];
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
    __weak TSMarkdownParser *weakSelfParser = self.parser;
    __weak JZEditorMarkdownTextParserWithTSBaseParser *weakSelf = self;
    [self.parser addParsingRuleWithRegularExpression:ItalicParsing block:^(NSTextCheckingResult *match, NSMutableAttributedString *attributedString)
     {
         [attributedString addAttributes:weakSelfParser.emphasisAttributes range:[match rangeAtIndex:2]];
         if(weakSelf.shouldRemoveTags)
         {
             [attributedString deleteCharactersInRange:[match rangeAtIndex:3]];
             [attributedString deleteCharactersInRange:[match rangeAtIndex:1]];
         }
     }];
}
- (void)addHeaderParsing
{
    NSRegularExpression *HeaderParsing = [NSRegularExpression regularExpressionWithPattern:@"^(#{1,6})\\s*([^#].*)$" options:NSRegularExpressionAnchorsMatchLines error:nil];
    __weak TSMarkdownParser *weakSelfParser = self.parser;
    __weak JZEditorMarkdownTextParserWithTSBaseParser *weakSelf = self;
    [self.parser addParsingRuleWithRegularExpression:HeaderParsing block:^(NSTextCheckingResult *match, NSMutableAttributedString *attributedString)
     {
         [attributedString addAttributes:weakSelfParser.strongAttributes range:[match rangeAtIndex:2]];
         if(weakSelf.shouldRemoveTags)
         {
             [attributedString deleteCharactersInRange:[match rangeAtIndex:1]];
         }
     }];
}
@end
