//
//  JZAboutWindowController.m
//  Cetacea-Mac
//
//  Created by Fincher Justin on 16/7/1.
//  Copyright © 2016年 JustZht. All rights reserved.
//

#import "JZAboutWindowController.h"

@interface JZAboutWindowController ()

@end

@implementation JZAboutWindowController

- (void)windowDidLoad {
    [super windowDidLoad];
    
    
    self.window.titlebarAppearsTransparent = YES;
    self.window.titleVisibility = NSWindowTitleHidden;
    self.window.acceptsMouseMovedEvents = YES;
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}

@end
