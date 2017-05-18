//
//  CSFDeviceFeatureManager.h
//  CetaceaSharedFramework
//
//  Created by Justin Fincher on 2017/5/10.
//
//

#import <Foundation/Foundation.h>


/**
 Manager for providing infomations for device capablitiy
 */
@interface CSFDeviceCapabilityManager : NSObject

#pragma mark - Singleton Methods
/// @brief Singleton Method
+ (id)sharedManager;

#pragma mark - iOS Methods
#if TARGET_OS_IOS

- (BOOL)isForceTouchAvailable;

#pragma mark - OSX Methods
#elif TARGET_OS_OSX

#endif

@end
