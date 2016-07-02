//
//  JZEditorMarkdownTextStorage.m
//  Cetacea-Mac
//
//  Created by Fincher Justin on 16/7/3.
//  Copyright © 2016年 JustZht. All rights reserved.
//

#import "JZEditorMarkdownTextStorage.h"
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
    [self removeAttribute:NSForegroundColorAttributeName range:paragaphRange];
    
    [self proccessHeaderTagWithRange:paragaphRange];
    [self proccessEmphasisTagWithRange:paragaphRange];

}
- (void)updateAllFileHighLight
{
    [self removeAttribute:NSForegroundColorAttributeName range:NSMakeRange(0, self.length)];
    [self proccessHeaderTagWithRange:NSMakeRange(0, self.length)];
    [self proccessEmphasisTagWithRange:NSMakeRange(0, self.length)];
    
}
- (void)processEditing
{
    [super processEditing];
    [self updateCurrentLineHighLight];
    
}
- (void)proccessHeaderTagWithRange:(NSRange)Range
{
    static NSRegularExpression *iExpression;
    NSString *pattern = @"#{1,6}";
    iExpression = iExpression ?: [NSRegularExpression regularExpressionWithPattern:pattern
                                                                           options:0
                                                                             error:NULL];
    
    [iExpression enumerateMatchesInString:self.string
                                  options:0 range:Range
                               usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop)
     {
         [self addAttribute:NSForegroundColorAttributeName value:[NSColor redColor] range:result.range];
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
     }];
}


@end
