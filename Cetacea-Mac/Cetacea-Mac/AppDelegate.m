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

#import <HockeySDK/HockeySDK.h>
#import <Sparkle/Sparkle.h>

@interface AppDelegate ()<SUUpdaterDelegate>

@property (weak) IBOutlet SUUpdater *sparkleUpdater;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    
//    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
//    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
//    [NSUserDefaults resetStandardUserDefaults];

    [[BITHockeyManager sharedHockeyManager] configureWithIdentifier:@"e323c3d1d75240f89492b38042bfdbac"];
//    [[BITHockeyManager sharedHockeyManager].crashManager setAutoSubmitCrashReport: YES];
    [[BITHockeyManager sharedHockeyManager] startManager];

    
    // register to observe notifications from the store
    [[NSNotificationCenter defaultCenter]
     addObserver: self
     selector: @selector (storeDidChange:)
     name: NSUbiquitousKeyValueStoreDidChangeExternallyNotification
     object: [NSUbiquitousKeyValueStore defaultStore]];
    
    // get changes that might have happened while this
    // instance of your app wasn't running
    [[NSUbiquitousKeyValueStore defaultStore] synchronize];
    
    self.sparkleUpdater.sendsSystemProfile = YES;
    
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

#pragma mark - SUUpdaterDelegate
- (NSArray *)feedParametersForUpdater:(SUUpdater *)updater
                 sendingSystemProfile:(BOOL)sendingProfile
{
    return [[BITSystemProfile sharedSystemProfile] systemUsageData];
}
@end
