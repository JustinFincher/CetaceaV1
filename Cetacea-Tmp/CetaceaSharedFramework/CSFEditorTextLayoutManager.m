//
//  CSFEditorTextLayoutManager.m
//  CetaceaSharedFramework
//
//  Created by Justin Fincher on 2017/5/13.
//
//

#import "CSFEditorTextLayoutManager.h"
#import "CSFGlobalHeader.h"

@implementation CSFEditorTextLayoutManager

- (void)fillBackgroundRectArray:(const CSFRect *)rectArray
                          count:(NSUInteger)rectCount
              forCharacterRange:(NSRange)charRange
                          color:(CSFColor *)color
{
    CGFloat halfLineWidth = 4.; // change this to change corners radius
//    NSUInteger count = rectCount;
//    NSRange range = charRange;
    
    CGMutablePathRef path = CGPathCreateMutable();
    
    if (rectCount == 1 || (rectCount == 2 && (CGRectGetMaxX(rectArray[1]) < CGRectGetMinX(rectArray[0]))))
    {
        // 1 rect or 2 rects without edges in contact
        
        CGPathAddRect(path, NULL, CGRectInset(rectArray[0], halfLineWidth, halfLineWidth));
        if (rectCount == 2)
            CGPathAddRect(path, NULL, CGRectInset(rectArray[1], halfLineWidth, halfLineWidth));
    }
    else
    {
        // 2 or 3 rects
        NSUInteger lastRect = rectCount - 1;
        
        CGPathMoveToPoint(path, NULL, CGRectGetMinX(rectArray[0]) + halfLineWidth, CGRectGetMaxY(rectArray[0]) + halfLineWidth);
        
        CGPathAddLineToPoint(path, NULL, CGRectGetMinX(rectArray[0]) + halfLineWidth, CGRectGetMinY(rectArray[0]) + halfLineWidth);
        CGPathAddLineToPoint(path, NULL, CGRectGetMaxX(rectArray[0]) - halfLineWidth, CGRectGetMinY(rectArray[0]) + halfLineWidth);
        
        CGPathAddLineToPoint(path, NULL, CGRectGetMaxX(rectArray[0]) - halfLineWidth, CGRectGetMinY(rectArray[lastRect]) - halfLineWidth);
        CGPathAddLineToPoint(path, NULL, CGRectGetMaxX(rectArray[lastRect]) - halfLineWidth, CGRectGetMinY(rectArray[lastRect]) - halfLineWidth);
        
        CGPathAddLineToPoint(path, NULL, CGRectGetMaxX(rectArray[lastRect]) - halfLineWidth, CGRectGetMaxY(rectArray[lastRect]) - halfLineWidth);
        CGPathAddLineToPoint(path, NULL, CGRectGetMinX(rectArray[lastRect]) + halfLineWidth, CGRectGetMaxY(rectArray[lastRect]) - halfLineWidth);
        
        CGPathAddLineToPoint(path, NULL, CGRectGetMinX(rectArray[lastRect]) + halfLineWidth, CGRectGetMaxY(rectArray[0]) + halfLineWidth);
        
        CGPathCloseSubpath(path);
    }
    
    [color set]; // set fill and stroke color
    
#if TARGET_OS_IOS
    CGContextRef ctx = UIGraphicsGetCurrentContext();
#elif TARGET_OS_OSX
    CGContextRef ctx = [[NSGraphicsContext currentContext] graphicsPort];
#endif
    CGContextSetLineWidth(ctx, halfLineWidth * 2.);
    CGContextSetLineJoin(ctx, kCGLineJoinRound);
    CGContextSetAllowsAntialiasing(ctx, YES);
    CGContextSetShouldAntialias(ctx, YES);
    
    CGContextAddPath(ctx, path);
    CGPathRelease(path);
    
    CGContextDrawPath(ctx, kCGPathFillStroke);
}

@end
