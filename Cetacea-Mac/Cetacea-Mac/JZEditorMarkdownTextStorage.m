//
//  JZEditorMarkdownTextStorage.m
//  Cetacea-Mac
//
//  Created by Fincher Justin on 16/7/3.
//  Copyright © 2016年 JustZht. All rights reserved.
//

#import "JZEditorMarkdownTextStorage.h"
#import "JZFontDisplayManager.h"
@import CoreText;

@interface JZEditorMarkdownTextStorage()

@property (nonatomic,strong) NSMutableAttributedString *attributedString;
@property (nonatomic) NSRange paragaphRange;

@end

@implementation JZEditorMarkdownTextStorage
@synthesize paragaphRange;

- (id)init
{
    self = [super init];
    if (self) {
        _attributedString = [NSMutableAttributedString new];
        }
    return self;
}

#pragma mark - NSAttributedString primitives

- (NSString *)string
{
    return _attributedString.string;
}

- (NSDictionary *)attributesAtIndex:(NSUInteger)location effectiveRange:(NSRangePointer)range
{
    return [_attributedString attributesAtIndex:location effectiveRange:range];
}

#pragma mark - NSMutableAttributedString primitives
- (void)replaceCharactersInRange:(NSRange)range withString:(NSString *)str
{
    [_attributedString replaceCharactersInRange:range withString:str];
    [self edited:NSTextStorageEditedCharacters range:range
  changeInLength:(NSInteger)str.length - (NSInteger)range.length];
}

- (void)setAttributes:(NSDictionary *)attrs range:(NSRange)range
{
    [_attributedString setAttributes:attrs range:range];
    [self edited:NSTextStorageEditedAttributes range:range changeInLength:0];
}

#pragma mark - HighLight
- (void)updateCurrentLineHighLight
{
    paragaphRange = [self.string paragraphRangeForRange: self.editedRange];
    [self proccessRange:paragaphRange];

}
- (void)updateAllFileHighLight
{
    
    [self proccessRange:NSMakeRange(0, self.length)];
}
- (void)proccessRange:(NSRange)range
{
    [self removeAttribute:NSForegroundColorAttributeName range:range];
    [self removeAttribute:NSBackgroundColorAttributeName range:range];
    [self addAttribute:NSForegroundColorAttributeName value:[[JZFontDisplayManager sharedManager] getTextColor] range:paragaphRange];
    [self proccessHeaderTagWithRange:range];
    [self proccessItalicTagWithRange:range];
    [self proccessEmphasisTagWithRange:range];
    [self proccessLinkTagWithRange:range];
    [self proccessSingleLineCodeTagWithRange:range];
}
- (void)processEditing
{
    [super processEditing];
    [self updateCurrentLineHighLight];
    
}
/**
 *  CJK font thing, do no call this method. beacause it's handled in TextView.setFont.
 *
 *  @param Range NSRange
 */
- (void)proccessCJKWithRange:(NSRange)Range
{
    static NSRegularExpression *CJKExpression;
    NSString *pattern = @"[\\p{script=Han}]";
    CJKExpression = CJKExpression ?: [NSRegularExpression regularExpressionWithPattern:pattern
                                                                                     options:NSRegularExpressionCaseInsensitive
                                                                                       error:NULL];
    
    [CJKExpression enumerateMatchesInString:self.string
                                       options:0 range:Range
                                    usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop)
     {
         [self addAttribute:NSFontAttributeName value:[NSFont fontWithName:@"PingFangSC-Regular" size:12.0f] range:result.range];
     }];

}
- (void)proccessHeaderTagWithRange:(NSRange)Range
{
    static NSRegularExpression *HeaderExpression;
    NSString *pattern = @"#{1,6} ";
    HeaderExpression = HeaderExpression ?: [NSRegularExpression regularExpressionWithPattern:pattern
                                                                           options:0
                                                                             error:NULL];
    
    [HeaderExpression enumerateMatchesInString:self.string
                                  options:0 range:Range
                               usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop)
     {
         NSRange range = [result rangeAtIndex:0];
         NSString *matchString = self.attributedString.string;
         NSRange lineRange = [matchString lineRangeForRange:range];
         [self addAttribute:NSForegroundColorAttributeName value:[NSColor redColor] range:lineRange];
         [self addAttribute:NSFontAttributeName value:[[JZFontDisplayManager sharedManager] getBoldFont] range:lineRange];
     }];
}
- (void)proccessEmphasisTagWithRange:(NSRange)Range
{
    static NSRegularExpression *EmphasisExpression;
    NSString *pattern = @"\\*\\*([^*]+)\\*\\*";
    EmphasisExpression = EmphasisExpression ?: [NSRegularExpression regularExpressionWithPattern:pattern
                                                                           options:0
                                                                                           error:NULL];
    
    [EmphasisExpression enumerateMatchesInString:self.string
                                  options:0 range:Range
                               usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop)
     {
         [self addAttribute:NSForegroundColorAttributeName value:[NSColor redColor] range:result.range];
         [self addAttribute:NSFontAttributeName value:[[JZFontDisplayManager sharedManager] getBoldFont] range:result.range];
     }];
}
- (void)proccessItalicTagWithRange:(NSRange)Range
{
    static NSRegularExpression *ItalicExpression;
    NSString *pattern = @"\\*([^(*|\\n)]+)\\*";
    ItalicExpression = ItalicExpression ?: [NSRegularExpression regularExpressionWithPattern:pattern
                                                                                     options:0
                                                                                       error:NULL];
    
    [ItalicExpression enumerateMatchesInString:self.string
                                       options:0 range:Range
                                    usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop)
     {
         [self addAttribute:NSForegroundColorAttributeName value:[NSColor yellowColor] range:result.range];
         [self addAttribute:NSFontAttributeName value:[[JZFontDisplayManager sharedManager] getItalicFont] range:result.range];
     }];
}
- (void)proccessLinkTagWithRange:(NSRange)Range
{
    static NSRegularExpression *LinkExpression;
    NSString *pattern = @"\\[[^\\[]*?\\]\\([^\\)]*\\)";
    LinkExpression = LinkExpression ?: [NSRegularExpression regularExpressionWithPattern:pattern
                                                                                     options:0
                                                                                       error:NULL];
    
    [LinkExpression enumerateMatchesInString:self.string
                                       options:0 range:Range
                                    usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop)
     {
         [self addAttribute:NSForegroundColorAttributeName value:[NSColor blueColor] range:result.range];
         [self addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInt:NSUnderlineStyleSingle] range:result.range];
     }];
}
- (void)proccessSingleLineCodeTagWithRange:(NSRange)Range
{
    static NSRegularExpression *SingleLineCodeExpression;
    NSString *pattern = @"\\`([^(`|\\n)]+)\\`";
    SingleLineCodeExpression = SingleLineCodeExpression ?: [NSRegularExpression regularExpressionWithPattern:pattern
                                                                                 options:0
                                                                                   error:NULL];
    
    [SingleLineCodeExpression enumerateMatchesInString:self.string
                                     options:0 range:Range
                                  usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop)
     {
         [self addAttribute:NSForegroundColorAttributeName value:[NSColor greenColor] range:result.range];
     }];
}


@end
