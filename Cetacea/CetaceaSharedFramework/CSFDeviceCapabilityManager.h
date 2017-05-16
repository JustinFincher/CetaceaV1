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

+ (id)sharedManager;

#if TARGET_OS_IOS

- (BOOL)isForceTouchAvailable;

#elif TARGET_OS_OSX

#endif

@end
