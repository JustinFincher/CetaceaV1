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

#import <Fabric/Fabric.h>
#import <Crashlytics/Crashlytics.h>

@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    
    
//    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];v
//    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
//    [NSUserDefaults resetStandardUserDefaults];

    [Fabric with:@[[Crashlytics class]]];

    
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

#pragma mark - NSDocumentController
- (IBAction)newDocument:(id)sender
{
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"addNewButtonPressedNotification" object:self userInfo:nil];
}
- (IBAction)openDocument:(id)sender
{
    
}
@end
