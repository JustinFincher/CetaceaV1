//
//  JZEditorHighlightThemeColorDataModel.m
//  Cetacea
//
//  Created by Justin Fincher on 2017/3/31.
//  Copyright © 2017年 JustZht. All rights reserved.
//

#import "JZEditorHighlightThemeColorDataModel.h"

@implementation JZEditorHighlightThemeColorDataModel

- (id)initWithColor:(JZColor *)color
{
    self = [super initWithColor:color];
    [self addChangedObserver];
    return self;
}
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    [self addChangedObserver];
    return self;
}
- (void)addChangedObserver
{
    [RACObserve(self, color) subscribeNext:^(JZColor *newColor)
    {
        JZLog(@"new Color");
        [[NSNotificationCenter defaultCenter] postNotificationName:JZ_NOTIFICATION_HIGHLIGHT_THEME_COLOR_CHANGED object:newColor];
    }];
}
@end
