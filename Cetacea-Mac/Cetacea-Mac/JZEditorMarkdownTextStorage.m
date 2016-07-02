//
//  JZEditorMarkdownTextStorage.m
//  Cetacea-Mac
//
//  Created by Fincher Justin on 16/7/3.
//  Copyright © 2016年 JustZht. All rights reserved.
//

#import "JZEditorMarkdownTextStorage.h"

@interface JZEditorMarkdownTextStorage()

@property (nonatomic,strong) NSMutableAttributedString *attributedString;

@end

@implementation JZEditorMarkdownTextStorage

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

- (void)processEditing
{
    [super processEditing];
    
    static NSRegularExpression *iExpression;
    NSString *pattern = @"i[\\p{Alphabetic}&&\\p{Uppercase}][\\p{Alphabetic}]+";
    iExpression = iExpression ?: [NSRegularExpression regularExpressionWithPattern:pattern
                                                                           options:0
                                                                             error:NULL];
    
    NSRange paragaphRange = [self.string paragraphRangeForRange: self.editedRange];
    [self removeAttribute:NSForegroundColorAttributeName range:paragaphRange];
    
    [iExpression enumerateMatchesInString:self.string
                                  options:0 range:paragaphRange
                               usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop)
     {
         [self addAttribute:NSForegroundColorAttributeName value:[NSColor redColor] range:result.range];
     }];
}

@end
