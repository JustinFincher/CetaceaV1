//
//  CSFInitialProcessManager.m
//  CetaceaSharedFramework
//
//  Created by Justin Fincher on 2017/5/5.
//
//

#import "CSFInitialProcessManager.h"
#import "CSFiCloudSyncManager.h"

@implementation CSFInitialProcessManager

#pragma mark Singleton Methods

+ (id)sharedManager {
    static CSFiCloudSyncManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (id)init {
    if (self = [super init])
    {
        [CSFiCloudSyncManager sharedManager];
    }
    return self;
}

- (void)dealloc
{
    
}

- (void)report
{
    
}
@end
