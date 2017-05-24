//
//  AppDelegate.m
//  Cetacea-iOS
//
//  Created by Justin Fincher on 2017/4/30.
//  Copyright © 2017年 Justin Fincher. All rights reserved.
//

#import "AppDelegate.h"
#import <Fabric/Fabric.h>
#import <Crashlytics/Crashlytics.h>
#import <CetaceaSharedFramework/CetaceaSharedFramework.h>
#import "JZNoticeEnableCloudServiceViewController.h"
#import <GDPerformanceView/GDPerformanceMonitor.h>
#import "JZDocumentImportViewController.h"

@interface AppDelegate ()

@property (nonatomic, strong) GDPerformanceMonitor *performanceMonitor;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [Fabric with:@[[Crashlytics class],[Answers class]]];
    [[CSFInitialProcessManager sharedManager] initialProcess];
    
#if DEBUG
    self.performanceMonitor = [[GDPerformanceMonitor alloc] init];
    [self.performanceMonitor setAppVersionHidden:YES];
    [self.performanceMonitor setDeviceVersionHidden:YES];
    [self.performanceMonitor startMonitoringWithConfiguration:^(UILabel *textLabel) {    }];
#endif

    CSF_Block_Add_Notification_Observer_With_Name_Object_Block(CSFStringNotificationiCloudNotAvailiableName,nil,^(NSNotification *notification)
                                                               {
                                                               });
    
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
	if (![[CSFiCloudSyncManager sharedManager] isIcloudAvailiable])
	{
		if (self.window.rootViewController.presentedViewController && [self.window.rootViewController.presentedViewController isKindOfClass:[UINavigationController class]] && [((UINavigationController *)self.window.rootViewController.presentedViewController).topViewController isKindOfClass:[JZNoticeEnableCloudServiceViewController class]])
		{
			return;
		}
		UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:CSF_Block_Main_Storyboard_VC_From_Identifier(NSStringFromClass([JZNoticeEnableCloudServiceViewController class]))];
		navController.modalPresentationStyle = UIModalPresentationFormSheet;
		[self.window.rootViewController presentViewController:navController animated:YES completion:nil];
	}
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    if (url)
    {
        NSLog(@"PATH = %@",[url path]);
        JZDocumentImportViewController *vc = CSF_Block_Main_Storyboard_VC_From_Identifier(NSStringFromClass([JZDocumentImportViewController class]));
        vc.importURL = url;
        UINavigationController *naviVC = [[UINavigationController alloc] initWithRootViewController:vc];
        
        [[[[UIApplication sharedApplication] keyWindow] rootViewController] presentViewController:naviVC animated:YES completion:nil];
    }
    return YES;
}

- (BOOL)application:(UIApplication *)application willContinueUserActivityWithType:(NSString *)userActivityType
{
    return YES;
}
- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray * _Nullable))restorationHandler
{
    return YES;
}

@end
