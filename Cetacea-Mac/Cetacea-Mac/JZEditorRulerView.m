//
//  JZEditorRulerView.m
//  Cetacea-Mac
//
//  Created by Fincher Justin on 16/7/6.
//  Copyright © 2016年 JustZht. All rights reserved.
//
#define MinNumberOfDigits 3

#import "JZEditorRulerView.h"
#import "JZFontDisplayManager.h"
@import CoreGraphics;
@implementation JZEditorRulerView
@synthesize font;


- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}
- (instancetype)initWithScrollView:(NSScrollView *)scrollView orientation:(NSRulerOrientation)orientation
{
    self = [super initWithScrollView:scrollView orientation:orientation];
    if (self)
    {
//        [self wantsLayer];
//        self.layer.backgroundColor = [NSColor clearColor];
        _textScrollView = scrollView;
        font = [[JZFontDisplayManager sharedManager] getMonospacedFont];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(dayNightThemeSwitched:)
                                                     name:@"dayNightThemeSwitched"
                                                   object:nil];
    }
    return self;
}
- (void)dayNightThemeSwitched:(NSNotification *)aNotification
{
    self.needsDisplay = YES;
}
- (NSTextView *)getTextView
{
    return self.scrollView.contentView.documentView;
}

- (CGFloat)requiredThickness
{
    return (self.ruleThickness > 30.0f) ? self.ruleThickness : 30.0f;
}
- (void)invalidateLineNumber
{
    self.needsDisplay = YES;
}

- (void)drawHashMarksAndLabelsInRect:(NSRect)rect
{
    [[NSColor colorWithCalibratedWhite:0.85 alpha:0.0] set];
     NSRectFill(rect);
    
    NSTextView *textView = [self getTextView];
    NSString *string = [self getTextView].string;
    CGFloat width = self.ruleThickness;
    NSLayoutManager *layoutManager = [self getTextView].layoutManager;
    CGFloat padding = 5.0f;
    NSColor *textColor = [[JZFontDisplayManager sharedManager] getRuleTextForegroundColor];
    
    CTFontRef ctFont = (__bridge CTFontRef)font;
    CGFontRef cgFont = CTFontCopyGraphicsFont(ctFont, nil);
    CGContextRef context = [[NSGraphicsContext currentContext] CGContext];
    if (context)
    {
        CGContextSaveGState(context);
        
        CGContextSetFont(context, cgFont);
        CGContextSetFontSize(context, [font pointSize]);
        CGContextSetFillColorWithColor(context, textColor.CGColor);
        
        unichar dash = [[NSString stringWithFormat:@"-"] characterAtIndex:0];
        CGGlyph wrappedMarkGlyph = kCGGlyphMax;
        CTFontGetGlyphsForCharacters(ctFont, &dash, &wrappedMarkGlyph, 1);
        
        CGGlyph digitGlyphs[10] = {kCGGlyphMax,kCGGlyphMax,kCGGlyphMax,kCGGlyphMax,kCGGlyphMax,kCGGlyphMax,kCGGlyphMax,kCGGlyphMax,kCGGlyphMax,kCGGlyphMax};
        UniChar  numbers[10];
        for (int i = 0; i < 10 ; i++)
        {
            numbers[i] = [[NSString stringWithFormat:@"%d",i] characterAtIndex:0];
        }
        
        CTFontGetGlyphsForCharacters(ctFont, numbers, digitGlyphs, 10);
        CGSize advance = CGSizeZero;
        
        CTFontGetAdvancesForGlyphs(ctFont, kCTFontOrientationHorizontal, &digitGlyphs[8], &advance, 1);
        CGFloat charWidth = advance.width;
        
        NSPoint relativePoint = [self convertPoint:NSZeroPoint toView:[self getTextView]];
        NSPoint inset = [self getTextView].textContainerOrigin;
        CGFloat ascent = CTFontGetAscent(ctFont);
        CGAffineTransform  transform = CGAffineTransformIdentity;
        //transform = CGAffineTransformScale(transform, 1.0, -1.0);
        //transform = CGAffineTransformTranslate(transform, -padding, -relativePoint.y - inset.y - ascent);
        
        //NSLog(@"%F %F %F",relativePoint.y,inset.y,ascent);
        transform = CGAffineTransformTranslate(transform, -padding, relativePoint.y - inset.y - ascent);
        CGContextSetTextMatrix(context, transform);
        
        NSRange visibleGlyphRange = [layoutManager glyphRangeForBoundingRect:[self getTextView].visibleRect inTextContainer:[self getTextView].textContainer];
        
        NSUInteger characterCount = [layoutManager characterIndexForGlyphAtIndex:visibleGlyphRange.location];
        NSUInteger glyphCount = visibleGlyphRange.location;
        int lineIndex = 0;
        int lineNum = lineIndex + 1;
        int lastLineNum = 0;
        
        NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:@"\n" options:NSRegularExpressionCaseInsensitive error:nil];
        lineNum += [regex numberOfMatchesInString:string options:NSMatchingReportProgress range:NSMakeRange(0, characterCount)];
        
        NSUInteger glyphIndex;
        for (glyphIndex = glyphCount; glyphIndex < NSMaxRange(visibleGlyphRange); lineIndex++)
        {
            NSUInteger charIndex = [layoutManager characterIndexForGlyphAtIndex:glyphIndex];
            NSRange lineRange = [string lineRangeForRange:(NSMakeRange(charIndex, 0))];
            NSRange lineCharacterRange = [layoutManager glyphRangeForCharacterRange:lineRange actualCharacterRange:nil];
            glyphIndex = NSMaxRange(lineCharacterRange);
            
            while (glyphCount < glyphIndex)
            {
                NSRange effectiveRange = NSMakeRange(0, 0);
                NSRect lineRect = [layoutManager lineFragmentRectForGlyphAtIndex:glyphCount effectiveRange:&effectiveRange withoutAdditionalLayout:YES];
                CGFloat y = - NSMinY(lineRect);
                if ( lastLineNum == lineNum)
                {
                    CGPoint position = CGPointMake(width - charWidth, y);
                    CGContextShowGlyphsAtPositions(context, &wrappedMarkGlyph, &position, 1);
                }else
                {
                    int digit = [self NumberOfDigits:lineNum];
                    CGGlyph *glyphs = malloc(sizeof(CGGlyph) * digit);
                    for (int i = 0; i < digit; i ++)
                    {
                        glyphs[i] = kCGGlyphMax;
                    }
                    
                    CGPoint *positions = malloc(sizeof(CGPoint) * digit);
                    for (int i = 0; i < digit; i ++)
                    {
                        positions[i] = CGPointZero;
                    }
                    for (int i = 0; i < digit; i ++)
                    {
                        int glyph = digitGlyphs[[self NumberAt:i :lineNum]];
                        glyphs[i] = glyph;
                        CGPoint point = CGPointMake(width - (CGFloat)(i + 1) * charWidth, y);
                        positions[i] = point;
                    }
                    CGContextShowGlyphsAtPositions(context, glyphs, positions, digit);
                }
                lastLineNum = lineNum;
                glyphCount = NSMaxRange(effectiveRange);
            }
            lineNum++;
        }
        if ([layoutManager extraLineFragmentTextContainer] != nil)
        {
            NSRect lineRect = [layoutManager extraLineFragmentRect];
            CGFloat y = -NSMinY(lineRect);
            
            int digit = [self NumberOfDigits:lineNum];
            
            CGGlyph *glyphs = malloc(sizeof(CGGlyph) * digit);
            for (int i = 0; i < digit; i ++)
            {
                glyphs[i] = kCGGlyphMax;
            }
            
            CGPoint *positions = malloc(sizeof(CGPoint) * digit);
            for (int i = 0; i < digit; i ++)
            {
                positions[i] = CGPointZero;
            }
            for (int i = 0; i < digit; i ++)
            {
                int glyph = digitGlyphs[[self NumberAt:i :lineNum]];
                glyphs[i] = glyph;
                CGPoint point = CGPointMake(width - (CGFloat)(i + 1) * charWidth, y);
                positions[i] = point;
            }
            CGContextShowGlyphsAtPositions(context, glyphs, positions, digit);
        }
        CGContextRestoreGState(context);
        
        // adjust ruler thickness
        CGFloat length = ([self NumberOfDigits:lineNum] > MinNumberOfDigits) ? [self NumberOfDigits:lineNum] : MinNumberOfDigits;
        CGFloat requiredWidth = ((CGFloat)length * charWidth + 2.0 * padding ? (CGFloat)length * charWidth + 2.0 * padding :self.ruleThickness);
        self.ruleThickness = requiredWidth;
    }
    
}
- (int)NumberAt:(int)place
               :(int)number
{
    double dplace = (double)place;
    double dnumber = (double)number;
    double result = (int)dnumber % (int)pow(10.0f, dplace + 1);
    result = result / pow(10, dplace);
    return (int)result;
}
- (int)NumberOfDigits:(int)number
{
    return (int)(log10((double)(number)) + 1);
}
- (void)viewDidMoveToSuperview
{
    [super viewDidMoveToSuperview];
}
- (BOOL)isFlipped
{
    return NO;
}
- (BOOL)isOpaque
{
    return NO;
}
@end
