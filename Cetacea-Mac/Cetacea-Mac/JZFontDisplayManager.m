//
//  JZFontDisplayManager.m
//  Cetacea-Mac
//
//  Created by Fincher Justin on 16/7/3.
//  Copyright © 2016年 JustZht. All rights reserved.
//

#import "JZFontDisplayManager.h"
#import "JZdayNightThemeManager.h"

@interface JZFontDisplayManager()

@property (nonatomic) CGFloat fontSize;

@end

@implementation JZFontDisplayManager
@synthesize fontSize;


#pragma mark Singleton Methods

+ (id)sharedManager {
    static JZFontDisplayManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (id)init {
    if (self = [super init])
    {
        NSNumber *fontSizeNum = [[NSUserDefaults standardUserDefaults] objectForKey:@"fontSize"];
        if (fontSizeNum == nil)
        {
            fontSize = 12.0f;
        }else
        {
            fontSize = [fontSizeNum floatValue];
        }
    }
    return self;
}

- (void)dealloc {
    // Should never be called, but just here for clarity really.
}

#pragma mark - Font Getter Setter
- (NSFont *)getFont
{
    NSString *name = [[NSUserDefaults standardUserDefaults]
                    objectForKey:@"baseFontName"];
    NSNumber *size = [[NSUserDefaults standardUserDefaults]
                      objectForKey:@"baseFontSize"];
    
    NSFont *font = [NSFont fontWithName:name size:[size floatValue]];
    if (font)
    {
        return font;
    }else
    {
        //NSAssert(<#condition#>, <#desc, ...#>)
        return [NSFont systemFontOfSize:12.0f];
    }
}
- (NSString *)getFontFamilyName
{
    NSString *name = [[NSUserDefaults standardUserDefaults]
                      objectForKey:@"baseFontFamilyName"];
    return name;
}
- (NSString *)getFontName
{
    NSString *name = [[NSUserDefaults standardUserDefaults]
                      objectForKey:@"baseFontName"];
    return name;
}
- (CGFloat)getFontSize
{
    NSNumber *size = [[NSUserDefaults standardUserDefaults]
                      objectForKey:@"baseFontSize"];
    return [size floatValue];
}
- (NSFont *)getMonospacedFont
{
    return [NSFont fontWithName:@"Courier New" size:[self getFontSize]];
}
- (NSFont *)getBoldFont
{
    NSFont *bold = [[NSFontManager sharedFontManager] fontWithFamily:[self getFontFamilyName]
                                              traits:NSBoldFontMask
                                              weight:0
                                                size:[self getFontSize]];
    
    if (bold)
    {
        return bold;
    }
    else
    {
        
        return [self getFont];
    }
}
- (NSFont *)getItalicFont
{
    
    NSFont *italic = [[NSFontManager sharedFontManager] fontWithFamily:[self getFontFamilyName]
                                                              traits:NSItalicFontMask
                                                              weight:0
                                                                size:[self getFontSize]];
    if (italic)
    {
        return italic;
    }
    else
    {
        
        return [self getFont];
    }
}
- (NSFont *)getHeaderFont
{
    NSFont *header = [[NSFontManager sharedFontManager] fontWithFamily:[self getFontFamilyName]
                                                              traits:NSBoldFontMask
                                                              weight:0
                                                                size:[self getFontSize]*1.5];
    
    if (header)
    {
        return header;
    }
    else
    {
        
        return [self getFont];
    }
}
- (void)setFont:(NSFont *)font
{
    
    [[NSUserDefaults standardUserDefaults] setObject:[font fontName] forKey:@"baseFontName"];
    [[NSUserDefaults standardUserDefaults] setObject:[font familyName] forKey:@"baseFontFamilyName"];
    [[NSUserDefaults standardUserDefaults] setObject:[font displayName] forKey:@"baseFontDisplayName"];
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithFloat:[font pointSize]] forKey:@"baseFontSize"];
    if ([[NSUserDefaults standardUserDefaults] synchronize])
    {
        [[NSNotificationCenter defaultCenter]
         postNotificationName:@"baseFontChanged" object:self userInfo:nil];
    };

}
#pragma mark - Text Color 
- (NSColor *)getTextColor
{
    NSString *name = [[JZdayNightThemeManager sharedManager]getShouldAppliedNSAppearanceName];
    if ([name isEqualToString:@"NSAppearanceNameVibrantDark"])
    {
        return [NSColor colorWithWhite:0.9 alpha:1.0f];
    }else if ([name isEqualToString:@"NSAppearanceNameVibrantLight"])
    {
        return [NSColor colorWithWhite:0.2 alpha:1.0f];
    }else
    {
        return [NSColor grayColor];
    }
}
- (NSColor *)getLinkBackgroundColor
{
    NSString *name = [[JZdayNightThemeManager sharedManager]getShouldAppliedNSAppearanceName];
    if ([name isEqualToString:@"NSAppearanceNameVibrantDark"])
    {
        return [NSColor colorWithWhite:0.2 alpha:1.0f];
    }else if ([name isEqualToString:@"NSAppearanceNameVibrantLight"])
    {
        return [NSColor colorWithWhite:0.89 alpha:1.0f];
    }else
    {
        return [NSColor grayColor];
    }
}
- (NSColor *)getLinkForegroundColor
{
    NSString *name = [[JZdayNightThemeManager sharedManager]getShouldAppliedNSAppearanceName];
    if ([name isEqualToString:@"NSAppearanceNameVibrantDark"])
    {
        return [NSColor colorWithRed:0.4 green:0.4 blue:1.0f alpha:1.0f];
    }else if ([name isEqualToString:@"NSAppearanceNameVibrantLight"])
    {
        return [NSColor blueColor];
    }else
    {
        return [NSColor grayColor];
    }
}
- (NSColor *)getCodeBlockBackgroundColor
{
    return [self getLinkBackgroundColor];
}
- (NSColor *)getCodeBlockForegroundColor
{
    NSString *name = [[JZdayNightThemeManager sharedManager]getShouldAppliedNSAppearanceName];
    if ([name isEqualToString:@"NSAppearanceNameVibrantDark"])
    {
        return [NSColor colorWithRed:0.2f green:1.0f blue:0.2f alpha:1.0f];
    }else if ([name isEqualToString:@"NSAppearanceNameVibrantLight"])
    {
        return [NSColor colorWithRed:0.1f green:0.7f blue:0.1f alpha:1.0f];
    }else
    {
        return [NSColor grayColor];
    }
}
- (NSColor *)getRuleTextForegroundColor
{
    NSString *name = [[JZdayNightThemeManager sharedManager]getShouldAppliedNSAppearanceName];
    if ([name isEqualToString:@"NSAppearanceNameVibrantDark"])
    {
        return [NSColor colorWithWhite:1.0f alpha:1.0f];
    }else if ([name isEqualToString:@"NSAppearanceNameVibrantLight"])
    {
        return [NSColor colorWithWhite:0.0f alpha:1.0f];
    }else
    {
        return [NSColor grayColor];
    }
}
@end
