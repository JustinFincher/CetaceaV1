//
//  AppDelegate.m
//  Cetacea-Mac
//
//  Created by Fincher Justin on 16/6/27.
//  Copyright © 2016年 JustZht. All rights reserved.
//

#import "AppDelegate.h"
#import "JZiCloudStorageManager.h"
#import "JZHeader.h"
@import HockeySDK;

@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    [[BITHockeyManager sharedHockeyManager] configureWithIdentifier:@"e323c3d1d75240f89492b38042bfdbac"];
    // Do some additional configuration if needed here
//    [[BITHockeyManager sharedHockeyManager] startManager];

    
    // register to observe notifications from the store
    [[NSNotificationCenter defaultCenter]
     addObserver: self
     selector: @selector (storeDidChange:)
     name: NSUbiquitousKeyValueStoreDidChangeExternallyNotification
     object: [NSUbiquitousKeyValueStore defaultStore]];
    
    // get changes that might have happened while this
    // instance of your app wasn't running
    [[NSUbiquitousKeyValueStore defaultStore] synchronize];
}
- (void)storeDidChange:(NSNotification *)aNotification
{
    JZLog(@"storeDidChange:(NSNotification *)aNotification");
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}
- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender
{
    return YES;
}
@end
