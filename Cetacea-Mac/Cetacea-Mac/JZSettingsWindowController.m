//
//  JZSettingsWindowController.m
//  Cetacea-Mac
//
//  Created by Fincher Justin on 16/7/1.
//  Copyright © 2016年 JustZht. All rights reserved.
//

#import "JZSettingsWindowController.h"

@interface JZSettingsWindowController ()<NSToolbarDelegate>

@end

@implementation JZSettingsWindowController

- (void)windowDidLoad {
    [super windowDidLoad];
    
    self.window.appearance = [NSAppearance appearanceNamed:NSAppearanceNameVibrantDark];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}

@end
