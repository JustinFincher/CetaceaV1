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
@property (weak) IBOutlet NSButton *sideBarButton;

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
    
    
    [self.sideBarButton sendActionOn:NSLeftMouseUpMask];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(dayNightThemeSwitched:)
                                                 name:@"dayNightThemeSwitched"
                                               object:nil];

}
- (void)dayNightThemeSwitched:(NSNotification *)aNotification
{
    self.window.appearance = [NSAppearance appearanceNamed:[[aNotification userInfo] valueForKey:@"NSAppearanceName"]];
}
- (IBAction)addNewButtonPressed:(NSButton *)sender
{
    
}
- (IBAction)siderBarSegmentSelected:(NSSegmentedControl *)sender
{
    NSSegmentedControl *segmentControl = (NSSegmentedControl *)sender;
    NSInteger selectInt = segmentControl.selectedSegment;
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"sideBarSegmentSelectedNotification" object:self userInfo:@{@"selectedSegment":[NSNumber numberWithInteger:selectInt]}];
}

- (IBAction)editorSegmentedControlChanged:(NSSegmentedControl *)sender
{
    NSSegmentedControl *segmentControl = (NSSegmentedControl *)sender;
    NSInteger selectInt = segmentControl.selectedSegment;
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"editPreviewSwithSegmentSelectedNotification" object:self userInfo:@{@"selectedSegment":[NSNumber numberWithInteger:selectInt]}];
}

@end
