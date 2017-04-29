//
//  JZMainWindowController.m
//  Cetacea-Mac
//
//  Created by Fincher Justin on 16/6/27.
//  Copyright © 2016年 JustZht. All rights reserved.
//

#import "JZMainWindowController.h"


#import "JZiCloudStorageManager.h"
#import "JZdayNightThemeManager.h"

@interface JZMainWindowController ()
//@property (weak) IBOutlet NSButton *sideBarButton;
@property (weak) IBOutlet NSSegmentedControl *sideBarSwitch;
@property (weak) IBOutlet NSSegmentedControl *touchBarSideBarSwitch;

@end

@implementation JZMainWindowController

- (void)windowDidLoad {
    [super windowDidLoad];
    
    self.window.titlebarAppearsTransparent = YES;
    self.window.appearance = [NSAppearance appearanceNamed:[[JZdayNightThemeManager sharedManager] getShouldAppliedNSAppearanceName]];
    self.window.titleVisibility = NSWindowTitleHidden;
    //self.window.styleMask |= NSFullSizeContentViewWindowMask;
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    
    NSURL *iCloudURL = [[JZiCloudStorageManager sharedManager] ubiquitousURL];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(dayNightThemeSwitched:)
                                                 name:@"dayNightThemeSwitched"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(sideBarSegmentWillSelectNotification:)
                                                 name:@"sideBarSegmentWillSelectNotification"
                                               object:nil];


    self.touchBarSideBarSwitch.selectedSegment = 0;
}
- (void)dayNightThemeSwitched:(NSNotification *)aNotification
{
    self.window.appearance = [NSAppearance appearanceNamed:[[aNotification userInfo] valueForKey:@"NSAppearanceName"]];
}
- (IBAction)addNewButtonPressed:(NSButton *)sender
{
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"addNewButtonPressedNotification" object:self userInfo:nil];

}
- (IBAction)siderBarSegmentSelected:(NSSegmentedControl *)sender
{
    NSSegmentedControl *segmentControl = (NSSegmentedControl *)sender;
    NSInteger selectInt = segmentControl.selectedSegment;
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"sideBarSegmentSelectedNotification" object:self userInfo:@{@"selectedSegment":[NSNumber numberWithInteger:selectInt]}];
}
- (IBAction)touchBarSiderBarSegmentSelected:(id)sender
{
    NSSegmentedControl *segmentControl = (NSSegmentedControl *)sender;
    NSInteger selectInt = segmentControl.selectedSegment;
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"sideBarSegmentSelectedNotification" object:self userInfo:@{@"selectedSegment":[NSNumber numberWithInteger:selectInt]}];
}

- (void)sideBarSegmentWillSelectNotification:(NSNotification *) notification
{
    NSDictionary *dict = [notification userInfo];
    NSNumber * selectNumber = (NSNumber *)[dict valueForKey:@"selectedSegment"];
    [self.sideBarSwitch setSelectedSegment:[selectNumber integerValue]];
    [self.touchBarSideBarSwitch setSelectedSegment:[selectNumber integerValue]];
}

- (IBAction)editorSegmentedControlChanged:(NSSegmentedControl *)sender
{
    NSSegmentedControl *segmentControl = (NSSegmentedControl *)sender;
    NSInteger selectInt = segmentControl.selectedSegment;
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"editPreviewSwithSegmentSelectedNotification" object:self userInfo:@{@"selectedSegment":[NSNumber numberWithInteger:selectInt]}];
}

@end
