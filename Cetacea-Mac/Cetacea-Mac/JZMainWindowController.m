//
//  JZMainWindowController.m
//  Cetacea-Mac
//
//  Created by Fincher Justin on 16/6/27.
//  Copyright © 2016年 JustZht. All rights reserved.
//

#import "JZMainWindowController.h"


#import "JZiCloudStorageManager.h"

@interface JZMainWindowController ()
@property (weak) IBOutlet NSButton *sideBarButton;

@end

@implementation JZMainWindowController

- (void)windowDidLoad {
    [super windowDidLoad];
    
    self.window.titlebarAppearsTransparent = YES;
    self.window.appearance = [NSAppearance appearanceNamed:NSAppearanceNameVibrantDark];
    self.window.titleVisibility = NSWindowTitleHidden;
    //self.window.styleMask |= NSFullSizeContentViewWindowMask;
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    
    NSURL *iCloudURL = [[JZiCloudStorageManager sharedManager] ubiquitousURL];
    
    
    [self.sideBarButton sendActionOn:NSLeftMouseUpMask];
}

- (IBAction)sideBarButtonPressed:(NSButton *)sender
{
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"sideBarButtonPressedNotification" object:self userInfo:@{@"buttonState":[NSNumber numberWithInteger:sender.state]}];
}


@end
