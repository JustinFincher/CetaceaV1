//
//  JZSettingsApperanceViewController.m
//  Cetacea-Mac
//
//  Created by Fincher Justin on 16/7/1.
//  Copyright © 2016年 JustZht. All rights reserved.
//

#import "JZSettingsApperanceViewController.h"
#import "JZdayNightThemeManager.h"
#import "DateTools.h"
@interface JZSettingsApperanceViewController ()
@property (weak) IBOutlet NSPopUpButton *lightDarkThemeSwitchPopup;

@property (weak) IBOutlet NSDatePicker *sunriseTimePicker;
@property (weak) IBOutlet NSDatePicker *sunsetTimePicker;

@end

@implementation JZSettingsApperanceViewController
@synthesize sunriseTimePicker,sunsetTimePicker;

- (void)viewWillAppear
{
    [super viewWillAppear];
    
    [_lightDarkThemeSwitchPopup selectItemAtIndex:[[JZdayNightThemeManager sharedManager] getLocalStoredJZDayNightThemeSwithTypeIndex]];
    
    sunriseTimePicker.dateValue = [[JZdayNightThemeManager sharedManager] getSunriseTime];
    sunsetTimePicker.dateValue = [[JZdayNightThemeManager sharedManager] getSunsetTime];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    
}
- (CGSize)preferredMinimumSize
{
    return CGSizeMake(500, 180);
}

- (IBAction)lightDarkThemeSwitchPopup:(NSPopUpButton *)sender
{
    JZDayNightThemeSwithType type = [sender indexOfSelectedItem];
    [[JZdayNightThemeManager sharedManager] setDayNightThemeSwithType:type];
    if (type == JZDayNightThemeSwithTypeFollowTime)
    {
        sunriseTimePicker.enabled = YES;
        sunsetTimePicker.enabled = YES;
    }else
    {
        sunriseTimePicker.enabled = NO;
        sunsetTimePicker.enabled = NO;
    }
}
- (IBAction)sunsetTimePicker:(NSDatePicker *)sender
{
    [[JZdayNightThemeManager sharedManager] setSunsetTime:[sender dateValue]];
}
- (IBAction)sunriseTimePicker:(NSDatePicker *)sender
{
    [[JZdayNightThemeManager sharedManager] setSunriseTime:[sender dateValue]];
}

@end
