//
//  JZApplicationInfoManager.m
//  Cetacea
//
//  Created by Justin Fincher on 2017/3/31.
//  Copyright © 2017年 JustZht. All rights reserved.
//

#import "JZApplicationInfoManager.h"

@implementation JZApplicationInfoManager

#pragma mark Singleton Methods
+ (id)sharedManager {
    static JZApplicationInfoManager *sharedMyManager = nil;
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

- (void)dealloc {
    // Should never be called, but just here for clarity really.
}

- (NSString *)getAppVersion
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}
- (NSString *)getBuildNumber
{
     return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
}
- (NSString *)getAppVersionInfoAndBuildNumber
{
    return [NSString stringWithFormat:@"Ver %@ | Build %@",[self getAppVersion],[self getBuildNumber]];
}
@end
