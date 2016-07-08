//
//  JZHighlighThemePreviewCollectionViewItem.m
//  Cetacea-Mac
//
//  Created by Fincher Justin on 16/7/8.
//  Copyright © 2016年 JustZht. All rights reserved.
//

#import "JZHighlighThemePreviewCollectionViewItem.h"

@interface JZHighlighThemePreviewCollectionViewItem ()

@property (nonatomic,strong) NSShadow *shadow;
@property (weak) IBOutlet NSView *shadowView;

@end

@implementation JZHighlighThemePreviewCollectionViewItem

- (void)initWithisAddButton:(BOOL)isAdd
                      Image:(NSImage *)img
      backgroundShadowColor:(NSColor *)color
                  themeName:(NSString *)string
{
    self.view.wantsLayer = YES;
    [_themePic setWantsLayer:YES];
    _themePic.layer.masksToBounds = YES;
    
    if (_shadow == nil)
    {
        _shadow = [[NSShadow alloc] init];
    }
    [_shadow setShadowOffset:NSMakeSize(0, -3.0)];
    [_shadow setShadowBlurRadius:10.0f];
    if (isAdd)
    {
        self.themeName.stringValue = @"Add New";
        self.themePic.image = [NSImage imageNamed:@"JZAddNewTheme"];
        _shadow.shadowColor = [NSColor blueColor];
    }else
    {
        self.themeName.stringValue = string;
        self.themePic.image = ((img == nil) ? [NSImage imageNamed:@"JZPlaceHolderTheme"] : img);
        _shadow.shadowColor = color;
    }

    [self.shadowView setWantsLayer:YES];
    self.shadowView.layer.backgroundColor = [NSColor whiteColor].CGColor;
    self.shadowView.layer.masksToBounds = NO;
    [self.shadowView setShadow:_shadow];
    [_themePic.layer setCornerRadius:5.0];
    _themePic.layer.masksToBounds = YES;

}
@end
