//
//  JZSettingsApperanceViewController.m
//  Cetacea-Mac
//
//  Created by Fincher Justin on 16/7/1.
//  Copyright © 2016年 JustZht. All rights reserved.
//

#import "JZSettingsApperanceViewController.h"
#import "JZdayNightThemeManager.h"
@interface JZSettingsApperanceViewController ()
@property (weak) IBOutlet NSPopUpButton *lightDarkThemeSwitchPopup;
@end

@implementation JZSettingsApperanceViewController

- (void)viewWillAppear
{
    [super viewWillAppear];
    
    [_lightDarkThemeSwitchPopup selectItemAtIndex:[[JZdayNightThemeManager sharedManager] getLocalStoredJZDayNightThemeSwithTypeIndex]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    
}
- (CGSize)preferredMinimumSize
{
    return CGSizeMake(500, 400);
}

- (IBAction)lightDarkThemeSwitchPopup:(NSPopUpButton *)sender
{
    JZDayNightThemeSwithType type = [sender indexOfSelectedItem];
    [[JZdayNightThemeManager sharedManager] setDayNightThemeSwithType:type];
}

@end
