//
//  JZOptionalScrollableView.m
//  Cetacea
//
//  Created by Justin Fincher on 2017/4/3.
//  Copyright © 2017年 JustZht. All rights reserved.
//

#import "JZOptionalScrollableView.h"


@implementation JZOptionalScrollableView

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

-(instancetype)initWithFrame:(NSRect)frameRect
{
    self = [super initWithFrame:frameRect];
    if (self)
    {
        [self setUpOnInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self)
    {
        [self setUpOnInit];
    }
    return self;
}

-(void)setUpOnInit
{
    self.scrollEnabled = YES;
}

-(void)scrollWheel:(NSEvent *)theEvent
{
    if (self.scrollEnabled)
    {
        [super scrollWheel:theEvent];
    }
    else {
        //scrolling is disabled.
    }
}

@end
