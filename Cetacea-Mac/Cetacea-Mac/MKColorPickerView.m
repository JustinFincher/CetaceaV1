//
//  MKColorPickerView.m
//  Color Picker
//
//  Created by Mark Dodwell on 5/27/12.
//  Copyright (c) 2012 mkdynamic. All rights reserved.
//

#import "MKColorPickerView.h"
#import "MKColorSwatchMatrix.h"
#import "MKColorSwatchCell.h"
#import "MKColorWell.h"

#define COLORWELL_LABEL_HEIGHT 30

@implementation MKColorPickerView
@synthesize matrix,label;

//- (void)drawRect:(NSRect)dirtyRect
//{
//    [[NSColor darkGrayColor] setFill];
//    NSRectFill(dirtyRect);
//    [super drawRect:dirtyRect];
//}

- (id)initWithColors:(NSArray *)colors 
        numberOfRows:(NSInteger)rows 
     numberOfColumns:(NSInteger)columns 
          swatchSize:(NSSize)size
     targetColorWell:(MKColorWell *)aTargetColorWell
{
    NSSize spacing = NSMakeSize(1, 1);
    NSRect matrixFrame = NSMakeRect(spacing.width, spacing.height, 
                                    columns * size.width + ((columns - 1) * spacing.width), 
                                    rows * size.height + ((rows - 1)) * spacing.height);
    
    self = [self initWithFrame:NSInsetRect(matrixFrame, -spacing.width, -spacing.height)];
    
    if (self) {
        matrix = [[MKColorSwatchMatrix alloc] initWithFrame:matrixFrame 
                                               numberOfRows:rows 
                                            numberOfColumns:columns
                                                     colors:colors
                                            targetColorWell:aTargetColorWell];
        [matrix setIntercellSpacing:spacing];
        [matrix setCellSize:size];
        
        [self addSubview:matrix];
    } 
    
    return self;
}
- (id)initWithColors:(NSArray *)colors
        numberOfRows:(NSInteger)rows
     numberOfColumns:(NSInteger)columns
          swatchSize:(NSSize)size
     targetColorWell:(MKColorWell *)aTargetColorWell
           labelText:(NSString *)string
{
    NSSize spacing = NSMakeSize(1, 1);
    NSRect matrixFrame = NSMakeRect(spacing.width, spacing.height,
                                    columns * size.width + ((columns - 1) * spacing.width),
                                    rows * size.height + ((rows - 1)) * spacing.height);
    NSRect allFrame = NSMakeRect(spacing.width, spacing.height,
                                    columns * size.width + ((columns - 1) * spacing.width),
                                    rows * size.height + ((rows - 1)) * spacing.height + COLORWELL_LABEL_HEIGHT);
    NSRect labelFrame = NSMakeRect(matrixFrame.origin.x,matrixFrame.size.height, matrixFrame.size.width, COLORWELL_LABEL_HEIGHT - 5);
    
    self = [self initWithFrame:NSInsetRect(allFrame, -spacing.width, -spacing.height)];
    
    if (self) {
        matrix = [[MKColorSwatchMatrix alloc] initWithFrame:matrixFrame
                                               numberOfRows:rows
                                            numberOfColumns:columns
                                                     colors:colors
                                            targetColorWell:aTargetColorWell];
        [matrix setIntercellSpacing:spacing];
        [matrix setCellSize:size];
        
        label = [[NSTextField alloc] initWithFrame:labelFrame];
        label.stringValue = (string == nil)? @"":string;
        label.font = [NSFont boldSystemFontOfSize:12.0f];
        label.drawsBackground = NO;
        label.editable = NO;
        label.alignment = NSTextAlignmentCenter;
        label.textColor = [NSColor controlTextColor];
        label.bordered = NO;
        [self addSubview:matrix];
        [self addSubview:label];
    }
    
    return self;
}
@end
