//
//  CSFDeviceFeatureManager.m
//  CetaceaSharedFramework
//
//  Created by Justin Fincher on 2017/5/10.
//
//

#import "CSFDeviceCapabilityManager.h"
#import "CSFGlobalHeader.h"


@implementation CSFDeviceCapabilityManager

#pragma mark Singleton Methods

+ (id)sharedManager
{
    static CSFDeviceCapabilityManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (id)init {
    if (self = [super init])
    {
        
    }
    return self;
}

- (void)dealloc
{
    
}

#if TARGET_OS_IOS
- (BOOL)isForceTouchAvailable
{
    UITraitCollection *traitCollection = [UIScreen mainScreen].traitCollection;
    BOOL isForceTouchAvailable = NO;
    if ([traitCollection respondsToSelector:@selector(forceTouchCapability)])
    {
        isForceTouchAvailable = traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable;
    }
    return isForceTouchAvailable;
}
- (BOOL)isTestFlightBuild
{
	return [[[[NSBundle mainBundle] appStoreReceiptURL] lastPathComponent] isEqualToString:@"sandboxReceipt"];
}
#elif TARGET_OS_OSX
#endif



@end
