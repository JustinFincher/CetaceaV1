//
//  JZAutoThemeSwitchViewController.m
//  Cetacea-Mac
//
//  Created by Fincher Justin on 16/7/2.
//  Copyright © 2016年 JustZht. All rights reserved.
//

#import "JZAutoThemeSwitchViewController.h"
#import "JZdayNightThemeManager.h"

@interface JZAutoThemeSwitchViewController ()

@end

@implementation JZAutoThemeSwitchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    [self.view setWantsLayer:YES];

    [self setAppearanceName:[[JZdayNightThemeManager sharedManager] getShouldAppliedNSAppearanceName]];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(dayNightThemeSwitched:)
                                                 name:@"dayNightThemeSwitched"
                                               object:nil];
}

- (void)setAppearanceName:(NSString *)name
{
    if ([name isEqualToString: @"NSAppearanceNameVibrantDark"] )
    {
        [self setBackgroundColor:[NSColor colorWithWhite:0.2 alpha:1.0]];
    }else if ([name isEqualToString: @"NSAppearanceNameVibrantLight"] )
    {
        [self setBackgroundColor:[NSColor colorWithWhite:0.9 alpha:1.0]];
    }
}
    
- (void)dayNightThemeSwitched:(NSNotification *)aNotification
{
    NSString *color = [[aNotification userInfo] valueForKey:@"NSAppearanceName"];
    [self setAppearanceName:color];
}
- (void)setBackgroundColor:(NSColor*)backgroundColor
{
    [self.view.layer setBackgroundColor:[backgroundColor CGColor]];
}
@end
